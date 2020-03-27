# frozen_string_literal: true

class Game < ApplicationRecord
  class TooManyCardsError < StandardError; end

  CARDS_PER_PLAYER = 10

  has_many :players, -> { order(:position) }

  has_many :card_games, -> { order(:position) }, dependent: :destroy
  has_many :cards, through: :card_games
  has_many :rounds, -> { order(:position) }, dependent: :destroy

  before_create :set_slug

  def to_param
    slug
  end

  def deck
    cards.where(card_games: { used: false })
  end

  def current_round
    rounds.last
  end

  def setup
    transaction do
      deck = Card.random.pluck(:id).map.with_index do |card_id, i|
        {
          game_id: id,
          card_id: card_id,
          position: i,
          created_at: Time.zone.now,
          updated_at: Time.zone.now
        }
      end

      CardGame.insert_all!(deck)

      rounds.create!(czar: players.first)
    end

    setup_player(players.first)
  end

  def add_player(player)
    return if player.in? players

    players.push(player)
    setup_player(player)

    broadcast_refresh
  end

  def setup_player(player)
    player.cards = []
    distribute_cards(player, count: CARDS_PER_PLAYER)
  end

  def distribute_cards(player, count: 1)
    # Ensure no more than CARDS_PER_PLAYER cards
    if player.cards.count + count > CARDS_PER_PLAYER
      raise TooManyCardsError,
            "#{player} already has #{player.cards.count} cards, you're adding #{count} more"
    end

    transaction do
      # Distribute [count] random cards
      new_cards = deck.white.limit(count)
      player.cards.push(new_cards)

      # Remove cards from the deck
      card_games.where(card: new_cards).update(used: true)
    end
  end

  def next_czar(offset: 0)
    # If the czar signs out!
    return players.first if current_round.czar.blank?

    current_czar_position = current_round.czar.position + offset

    if current_czar_position >= players.maximum(:position)
      players.first
    else
      players.where('position > ?', current_czar_position).first
    end
  end

  def broadcast_refresh
    GameChannel.broadcast_to(self, event: :refresh)
  end

  private

  def set_slug
    self.slug = SecureRandom.alphanumeric(5).upcase
  end
end

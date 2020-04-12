# frozen_string_literal: true

class Game < ApplicationRecord
  class TooManyCardsError < StandardError; end

  CARDS_PER_PLAYER = 10

  has_many :players, -> { order(:position) }

  has_many :card_games, dependent: :destroy
  has_many :used_cards, through: :card_games, source: :card
  has_many :rounds, -> { order(:position) }, dependent: :destroy
  has_many :submissions, through: :rounds
  has_many :options, dependent: :destroy

  before_create :set_slug

  def to_param
    slug
  end

  def deck
    Card.random.where.not(id: used_cards)
  end

  def current_round
    rounds.last
  end

  def setup
    add_player(Player.create_rando!) if rando_option?

    true
  end

  def add_player(player)
    return if player.in? players

    players.push(player)
    setup_player(player)
    update!(max_players: players.count)

    broadcast_refresh
  end

  def setup_player(player)
    player.cards = []
    pick_cards(player, count: CARDS_PER_PLAYER)
  end

  def pick_cards(player, count: 1)
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
      used_cards.push(new_cards)
    end
  end

  def next_czar(offset: 0)
    # If the czar signs out!
    return players.not_rando.first if current_round.czar.blank?

    return current_round.czar if mc_czar_option?

    current_czar_position = current_round.czar.position + offset

    if current_czar_position >= players.not_rando.maximum(:position)
      players.not_rando.first
    else
      players.not_rando.where('position > ?', current_czar_position).first
    end
  end

  def broadcast_refresh
    data = { event: :refresh }

    # Experimenting with asynchronous broadcasting
    if Flipper.enabled?(:async_broadcast)
      BroadcastWorker.perform_async(id, data)
    else
      GameChannel.broadcast_to(self, data)
    end

    true
  end

  def mc_czar_option?
    options.pluck(:code).include?(Option::MC_CZAR[:code])
  end

  def rando_option?
    options.pluck(:code).include?(Option::RANDO_CARDRISSIAN[:code])
  end

  def rando
    return unless rando_option?

    players.find_by!(rando: true)
  end

  # Returns a hash of player_id to winning submission count
  # { 123 => 2, 456 => 1 }
  def scores
    @scores ||= begin
      scores = submissions.winning.reorder(:player_id).group(:player_id).count
      scores.default = 0
      scores
    end
  end

  private

  def set_slug
    self.slug = SecureRandom.alphanumeric(5).upcase
  end
end

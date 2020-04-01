# frozen_string_literal: true

class Round < ApplicationRecord
  include AASM

  belongs_to :game, touch: true
  belongs_to :czar, class_name: 'Player', optional: true
  belongs_to :black_card, optional: true

  has_many :submissions, -> { order(:position) }, dependent: :destroy

  acts_as_list scope: :game

  aasm column: :status do
    state :starting, initial: true
    state :picking_black_card
    state :playing_black_card
    state :reading_the_cards
    state :ended

    event :pick_black_card, before: :pick_new_black_card do
      transitions from: :starting, to: :picking_black_card
    end

    event :play_black_card, after: [:play_rando, :broadcast_refresh] do
      transitions from: :picking_black_card, to: :playing_black_card
    end

    event :read_the_cards, after: :broadcast_refresh do
      transitions from: :playing_black_card, to: :reading_the_cards
    end

    event :award_submission, after: :broadcast_refresh do
      transitions from: :reading_the_cards, to: :ended
    end

    event :force_end, after: :broadcast_refresh do
      transitions to: :ended
    end
  end

  BLACK_CARD_VISIBLE = [
    STATE_PLAYING_BLACK_CARD,
    STATE_READING_THE_CARDS,
    STATE_ENDED
  ].freeze

  after_commit :broadcast_refresh, on: :create

  delegate :broadcast_refresh, to: :game

  def pick_new_black_card
    transaction do
      new_black_card = game.deck.black.first
      update!(black_card: new_black_card)

      # Remove card from the deck
      game.used_cards.push(new_black_card)
    end
  end

  def play_rando
    return unless game.rando_option?

    rando = game.rando

    card = rando.cards.random.first
    rando.play_card(card: card, round: self)
  end
end

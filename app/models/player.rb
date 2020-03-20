# frozen_string_literal: true

class Player < ApplicationRecord
  belongs_to :game, optional: true

  has_many :card_players, -> { order(:position) }, dependent: :destroy
  has_many :cards, through: :card_players
  has_many :submissions, dependent: :destroy

  before_create :set_token

  acts_as_list scope: :game

  validates :name, presence: true

  def to_s
    name
  end

  def winning_submissions_for(game)
    submissions.joins(:round).where(rounds: { game_id: game }).where(won: true)
  end

  private

  def set_token
    self.token = SecureRandom.base64
  end
end

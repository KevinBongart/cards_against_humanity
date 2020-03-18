class Submission < ApplicationRecord
  belongs_to :player
  belongs_to :round
  belongs_to :card

  acts_as_list scope: :round

  after_commit :broadcast_refresh, on: :create

  delegate :broadcast_refresh, to: :round

  scope :winning, -> { where(won: true) }
end

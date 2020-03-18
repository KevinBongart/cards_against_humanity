class Card < ApplicationRecord
  scope :black,  -> { where(type: BlackCard.name) }
  scope :white,  -> { where(type: WhiteCard.name) }
  scope :random, -> { order("RANDOM()") }

  def to_s
    text
  end
end

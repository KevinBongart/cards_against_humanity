# frozen_string_literal: true

class Card < ApplicationRecord
  belongs_to :pack

  scope :black,  -> { where(type: BlackCard.name) }
  scope :white,  -> { where(type: WhiteCard.name) }
  scope :random, -> { order('RANDOM()') }

  def to_s
    text
  end
end

# frozen_string_literal: true

class CardGame < ApplicationRecord
  belongs_to :card
  belongs_to :game
end

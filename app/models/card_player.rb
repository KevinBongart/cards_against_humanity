# frozen_string_literal: true

class CardPlayer < ApplicationRecord
  belongs_to :card
  belongs_to :player

  acts_as_list scope: :player
end

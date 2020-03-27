class Option < ApplicationRecord
  belongs_to :game

  ALL = [
    MC_CZAR = {
      code: 'mc_czar',
      name: 'MC Czar',
      description: 'The person who creates the game stays the Card Czar and hosts every round.'
    },
    RANDO_CARDRISSIAN = {
      code: 'rando_cardrissian',
      name: 'Rando Cardrissian',
      description: 'Every round, pick one random White Card from the pile and place it into play. This card belongs to an imaginary player named Rando Cardrissian, and if he wins the game, all players go home in a state of everlasting shame.'
    }
  ]

  def to_s
    from_code[:name]
  end

  def description
    from_code[:description]
  end

  private

  def from_code
    ALL.find { |option| option[:code] == code }
  end
end

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
      description: 'An imaginary player named Rando Cardrissian joins your game, and if he wins, all players go home in a state of everlasting shame.'
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

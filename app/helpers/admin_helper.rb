# frozen_string_literal: true

module AdminHelper
  def row_class(game)
    'table-success' if lots_of_players?(game) || lots_of_rounds?(game)
  end

  def lots_of_players?(game)
    game.max_players >= 18
  end

  def lots_of_rounds?(game)
    game.rounds.size >= 80
  end
end

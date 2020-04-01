module Admin
  class ActivityController < AdminController
    def show
      game_ids = Round.where('updated_at > ?', 1.day.ago).distinct.pluck(:game_id)

      @games = Game.where(id: game_ids).order(created_at: :desc).includes(:rounds, :options).select do |game|
        game.max_players > 1 && game.rounds.many?
      end
    end
  end
end

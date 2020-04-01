module Admin
  class ActivityController < AdminController
    LIMIT = 7.days
    def show
      @games = Game
        .where('max_players > 1')
        .where('updated_at > ?', LIMIT.ago)
        .order(updated_at: :desc)
        .includes(:rounds, :options)
        .select { |game| game.rounds.many? }
    end
  end
end

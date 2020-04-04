# frozen_string_literal: true

module Admin
  class ActivitiesController < AdminController
    LIMIT = 2.days

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

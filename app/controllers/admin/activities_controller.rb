# frozen_string_literal: true

module Admin
  class ActivitiesController < AdminController
    LIMIT = 1.day

    def show
      @current_games = Game
        .where('max_players > 1')
        .where('updated_at > ?', 5.minutes.ago)
        .order(updated_at: :desc)
        .includes(:rounds, :options)
        .select { |game| game.rounds.many? }

      @games = Game
        .where('max_players > 1')
        .where('updated_at > ?', LIMIT.ago)
        .order(updated_at: :desc)
        .includes(:rounds, :options)
        .select { |game| game.rounds.many? }

      @all_games = Game.where('max_players > 1')
      @all_rounds = Round.joins(:game).merge(@all_games)
    end
  end
end

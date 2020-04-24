# frozen_string_literal: true

class GamesController < ApplicationController
  skip_before_action :authenticate, only: [:new, :create]
  before_action :set_game, only: [:show]

  # GET /games/new
  def new
    @game = Game.new
    @options = Option::ALL.map { |option| Option.new(code: option[:code]) }
  end

  # POST /games
  def create
    params = game_params
    params.merge!(players: [@current_player]) if @current_player
    params.merge(creatorid: @current_player)

    options = params.delete(:options).select(&:present?).map do |option|
      Option.new(code: option)
    end

    params.merge!(options: options) if options.any?
logger.info(options)

    @game = Game.new(params)
logger.info(params)
    if @game.save && @game.setup
      redirect_to @game
    else
      @options = Option::ALL.map { |option| Option.new(code: option[:code]) }

      render :new
    end
  end

  # GET /games/1
  def show
    @game.add_player(@current_player) if @game.players.empty?
    @game.rounds.create!(czar: @current_player) if @game.rounds.empty?

    redirect_to game_round_path(@game)
  end

  # POST /games/find
  def find
    @game = Game.find_by(game_params)

    if @game
      redirect_to @game
    else
      redirect_to root_path, alert: "We couldn't find this game, are you sure it's the right code?"
    end
  end

  private

  def set_game
    @game = Game.find_by(slug: params[:id])
    if @game.creatorid != ""
    @game.update_attribute(:creatorid, @current_player.id) 
    @game.save
    end
    redirect_to root_path if @game.blank?
  end

  # Only allow a list of trusted parameters through.
  def game_params
    params.require(:game).permit(:creatorid, :slug, options: [])
  end
end

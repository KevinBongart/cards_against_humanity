# frozen_string_literal: true

class RoundsController < ApplicationController
  before_action :set_game
  before_action :set_round
  before_action :authorize_player, except: [:show]
  before_action :authorize_czar, only: [:advance, :skip_black_card]

  # GET /games/1/round
  def show
    @players = @game.players

    unless @players.to_a.include?(@current_player)
      @game.add_player(@current_player)
      @players = @game.players
    end

    @hand = @current_player.card_players.includes(:card)
    @submission = @current_player.submissions.find_by(round: @round)
    @submissions = @round.submissions.includes(:card)
    @scores = @game.scores

    @winning_submission = @round.submissions.winning.first if @round.ended?
  end

  # POST /games/1/round
  def create
    new_czar = @game.next_czar
    @round = @game.rounds.create!(czar: new_czar)

    redirect_to game_round_path(@game)
  end

  # POST /games/1/round/advance
  def advance
    case @round.status.to_sym
    when Round::STATE_STARTING
      @round.pick_black_card!
    when Round::STATE_PICKING_BLACK_CARD
      @round.play_black_card!
    when Round::STATE_PLAYING_BLACK_CARD
      @round.submissions = @round.submissions.shuffle
      @round.read_the_cards!
    when Round::STATE_READING_THE_CARDS
      submission = @round.submissions.find(params[:submission_id])
      submission.update!(won: true)
      @round.award_submission!
    end

    redirect_to game_round_path(@game)
  end

  # POST /games/1/round/play_card?card_id=123
  def play_card
    card = @current_player.cards.find(params[:card_id])
    @current_player.play_card(card: card, round: @round)

    redirect_to game_round_path(@game)
  rescue ActiveRecord::RecordNotFound => e
    Rails.logger.debug("[#{@game.slug}] Card##{params[:card_id]} not found")
    redirect_to game_round_path(@game)
  end

  # POST /games/1/round/skip_black_card
  def skip_black_card
    @round.pick_new_black_card

    redirect_to game_round_path(@game)
  end

  # POST /games/1/round/next_card_in_hand
  def prev_card_in_hand
    @current_player.card_players.last.move_to_top

    redirect_to game_round_path(@game)
  end

  # POST /games/1/round/next_card_in_hand
  def next_card_in_hand
    @current_player.card_players.first.move_to_bottom

    redirect_to game_round_path(@game)
  end

  # POST /games/1/round/prev_submission
  def prev_submission
    @round.submissions.last.move_to_top

    redirect_to game_round_path(@game)
  end

  # POST /games/1/round/next_submission
  def next_submission
    @round.submissions.first.move_to_bottom

    redirect_to game_round_path(@game)
  end

  # POST /games/1/round/end
  def end
    if @round.ended?
      new_czar = @game.next_czar(offset: 1)
      @game.rounds.create!(czar: new_czar)
    else
      @round.force_end!
    end

    redirect_to game_round_path(@game)
  end

  private

  def set_game
    @game = Game.find_by(slug: params[:game_id])

    redirect_to root_path if @game.blank?
  end

  def set_round
    @round = @game.current_round
  end

  def authorize_player
    return if @current_player.in? @game.players

    redirect_to game_round_path(@game)
  end

  def authorize_czar
    return if @current_player == @round.czar

    redirect_to game_round_path(@game)
  end
end

# frozen_string_literal: true

class PlayersController < ApplicationController
  skip_before_action :authenticate, only: [:new, :create]

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      cookies.permanent.encrypted[:player_token] = @player.token
      redirect_to session[:return_path].presence || root_path
    else
      render :new
    end
  end

  def destroy
    @player = Player.find(params[:id])
    
    if @player.id == @current_player.id
      @current_player.destroy
      redirect_to root_path

    else
      @player.destroy
      broadcast_refresh

    end
    #redirect_to game_round_path(@current_player.game)
  end
  def broadcast_refresh
    data = { event: :refresh }
    BroadcastWorker.perform_async(@current_player.game.id, data)
  end
  def toggle_hand_style
    @current_player.toggle!(:expand_hand)

    redirect_to game_round_path(@current_player.game)
  end

  private

  def player_params
    params.require(:player).permit(:name)
  end
end

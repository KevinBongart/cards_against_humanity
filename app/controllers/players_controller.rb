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

      # Can't redirect to a POST path
      redirect_path = session[:return_path].presence || root_path
      if redirect_path == games_path
        redirect_path = create_after_signup_games_path
      end
      redirect_to redirect_path
    else
      render :new
    end
  end

  def destroy
    cookies.delete(:player_token)
    @current_player.destroy

    redirect_to root_path
  end

  private

  def player_params
    params.require(:player).permit(:name)
  end
end

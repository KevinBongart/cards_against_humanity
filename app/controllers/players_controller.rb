class PlayersController < ApplicationController
  skip_before_action :authenticate, only: [:new, :create]

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      cookies.encrypted[:player_token] = @player.token

      # Can't redirect to a POST path
      redirect_path = session[:return_path].presence || root_path
      redirect_path = create_after_signup_games_path if redirect_path == games_path
      redirect_to redirect_path
    else
      render :new
    end
  end

  def destroy
    @current_player.destroy
    cookies.encrypted[:player_token] = nil

    redirect_to root_path
  end

  private

  def player_params
    params.require(:player).permit(:name)
  end
end

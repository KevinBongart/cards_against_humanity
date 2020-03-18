class PlayersController < ApplicationController
  skip_before_action :set_current_player

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      cookies.encrypted[:player_token] = @player.token
      redirect_to session[:return_path].presence || root_path
    else
      render :new
    end
  end

  private

  def player_params
    params.require(:player).permit(:name)
  end
end

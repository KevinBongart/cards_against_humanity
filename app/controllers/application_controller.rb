class ApplicationController < ActionController::Base
  before_action :set_current_player

  private

  def set_current_player
    token = cookies.encrypted[:player_token]

    @current_player = Player.find_by(token: token) if token.present?

    if @current_player.blank?
      cookies.encrypted[:player_token] = nil
      session[:return_path] = request.path

      redirect_to new_player_path
    end
  end
end

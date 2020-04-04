# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_current_player
  before_action :authenticate

  private

  def set_current_player
    token = cookies.encrypted[:player_token]
    @current_player = Player.find_by(token: token) if token.present?
  end

  def authenticate
    return unless @current_player.blank?

    cookies.delete(:player_token)
    session[:return_path] = request.path

    redirect_to new_player_path
  end
end

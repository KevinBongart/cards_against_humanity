class GameChannel < ApplicationCable::Channel
  def subscribed
    game = Game.find_by!(slug: params[:slug])
    stream_for game
  end
end

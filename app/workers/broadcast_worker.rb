class BroadcastWorker
  include Sidekiq::Worker

  def perform(game_id, data)
    game = Game.find(game_id)
    GameChannel.broadcast_to(game, data)
  end
end

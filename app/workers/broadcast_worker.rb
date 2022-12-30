class BroadcastWorker
  include Sidekiq::Worker

  def perform(args)
    game = Game.find(args['game_id'])
    GameChannel.broadcast_to(game, args['data'])
  end
end

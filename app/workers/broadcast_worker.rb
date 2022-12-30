class BroadcastWorker
  include Sidekiq::Worker

  def perform(args)
    game = Game.find(args['game_id'])
    GameChannel.broadcast_to(game, { event: args['event'] })
  end
end

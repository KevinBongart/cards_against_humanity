namespace :db do
  desc "Deletes old games"
  task delete_old_games: :environment do
    expiration = 1.hour

    Game.find_each do |game|
      ended_at = game.rounds.last.updated_at

      if ended_at < expiration.ago
        Game.transaction do
          Rails.logger.debug "Deleting Game##{game.id} which ended at #{ended_at}"

          game.players.find_each do |player|
            Rails.logger.debug "  Resetting Player##{player.id}"

            player.update!(game: nil)
            player.card_players.destroy
          end

          game.destroy

          Rails.logger.debug "Done deleting Game##{game.id}"
        end
      end
    end
  end
end

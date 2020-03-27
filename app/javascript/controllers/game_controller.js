import { Controller } from "stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static targets = [ "players" ]

  connect() {
    var game_slug = document.getElementById('game').dataset.slug

    this.subscription = consumer.subscriptions.create({ channel: "GameChannel", slug: game_slug }, {
      connected() {
        console.log('connected');
      },

      received(data) {
        if (data.event == 'refresh') {
          location.reload();
        }
      }
    })
  }
}

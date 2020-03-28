import { Controller } from "stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  connect() {
    var game_slug = document.getElementById('game').dataset.slug

    this.subscription = consumer.subscriptions.create({ channel: "GameChannel", slug: game_slug }, {
      received(data) {
        if (data.event == 'refresh') {
          Turbolinks.visit(location.toString());
        }
      }
    })
  }
}

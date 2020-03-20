// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import "controllers"
import * as Swing from "swing"

document.addEventListener('turbolinks:load', function() {
  // Prepare the cards in the stack for iteration.
  const cards = [].slice.call(document.querySelectorAll('#hand .card'));

  // An instance of the Stack is used to attach event listeners.
  const stack = Swing.Stack();

  cards.forEach((targetElement) => {
    // Add card element to the Stack.
    stack.createCard(targetElement);
    targetElement.classList.add('in-deck');
  });

  // Add event listener for when a card is thrown out of the stack.
  stack.on('throwout', (event) => {
    // e.target Reference to the element that has been thrown out of the stack.
    // e.throwDirection Direction in which the element has been thrown (Direction.LEFT, Direction.RIGHT).

    var xhr = new XMLHttpRequest();
    // /games/EKFQS/round/next_card_in_hand
    xhr.open("POST", location.pathname+'/next_card_in_hand');
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.setRequestHeader('X-CSRF-Token', document.getElementsByName('csrf-token')[0].content);
    xhr.send();
  });

  stack.on('throwoutend', (event) => {
    stack.getCard(event.target).throwIn()
    event.target.parentNode.appendChild(event.target)
  })
});
# frozen_string_literal: true

require 'rails_helper'

describe 'Game with MC Czar option' do
  it 'works' do
    Capybara.using_session('player_1') do
      visit '/'
      check 'MC Czar'

      click_button 'Start a new game'

      expect(Game.first.options.count).to eq(1)
      expect(Game.first.options.first.code).to eq(Option::MC_CZAR[:code])

      fill_in 'How should we call you?', with: 'Batman'
      click_button "Let's go"

      expect(page).to have_content "Hey, you're the Card Czar this round."

      click_button 'Pick a black card'
      click_button 'Play this card'
    end

    game = Game.first

    Capybara.using_session('player_2') do
      visit short_game_path(game)

      fill_in 'How should we call you?', with: 'Robin'
      click_button "Let's go"
      click_link 'Play this card'
    end

    Capybara.using_session('player_3') do
      visit short_game_path(game)

      fill_in 'How should we call you?', with: 'Alfred'
      click_button "Let's go"
      click_link 'Play this card'
    end

    Capybara.using_session('player_1') do
      refresh

      expect(page).to have_content("✔ Robin")
      expect(page).to have_content("✔ Alfred")

      click_button 'Pick a winner'
      click_link 'Award'

      expect(page).to have_content(/Card Czar Batman chose (Robin|Alfred)'s tasteless card./)
      expect(page).not_to have_content('The next Card Czar is Batman.')

      # Batman is still the Card Czar
      click_button "I'm ready"
      click_button "Pick a black card"
      click_button 'Play this card'
    end

    Capybara.using_session('player_2') do
      refresh
      click_link 'Play this card'
    end

    Capybara.using_session('player_3') do
      refresh
      click_link 'Play this card'
    end

    Capybara.using_session('player_1') do
      refresh

      click_button 'Pick a winner'
      click_link 'Award'

      expect(page).to have_content(/Card Czar Batman chose (Robin|Alfred)'s tasteless card./)

      # Batman is still the Card Czar
      click_button "I'm ready"
      click_button "Pick a black card"
      click_button 'Play this card'
    end
  end
end

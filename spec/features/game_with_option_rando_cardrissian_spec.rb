# frozen_string_literal: true

require 'rails_helper'

describe 'Game with Rando Cardrissian option' do
  it 'works' do
    Capybara.using_session('player_1') do
      visit '/'
      check 'Rando Cardrissian'

      click_button 'Start a new game'

      expect(Game.first.options.count).to eq(1)
      expect(Game.first.options.first.code).to eq(Option::RANDO_CARDRISSIAN[:code])
      expect(Game.first.players.first.name).to eq('Rando')

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

    Capybara.using_session('player_1') do
      refresh

      expect(page).to have_content("✔ Robin")
      expect(page).to have_content("✔ Rando")

      click_button 'Pick a winner'
      click_link 'Award'

      expect(page).to have_content(/Card Czar Batman chose (Robin|Rando)'s tasteless card./)
      expect(page).to have_content('The next Card Czar is Robin.')
    end

    # Round 2

    Capybara.using_session('player_2') do
      refresh

      click_button "I'm ready"
      click_button "Pick a black card"
      click_button 'Play this card'
    end

    Capybara.using_session('player_1') do
      refresh
      click_link 'Play this card'
    end

    Capybara.using_session('player_2') do
      refresh

      expect(page).to have_content("✔ Batman")
      expect(page).to have_content("✔ Rando")

      click_button 'Pick a winner'
      click_link 'Award'

      expect(page).to have_content(/Card Czar Robin chose (Batman|Rando)'s tasteless card./)
      expect(page).to have_content('The next Card Czar is Batman.')
    end

    Capybara.using_session('player_1') do
      refresh

      click_button "I'm ready"
      click_button "Pick a black card"
      click_button 'Play this card'
    end
  end
end

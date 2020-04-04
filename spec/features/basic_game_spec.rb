# frozen_string_literal: true

require 'rails_helper'

describe 'Basic game' do
  context 'new user' do
    it 'works' do
      # Round 1

      Capybara.using_session('player_1') do
        visit '/'

        click_button 'Start a new game'
        fill_in 'How should we call you?', with: 'Batman'
        click_button "Let's go"

        expect(page).to have_content "Hey, you're the Card Czar this round."

        click_button 'Pick a black card'
        click_button 'Play this card'
      end

      game = Game.first
      black_card = game.current_round.black_card

      Capybara.using_session('player_2') do
        visit short_game_path(game)

        fill_in 'How should we call you?', with: 'Robin'
        click_button "Let's go"

        expect(page).to have_content black_card.text

        click_link '→'
        click_link 'Play this card'
      end

      Capybara.using_session('player_3') do
        visit short_game_path(game)

        fill_in 'How should we call you?', with: 'Alfred'
        click_button "Let's go"

        expect(page).to have_content black_card.text

        click_link '←'
        click_link 'Play this card'
      end

      Capybara.using_session('player_1') do
        refresh

        expect(page).to have_content('✔ Robin')
        expect(page).to have_content('✔ Alfred')

        click_button 'Pick a winner'
        click_link '→'
        click_link 'Award'

        expect(page).to have_content('Robin 1') # Robin won 1 point
        expect(page).to have_content(/Card Czar Batman chose (Robin|Alfred)'s tasteless card./)
        expect(page).to have_content('The next Card Czar is Robin.')
      end

      # Round 2

      Capybara.using_session('player_2') do
        refresh

        click_button "I'm ready"
        click_button 'Pick a black card'
        click_link 'skip this card' # Robin is the worst, so of course he skips cards
        click_button 'Play this card'
      end

      Capybara.using_session('player_1') do
        refresh
        click_link 'Play this card'
      end

      Capybara.using_session('player_3') do
        refresh
        click_link 'Play this card'
      end

      Capybara.using_session('player_2') do
        refresh

        click_button 'Pick a winner'
        click_link 'Award'

        expect(page).to have_content(/Card Czar Robin chose (Batman|Alfred)'s tasteless card./)
        expect(page).to have_content('The next Card Czar is Alfred.')
      end

      # Round 3

      Capybara.using_session('player_3') do
        refresh

        click_button "I'm ready"
        click_button 'Pick a black card'
        click_button 'Play this card'
      end

      Capybara.using_session('player_1') do
        refresh
        click_link 'Play this card'
      end

      Capybara.using_session('player_2') do
        refresh
        click_link 'Play this card'
      end

      Capybara.using_session('player_3') do
        refresh

        click_button 'Pick a winner'
        click_link 'Award'

        expect(page).to have_content(/Card Czar Alfred chose (Batman|Robin)'s tasteless card./)
        expect(page).to have_content('The next Card Czar is Batman')
      end

      # Round 4

      Capybara.using_session('player_1') do
        refresh

        click_button "I'm ready"
        click_button 'Pick a black card'
        click_button 'Play this card'
      end
    end
  end

  context 'existing user' do
    it 'does not require the user to sign up' do
      visit '/players/new'

      fill_in 'How should we call you?', with: 'Batman'
      click_button "Let's go"
      click_button 'Start a new game'

      expect(page).to have_content "Hey, you're the Card Czar this round."
    end
  end
end

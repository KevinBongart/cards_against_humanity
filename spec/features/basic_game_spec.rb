# frozen_string_literal: true

require 'rails_helper'

describe 'Basic game' do
  context 'new user' do
    it 'works' do
      visit '/'

      click_button 'Start a new game'
      fill_in 'How should we call you?', with: 'Batman'
      click_button "Let's go"

      expect(page).to have_content "Hey, you're the Card Czar this round."

      click_button 'Pick a black card'
      click_button 'Play this card'
    end
  end

  context 'existing user' do
    it 'works' do
      visit '/players/new'

      fill_in 'How should we call you?', with: 'Batman'
      click_button "Let's go"
      click_button 'Start a new game'

      expect(page).to have_content "Hey, you're the Card Czar this round."

      click_button 'Pick a black card'
      click_button 'Play this card'
    end
  end
end

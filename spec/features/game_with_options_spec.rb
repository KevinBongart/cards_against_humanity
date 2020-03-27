# frozen_string_literal: true

require 'rails_helper'

describe 'Game with MC Czar option' do
  it 'works' do
    visit '/'
    check 'MC Czar'
    click_button 'Start a new game'
    fill_in 'How should we call you?', with: 'Batman'
    click_button "Let's go"

    expect(Game.first.players.first.name).to eq('Batman')
    expect(Game.first.options.count).to eq(1)
    expect(Game.first.options.first.code).to eq(Option::MC_CZAR)

    expect(page).to have_content "Hey, you're the Card Czar this round."

    click_button 'Pick a black card'
    click_button 'Play this card'
  end
end

# frozen_string_literal: true

Rails.application.routes.draw do
  resources :games, only: [:new, :create, :show] do
    resource :round, only: [:show, :create] do
      member do
        post :advance
        post :play_card
        post :skip_black_card
        post :prev_card_in_hand
        post :next_card_in_hand
        post :next_submission
        post :end
      end
    end

    collection do
      post :find
      get :create_after_signup
    end
  end

  resources :players, only: [:new, :create, :destroy]

  get ':id', to: 'games#show', constraints: { id: /[A-Z\d]+/ }, as: :short_game

  root 'games#new'
end

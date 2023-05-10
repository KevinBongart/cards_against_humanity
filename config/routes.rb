# frozen_string_literal: true

Rails.application.routes.draw do
  require 'sidekiq/web'

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == ENV.fetch('HTTP_BASIC_USERNAME') && password == ENV.fetch('HTTP_BASIC_PASSWORD')
  end
  mount Sidekiq::Web, at: '/sidekiq'

  flipper_app = Flipper::UI.app(Flipper.instance) do |builder|
    builder.use Rack::Auth::Basic do |username, password|
      username == ENV.fetch('HTTP_BASIC_USERNAME') && password == ENV.fetch('HTTP_BASIC_PASSWORD')
    end
  end
  mount flipper_app, at: '/flipper'

  mount PgHero::Engine, at: :pghero

  resources :games, only: [:new, :create, :show] do
    resource :round, only: [:show, :create] do
      member do
        post :advance
        post :play_card
        post :skip_black_card
        post :prev_card_in_hand
        post :next_card_in_hand
        post :prev_submission
        post :next_submission
        post :end
      end
    end

    collection do
      post :find
      get :create_after_signup
    end
  end

  resources :players, only: [:new, :create, :destroy] do
    member do
      post :toggle_hand_style
    end
  end

  namespace :admin do
    resource :activity, only: :show
    root 'activities#show'
  end

  get ':id', to: 'games#show', constraints: { id: /[A-Z\d]+/ }, as: :short_game

  root 'games#new'
end

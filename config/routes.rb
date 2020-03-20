Rails.application.routes.draw do
  resources :games, only: [:new, :create, :show] do
    resource :round, only: [:show, :create] do
      member do
        post :advance
        post :play_card
        post :skip_black_card
        post :next_card_in_hand
        post :next_submission
      end
    end

    collection do
      post :find
      get :create_after_signup
    end
  end

  resources :players, only: [:new, :create, :destroy]

  root 'games#new'
end

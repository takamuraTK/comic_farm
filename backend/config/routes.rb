# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  get root to: 'toppages#index'

  resources :users, only: %i[show edit update]

  resources :subscribes, only: %i[create destroy]
  resources :favorites, only: %i[create destroy]

  get 'books', to: 'books#new'
  get 'books/:isbn', to: 'books#show', as: 'book'
  get 'books/:isbn/reviews/new', to: 'reviews#new', as: 'review_new'
  get 'subscribe-ranking', to: 'books#ranking'
  get 'review-ranking', to: 'books#review_ranking'

  get 'howto', to: 'toppages#howto'

  resources :reviews
  get 'reviews/index/:id', to: 'reviews#index', as: 'review_index'
  get 'reviews/error', to: 'reviews#error'

  resources :reviewfavorites, only: %i[create destroy]
  get 'newlys/download', to: 'newlys#download'
  get 'newlys', to: 'newlys#search'
  get 'favnews', to: 'newlys#newfav'

  # API routes
  get 'v1/ranking/subs', to: 'books#api_subs_ranking'
  get 'v1/ranking/review', to: 'books#api_review_ranking'

  namespace :v1 do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      confirmations:  'overrides/confirmations'
    }
  end
end

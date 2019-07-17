Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  root to: 'toppages#index'
  
  resources :users, only: [:show] do
    member do
      get :subs
    end
  end
  
  resources :subscribes, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  
  
  get 'books', to: 'books#new'
  post 'books', to: 'books#create'
  get 'books/:isbn',  to: 'books#show'
  
  get 'subscribe-ranking', to: 'books#ranking'
  get 'review-ranking', to: 'books#review_ranking'
  
  get 'monthly', to: 'books#monthly'
  get 'howto', to: 'toppages#howto'

  resources :reviews
  
  
  
end

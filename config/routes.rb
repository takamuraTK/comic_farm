Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  get root to: 'toppages#index'
  
  resources :users, only: [:show, :edit, :update] do
    member do
      get :subs
    end
  end
  
  resources :subscribes, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  
  
  get 'books', to: 'books#new'
  post 'books', to: 'books#create'
  get 'books/:isbn',  to: 'books#show', as:'book'
  
  get 'subscribe-ranking', to: 'books#ranking'
  get 'review-ranking', to: 'books#review_ranking'
  
  get 'howto', to: 'toppages#howto'
  
  get 'books/:isbn/reviews/new', to: 'reviews#new', as:'review_new'
  get 'reviews/index/:id', to: 'reviews#index', as:'review_index'
  resources :reviews
  get 'reviews/error', to: 'reviews#error'

  resources :reviewfavorites, only: [:create, :destroy]
  get 'newlys/download', to: 'newlys#download'
  get 'newlys', to: 'newlys#search'
  get 'favnews', to: 'newlys#newfav'
end

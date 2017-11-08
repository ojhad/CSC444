Rails.application.routes.draw do
  get 'search/search'

  get 'home/index'
  get "about", to: "home#about"

  devise_for :users, :controllers => {:registrations => "registrations"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # Add a root at some point once we have one
  root 'home#index'

  resources :users do
    resources :reviews
    #resources :services
    resources :cards
    resources :payouts
    resources :deposits , only:[:index, :create]
    resources :transactions
  end

  resources :services do
    member do
      get 'list'
      get 'unlist'
      get 'add_request'
      get 'remove_request'
      get 'select_request'
    end
  end

  resources :user_skills





end

Rails.application.routes.draw do
  get 'search/search'

  get 'home/index'
  get "about", to: "home#about"
  get "terms_of_service", to: "home#terms_of_service"

  devise_for :users, :controllers => {:registrations => "registrations"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # Add a root at some point once we have one
  root 'home#index'

  resources :users do
    resources :reviews
    #resources :services
    resources :cards
    resources :payouts
    resources :deposit_information , only:[:index, :update]
    resources :transactions
  end

  resources :services do
    member do
      post 'list'
      post 'unlist'
      post 'add_request'
      post 'remove_request'
      post 'select_request'
    end
  end

  resources :user_skills
  resources :user_steps
  resources :teen_times




end

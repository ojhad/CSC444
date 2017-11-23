Rails.application.routes.draw do


  resources :notifications
  get 'search/search'

  get 'home/index'
  get "about", to: "home#about"
  get "terms_of_service", to: "home#terms_of_service"
  get "faq", to: "home#faq"
  get "contact_us", to: "home#contact_us"
  get "send_email", to: "home#send_email"

  devise_for :users, :controllers => {:registrations => "registrations"}

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # Add a root at some point once we have one
    root 'home#index'

  resources :users do
    collection do
      post 'add_user'
      get 'login_as'
    end
    resources :reviews
    #resources :services
    resources :cards
    resources :payouts
    resources :payout_informations , only:[:index, :update]
    resources :transactions
    resources :endorsements
    resources :endorsement_requests, only:[:create]
    resources :charges , only: [:index ,:create]
    post :impersonate, on: :member
    post :stop_impersonating, on: :collection
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
  resources :finances , only: [:index]

end
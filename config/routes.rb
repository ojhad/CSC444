Rails.application.routes.draw do

  get 'set_language/english'
  get 'set_language/french'

  resources :notifications do
    collection do
      post :mark_as_read
    end
  end

  get 'search/search'

  get 'home/index'
  get "about", to: "home#about"
  get "terms_of_service", to: "home#terms_of_service"
  get "faq", to: "home#faq"
  get "how_it_works", to: "home#how_it_works"
  get "contact_us", to: "home#contact_us"
  get "send_email", to: "home#send_email"

  get "/services/filter", to: "services#filter"

  devise_for :users, :controllers => {:registrations => "registrations"}

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # Add a root at some point once we have one
    root 'home#index'

  resources :users do
    collection do
      post 'add_user'
      get 'login_as'
      get 'sql_interface'
      post 'run_query'
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
      post 'submit_timesheet'
    end
  end

  resources :user_skills
  resources :user_steps
  resources :teen_times
  resources :finances , only: [:index]

  resources :conversations do
    resources :messages do
      collection do
        post :mark_as_read
      end
    end
  end

  resources :messages do

  end
end

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
  end

  resources :services
  resources :user_skills

end

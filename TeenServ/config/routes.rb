Rails.application.routes.draw do
  get 'home/index'

  devise_for :users, :controllers => {:registrations => "registrations"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # Add a root at some point once we have one
  root 'home#index'

  resources :users do
    resources :reviews
  	resources :services
  	resources :jobs
  end

  resources :jobs
end

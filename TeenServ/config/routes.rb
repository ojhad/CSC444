Rails.application.routes.draw do
  get 'home/index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # Add a root at some point once we have one
  root 'home#index'

  resources :people do
    resources :reviews
  end
end

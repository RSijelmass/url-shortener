Rails.application.routes.draw do
  root "home#index"
  
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :url_instances
  match '/short/:shorthand', to: 'url_instances#redirect_from_short', via: 'get'
end

Rails.application.routes.draw do
  resources :url_instances
  match '/short/:shorthand', to: 'url_instances#redirect_from_short', via: 'get'
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :donors do
    resources :requests
  end
  
  resources :requests

  resources :identities
  
  resources :requesters do
    resources :requests
  end

  # Routes for Sessions

  root 'sessions#welcome'
  # post '/create', to: 'sessions#create'

  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'

  get '/auth/:provider', to: 'sessions#omni_create'#, as: 'auth_login'
  get "/auth/:provider/callback", to: "sessions#omni_create"
  
 
  
  match '/logout', to: 'sessions#logout', via: [:get, :post]

  # Routes for Users

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  # Routes for Requests

  get '/requests/fulfill', to: 'requests#fulfill'
  post '/requests/fulfill', to: 'requests#update'

end

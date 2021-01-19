Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :donors do
    resources :requests
  end
  
  resources :requests
  
  resources :requesters do
    resources :requests
  end

  # Routes for Sessions

  root 'sessions#welcome'
  post '/create', to: 'sessions#create'
  
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  
  get '/logout', to: 'sessions#logout'

  # Routes for Users

  get '/signup', to: 'users#new', as: 'signup'
  post '/signup', to: 'users#create'

  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]   


end

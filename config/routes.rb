Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :donors, only: [] do
    resources :requests
  end
  
  resources :requests
  
  resources :requesters, only: [] do
    resources :requests
  end
  
  resources :users

  # Routes for Sessions

  root 'sessions#welcome'
  post '/create', to: 'sessions#create'
  
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  
  delete '/logout', to: 'sessions#logout'

  # Routes for Users

  get '/signup', to: 'users#new' 
  post '/signup', to: 'users#create'

  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]   


end

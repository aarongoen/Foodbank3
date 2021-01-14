Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Routes for Sessions

  root 'sessions#welcome'
  get '/signup', to: 'sessions#signup'
  post '/create', to: 'sessions#create'
  
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#login'

  post '/logout', to: 'sessions#logout'
    
    resources :donors
  resources :requests
  resources :requesters
  resources :users
end

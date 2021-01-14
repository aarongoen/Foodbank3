Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Routes for Sessions

  get '/welcome', to: 'sessions#welcome'
  # get '/signup', to: 'sessions#signup'
  # post '/create', to: 'sessions#create'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#logout'

  # post '/logout', to: 'sessions#logout'
    
  resources :donors
  resources :requests
  resources :requesters
  resources :users

end

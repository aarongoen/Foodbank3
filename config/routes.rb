Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Routes for Sessions

  get '/welcome', to: 'sessions#welcome'
  post '/create', to: 'sessions#create'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#logout'

  # Routes for Users

  get '/signup', to: 'users#new' 
  post 'signup', to: 'users#create'


  # post '/logout', to: 'sessions#logout'
    
  resources :donors
  resources :requests
  resources :requesters
  resources :users, only: [:new, :create, :show]

end

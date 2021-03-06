 Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Routes for Requests

  get '/requests/to_fulfill', to: 'requests#to_fulfill'
  post '/requests/fulfill', to: 'requests#update'
  get '/requests/show_donations', to: 'requests#index'
  post '/requests/show_donations', to: 'requests#create'

  get '/requests/requester_requests', to: 'requests#index'
  get '/requests/new_donation', to: 'requests#new'
  post '/requests/new_donation', to: 'requests#create'

  resources :donors do
    resources :requests
  end
  
  resources :requests, except: :show

  resources :users, only: [:new, :create, :edit, :update, :show]
  
  resources :requesters do
    resources :requests
  end

  # Routes for Sessions

  root 'sessions#welcome'
  # post '/create', to: 'sessions#create'

  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'


  match '/auth/github/callback', to: 'sessions#omnicreate', via: [:get, :post]

  # get '/auth/failure', to: 'sessions#omni_create' 
  
  match '/logout', to: 'sessions#logout', via: [:get, :post]

  # Routes for Users

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  # get '/users/:id/edit', to: 'users#edit'#, as :edit_role
  post '/users/:id', to: 'users#update'

end

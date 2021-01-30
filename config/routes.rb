 Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :donors do
    resources :requests
  end
  
  resources :requests

  resources :users, only: [:edit, :update, :show]
  
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

  # Routes for Requests

  get '/requests/to_fulfill', to: 'requests#fulfilled?'
  # post '/requests/fulfill', to: 'requests#update'

end

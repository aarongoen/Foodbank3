Rails.application.routes.draw do
  resources :donors
  resources :requests
  resources :requesters
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

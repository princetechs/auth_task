Rails.application.routes.draw do
  root 'sessions#show'
  get '/login', to: 'sessions#show'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  post '/verify_2fa', to: 'sessions#verify_2fa', as: 'verify_2fa'
  get '/verify', to: 'sessions#verify_index'

  get '/not_authorized', to: 'users#not_authorized', as: 'not_authorized'
  get '/dashboard', to: 'users#dashboard', as: 'dashboard'

  # Users routes
  get '/signup', to: 'users#new'
  post '/users', to: 'users#create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  
end

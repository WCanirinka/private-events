Rails.application.routes.draw do
  get 'attendances/create'
  get 'attendances/destroy'
  get 'events/create'
  get 'events/destroy'
  get 'sessions/new'
  get 'users/new'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  root 'sessions#new'
  get '/events/new'


  resources :users
  resources :events
  resources :attendances
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

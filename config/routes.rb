Rails.application.routes.draw do
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  resources :users
  get '/feed', to: 'users#feed'
  get '/login', to: 'sessions#new'
  delete '/logout', to: 'sessions#destroy'
  resources :sessions, only: [:create] # []は値が１つの時は省略していい
  resources :posts, only: :create
  resources :relationships, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

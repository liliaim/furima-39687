Rails.application.routes.draw do
  devise_for :users 
  root to: 'items#index'


  # resources :users, only: [:show,:update]
  resources :items
  resources :orders, only:[:index, :new, :create]

  resources :cards, only: [:new, :create, :edit, :update]
end

Rails.application.routes.draw do
  devise_for :users 
  root to: 'items#index'


  resources :users, only: :show
  resources :items
  resources :orders, only:[:index, :new, :create]

end

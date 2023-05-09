Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  resources :users, only: [:index,:new, :create]
  resources :items, only: [:new, :create,:show,:index]
  resources :lots, only: [:new, :create,:index, :show]
  resources :lot_items, only: [:create,:index]


  post 'create_user' => 'users#create'
  post 'create_admin' => 'users#create_admin'
  get 'new_admin' => 'users#new_admin'

  
  get 'lots_all' => 'lots#lots_all'
  get '/add_item/:id', to: 'lot_items#add_item', as: 'add_item'
  post 'add_item_lot' => 'lot_items#create'

  get 'view_items/:id' => 'lot_items#index', as: 'view_items'
  
  put 'aprove/:id' => 'lots#aprove', as: 'aprove'
end

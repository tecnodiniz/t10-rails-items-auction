Rails.application.routes.draw do
  devise_for :administrators
  devise_for :users, controllers: { registrations: 'registrations' }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'home#index'

  resources :users, only: %i[index new create]
  resources :products, only: %i[new create index show edit update]
  resources :categories, only: %i[new create index]
  resources :administrators, only: %i[new create index show] do 
    collection do
      post :create_admin
    end

  end
  
  resources :lots, only: %i[new create index show edit update] do 
    resources :lot_items, only: %i[create index destroy] do 
      collection do
        get :add_item
        get :view_items
        post :add_item_lot
        
      end
      
    end
    resources :bids, only: [:create]

    collection do
      get :lost_all
      get :expired
    end
    member do 
      
    end

  end
 
  resources :winners, only: [:index]
  resources :favorites, only: [:index]

  post 'create_user' => 'users#create'
  get 'new_admin' => 'users#new_admin'


  get '/add_item/:id', to: 'lot_items#add_item', as: 'add_item'

  post 'add_item_lot' => 'lot_items#create'

  get 'view_items/:id' => 'lot_items#index', as: 'view_items'

  put 'aprove/:id' => 'lots#aprove', as: 'aprove'

  post 'validate/:id' => 'lots#validate', as: 'validate_auction'

  post 'favorited/:id' => 'lots#favorited', as: 'add_favorite'

  get 'bid/:id' => 'lots#bid', as: 'make_bid'

  get 'user_auctions/:id' => 'users#user_win', as: 'user_win'
end

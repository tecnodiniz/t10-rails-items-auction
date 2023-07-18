Rails.application.routes.draw do
  devise_for :administrators
  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions'}

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'home#index'

  resources :users, only: %i[index new create] do 
    resources :user_messages,only: %i[index show]
    resources :favorites, only: %i[index destroy] do 
      member do 
        post :favorite
      end
    end
  end
  resources :products, only: %i[new create index show edit update] do
    collection do
      get :search
    end
  end
  resources :prod_categories, only: %i[new create index]
  resources :administrators, only: %i[new create index show] do 
    collection do
      post :create_admin
    end

  end
  
  resources :lots, only: %i[new create index show edit update] do 
    resources :lot_items, only: %i[new create destroy ]
    resources :bids, only: %i[new create]
    resources :lot_doubts, only: %i[new create] do 
      resources :answer_doubts, only: %i[new create]
    end

    member do 
      put :aprove
      put :finish
    end
    collection do
      get :finished
    end

  end

  resources :winners, only: %i[ index ] do 
    member do 
      post :calc
    end
  end

  resources :blocked_cpfs, only: %i[ new  create]
 

end

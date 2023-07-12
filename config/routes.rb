Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :events do
    member do
      post 'trigger_api'
      delete 'destroy_room_url'
      get 'room_url', to: 'events#room_url'
    end
  end
  resources :recipes, only: %i[index new show create edit update] do
    resources :reviews, only: %i[new create]
  end

  resources :users, only: %i[show edit update] do
    member do
      get :my_recipes_events_bookings
      get :my_recipes
    end
  end

  resources :events do
    resources :bookings, only: %i[new create]
  end

  get 'my_bookings', to: 'bookings#my_bookings', as: 'my_bookings'

  resources :bookings, only: %i[show destroy]

  resources :chatrooms, only: [:show, :index] do
    resources :messages, only: :create
  end

  get 'search', to: 'search#index'

  get '/contact', to: 'pages#contact', as: 'contact'

  get '/about', to: 'pages#about', as: 'about'

end

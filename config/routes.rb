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
  resources :recipes, only: %i[index new show create edit update destroy]
  resources :users, only: %i[show edit update]

  resources :events do
    resources :bookings, only: %i[new create]
  end

  get 'my_bookings', to: 'bookings#my_bookings', as: 'my_bookings'

  resources :bookings, only: %i[show destroy]

  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end
end

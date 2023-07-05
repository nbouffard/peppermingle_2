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

  resources :recipes, only: %i[index new show create edit update]
  resources :users, only: %i[show edit update]
end

Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :events
  resources :recipes, only: %i[index new show create edit update] do
    resources :reviews, only: %i[new create]
  end
  resources :users, only: %i[show edit update]
  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end
end

Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :events
  resources :recipes, only: %i[index new show create edit update]
  resources :users, only: %i[show edit update]
end

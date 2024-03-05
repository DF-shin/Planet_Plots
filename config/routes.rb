Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :plots, only: [:show, :new, :create, :index]

  resources :requests, only: %i[index new create]
end

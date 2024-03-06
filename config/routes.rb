Rails.application.routes.draw do
  devise_for :users
  get 'plots/search_planets', to: 'plots#search_planets'
  root to: "pages#home"

  resources :plots, only: [:show, :new, :create, :index]

  resources :requests, only: %i[index new create]
end

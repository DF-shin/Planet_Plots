Rails.application.routes.draw do
  devise_for :users
  get 'plots/search_planets', to: 'plots#search_planets'
  root to: "pages#home"

  resources :plots, only: %i[show new create index edit update]

  resources :requests, only: %i[index new create show update]
  get 'request_error', to: 'requests#error'
end

Rails.application.routes.draw do
  devise_for :users
  get 'plots/search_planets', to: 'plots#search_planets'
  root to: "pages#home"
  resources :plots, only: %i[show new create]
  get "up" => "rails/health#show", as: :rails_health_check
  resources :requests, only: %i[index new create]
end

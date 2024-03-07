Rails.application.routes.draw do
  devise_for :users
  get 'plots/search_planets', to: 'plots#search_planets'
  get 'my_plots', to: 'plots#my_plots' # New route for My Plots
  root to: "pages#home"

  resources :plots, only: %i[show new create index edit update]

  resources :requests, only: %i[index new create show update destroy]
  get 'request_error', to: 'requests#error'
end

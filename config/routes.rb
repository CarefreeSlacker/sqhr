Rails.application.routes.draw do
  root to: 'main#index'

  resources :users
  resources :histories, only: [:index, :show]
end

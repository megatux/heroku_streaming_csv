Rails.application.routes.draw do
  root to: 'home#index'

  resources :exporter, only: [:index]
end

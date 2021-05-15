Rails.application.routes.draw do
  root to: 'exhibitions#index'
  resources :exhibitions, only: [:index] do
    collection do
      get 'search'
    end
  end
end

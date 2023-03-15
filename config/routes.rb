Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:index, :show, :create, :new]
  resources :recipes do
    resources :foods #, only: [:index, :show, :create]
    resources :recipe_foods, only: [:new, :create, :destroy]
  end
  resources :foods, only: [:index, :show, :new, :create, :destroy]
  
  # Defines the root path route ("/")
  root "users#index"
end

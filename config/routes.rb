Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:index, :show, :create, :new]
  resources :foods, only: [:index, :new, :create, :destroy]
  resources :recipes, only: %i[index new create show destroy]
  resources :recipes do 
  resources :recipe_foods, only: [:new, :create]
end


  # Defines the root path route ("/")
  root "users#index"
end

Rails.application.routes.draw do
  devise_for :users

  get '/public_recipes', to: 'recipes#public_recipes'
  get '/general_shopping_list', to: 'recipes#general_shopping_list'

  resources :users, only: [:index, :show, :create, :new]
  resources :foods, only: [:index, :new, :create, :destroy]
  resources :recipes, only: [:index, :show, :new, :create, :edit, :destroy] do
    resources :recipe_foods
  end
  resources :recipes do
    patch :toggle_public, on: :member
  end
  
  root "users#index"
end

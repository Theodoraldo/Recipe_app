Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "foods#index"

  resources :foods, except: :update
  resources :recipes, except: :update
  resources :public_recipes, only: [:index]
  resources :recipe_foods, only: [:index]

end

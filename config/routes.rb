Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
   root "foods#index"

  resources :foods, except: :update
  resources :recipes, except: :update do
    resources :recipe_foods, only: [:new, :create, :destroy]
  end

  get '/public_recipes', to: 'public_recipes#index', as: 'public_recipes'
end

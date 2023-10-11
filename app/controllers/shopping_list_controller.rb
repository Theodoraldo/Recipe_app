class ShoppingListController < ApplicationController
    before_action :authenticate_user!
  
  def index
    @user = current_user

    # Find all recipes of the logged-in user
    @recipes = @user.recipes

    # Initialize arrays to store missing food items
    @missing_food_items = []
    @total_price = 0

    # Iterate through each recipe
    @recipes.each do |recipe|
    #   recipe.ingredients.each do |ingredient|
    #     # Check if the user's general food list includes the ingredient
    #     unless @user.food_items.include?(ingredient.food)
    #       @missing_food_items << ingredient.food
    #       @total_price += ingredient.food.price
    #     end
    #   end
    end
  end
end

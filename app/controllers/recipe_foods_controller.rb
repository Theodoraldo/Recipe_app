class RecipeFoodsController < ApplicationController
  before_action :set_recipe_food, only: [:destroy]

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @foods = Food.all
    @recipe_food = @recipe.recipe_foods.new
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.new(recipe_food_params)

    if @recipe.user == current_user && @recipe_food.save
      redirect_to @recipe, notice: 'Ingredient successfully added'
    else
      @foods = Food.all
      render :new, status: :unprocessable_entity, alert: 'Error occured whiles adding ingredient (Food) !!!'
    end
  end

  def destroy
    @recipe_food.destroy
    redirect_to recipe_url, notice: 'Recipe food was deleted !!!'
  end

  private

  def set_recipe_food
    @recipe_food = RecipeFood.find(params[:id])
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :recipe_id, :food_id)
  end
end

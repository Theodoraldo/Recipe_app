class RecipesController < ApplicationController
  def index
    @recipes = current_user.recipes.includes(:user) if user_signed_in?
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_foods = @recipe.recipe_foods.includes(:food)
  end

  def new
    @recipe = current_user.recipes.build
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)

    if @recipe.save
      redirect_to recipes_path, notice: 'New Recipe saved !!!.'
    else
      flash[:alert] = 'Failed to create recipe. Please check the form for errors.'
      render :new
    end
  end

  def destroy
    @recipe = current_user.recipes.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path, notice: 'Recipe deleted successfully.'
  end

  def toggle_public
    @recipe = Recipe.find(params[:id])
    @recipe.change_public_status
    redirect_to @recipe, notice: 'Recipe status has changed.'
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :public, :description)
  end
end

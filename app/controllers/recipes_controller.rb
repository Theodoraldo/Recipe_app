class RecipesController < ApplicationController
  def index; end

  def show; end

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

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :public, :description)
  end
end

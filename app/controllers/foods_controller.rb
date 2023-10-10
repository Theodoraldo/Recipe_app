class FoodsController < ApplicationController

  def index
    @foods = Food.all
  end

  def show; end

  def new
    @food = Food.new
  end

  def Create
    @food = current_user.foods.new(food_params)
    if @food.save
      redirect_to @food, notice: 'Food item was successfully created.'
    else
      render :new
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to food_index_url, notice: 'Food item was successfully deleted.'
  end

  private

  # Define permitted parameters for creating a new food item
  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
end

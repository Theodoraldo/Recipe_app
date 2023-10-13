class ShoppingListController < ApplicationController
  before_action :authenticate_user!

  def index
    @foods = Food.where.not(user_id: current_user.id)
  end
end

class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe

  def index
    @recipe_foods = @recipe.recipe_foods
      @foods = @recipe.foods

  end

  def new
  @recipe = Recipe.find(params[:recipe_id])
  @foods = current_user.authored_foods
  @recipe_food = RecipeFood.new
  end

  def create
    data = recipe_food_sanitizer
    recipe_food = @recipe.recipe_foods.build(data)
    if recipe_food.save
      redirect_to recipe_path(@recipe)
    else
      render :new, locals: { recipe_food: recipe_food }
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

def recipe_food_sanitizer
  params.require(:recipe_food).permit(:quantity, :food_id)
end

end

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
    @recipe = Recipe.find(params[:recipe_id])
    @food = Food.find(params[:recipe_food][:food_id])
    @recipe_food = @recipe.recipe_foods.build(recipe_food_sanitizer)
    @recipe_food.food = @food

    if @recipe_food.save
      redirect_to recipe_path(@recipe), notice: "Food added to recipe"
    else
      flash['alert'] = "Something went wrong and food was not added"
      render :new, locals: { recipe_food: recipe_food }, notice: "Something went wrong and food was not added"
    end
  end

  def destroy
    # @recipe = Recipe.find(params[:recipe_id])
    # @recipe_food = @recipe.recipe_foods.find(params[:id])
    # @recipe_food = RecipeFood.find_by(recipe_id: params[:recipe_id], food_id: params[:id])
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.destroy
    redirect_to recipe_path(@recipe), notice: "Food removed from recipe"
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def recipe_food_sanitizer
    params.require(:recipe_food).permit(:quantity)
  end
end

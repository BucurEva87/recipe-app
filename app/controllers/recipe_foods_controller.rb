class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, except: [:update]

  def index
    @recipe_foods = @recipe.recipe_foods
    @foods = @recipe.foods
  end

  def new
    # We don't really want to let the user add twice the same food in the recipe
    @foods = current_user.authored_foods.where.not(id: @recipe.foods.pluck(:id))
    # If there are no ingredient left out of the recipy, we notify
    if @foods.empty?
      failure('This recipe already contains all the ingredients availalbe. Maybe add more?', prefix: nil)
      redirect_to recipe_path(@recipe)
    end
    @recipe_food = RecipeFood.new
  end

  def create
    @food = Food.find(params[:food_id])
    @recipe_food = @recipe.recipe_foods.build(form_sanitizer)
    @recipe_food.food = @food

    if @recipe_food.save
      success('Food added to recipe')
      redirect_to recipe_path(@recipe)
    else
      failure('food was not added')
      render :new, locals: { recipe_food: }
    end
  end

  def edit
    @recipe_food = @recipe.recipe_foods.find(params[:id])
    @food = @recipe_food.food
    # Same reasoning as in the new action
    @foods = current_user.authored_foods.where.not(id: @recipe.foods.pluck(:id) - [@food.id])
  end

  def update
    @recipe_food = RecipeFood.find(params[:id])

    if @recipe_food.update(form_sanitizer)
      success('Food was updated')
      redirect_to recipe_path(@recipe_food.recipe)
    else
      failure('food was not updated')
      render :edit
    end
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])

    if @recipe_food.destroy
      success('Food removed')
    else
      failure('food was not removed')
    end
    redirect_to recipe_path(@recipe)
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def form_sanitizer
    params.permit(:quantity, :recipe_id, :food_id)
  end
end

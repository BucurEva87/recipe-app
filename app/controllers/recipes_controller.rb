class RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: %i[show edit update destroy]

  def index
    @user = current_user
    @recipes = @user.authored_recipes
  end

  def show
    @recipe = Recipe.includes(:recipe_foods).find(params[:id])
    @foods = @recipe.foods
    p @recipe.recipe_foods
  end

  def create
    @recipe = Recipe.new(form_sanitizer.merge(author_id: current_user.id))

    if @recipe.save
      flash[:notice] = "Recipe #{@recipe.name} was created successfully"
      redirect_to recipes_path
    else
      flash[:alert] = "Something went wrong and recipe #{@recipe.name} was not created"
      render :new, locals: { recipe: }
    end
  end

  def new
    @recipe = Recipe.new
  end

  def destroy
    @recipe = Recipe.find(params[:id])

    if @recipe.destroy
      flash[:notice] = "Recipe #{@recipe.name} was removed successfully"
      redirect_to recipes_path
    else
      flash[:alert] = "Something went wrong and recipe #{@recipe.name} was not removed"
      redirect_to recipe_path(@recipe)
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def form_sanitizer
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end

class RecipesController < ApplicationController
  helper RecipesHelper

  before_action :authenticate_user!
  before_action :set_recipe, only: %i[show edit update destroy]

  def index
    @user = current_user
    @recipes = @user.authored_recipes
  end

  def show
    @recipe = Recipe.find(params[:id])
    @foods = @recipe.foods.includes(:recipe_foods)
  end

  def create
    @recipe = Recipe.new(form_sanitizer.merge(author_id: current_user.id))

    if @recipe.save
      success("Recipe #{@recipe.name} was created")
      redirect_to recipes_path
    else
      failure("recipe #{@recipe.name} was not created")
      render :new
    end
  end

  def new
    @recipe = Recipe.new
  end

  def destroy
    @recipe = Recipe.find(params[:id])

    if @recipe.destroy
      success("Recipe #{@recipe.name} was removed")
      redirect_to recipes_path
    else
      failure("recipe #{@recipe.name} was not removed")
      redirect_to recipe_path(@recipe)
    end
  end

  def public_recipes
    @recipes = Recipe.where(public: true).includes(:author).order(created_at: :desc)
    render 'public'
  end

  def general_shopping_list
    recipes = current_user.authored_recipes.includes(:recipe_foods)
    foods = current_user.authored_foods

    # Compute the number the user is missing from each item from his/her recipe
    @missing_foods = []
    @number_of_foods = 0
    @total_price = 0
    recipes.each do |recipe|
      recipe.recipe_foods.each do |recipe_food|
        food = foods.find { |f| f.id == recipe_food.food_id }

        difference = recipe_food.quantity.to_i - food.quantity.to_i

        if difference.positive?
          @missing_foods << Food.new(name: food.name, measurement_unit: food.measurement_unit,
                                     price: food.price * difference, quantity: difference)
        end

        @number_of_foods += [difference, 0].max
        @total_price += [difference * food.price, 0].max
      end
    end

    render 'general_shopping_list'
  end

  def toggle_public
    @recipe = Recipe.find(params[:id])

    if @recipe.update(public: !@recipe.public)
      success("The privacy of recipe #{@recipe.name} was updated")
    else
      failure("the privacy of recipe #{@recipe.name} was not updated")
    end
    redirect_to @recipe
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def form_sanitizer
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end

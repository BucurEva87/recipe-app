class FoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_food, only: [:show, :destroy]

  def index
    @user = current_user
    @user_foods = @user.authored_foods
  end

  def show
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(form_sanitizer)
    @food.author_id = current_user.id

    authorize! :create, @food

    if @food.save
      redirect_to foods_path, notice: "Food was successfully created"
    else
      render :new
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to foods_path, notice: "Food was successfully destroyed"
  end

  private

  def set_food
    @food = Food.find(params[:id])
  end

  def form_sanitizer
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end

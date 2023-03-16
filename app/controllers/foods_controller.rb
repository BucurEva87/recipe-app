class FoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_food, only: %i[show destroy]

  def index
    @user = current_user
    @user_foods = @user.authored_foods
  end

  def show; end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(form_sanitizer)
    @food.author_id = current_user.id

    authorize! :create, @food

    if @food.save
      success('Food was created')
      redirect_to foods_path
    else
      failure('food was not created')
      render :new
    end
  end

  def destroy
    @food = Food.find(params[:id])

    if @food.destroy
      success('Food was destroyed')
    else
      failure('food was not destroyed')
    end
    redirect_to foods_path
  end

  private

  def set_food
    @food = Food.find(params[:id])
  end

  def form_sanitizer
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end

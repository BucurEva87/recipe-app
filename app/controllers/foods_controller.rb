class FoodsController < ApplicationController
  def index
    @user = current_user
    @user_foods = @user.authored_foods
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(form_sanitizer.merge(author_id: current_user.id))

    if @food.save
      redirect_to foods_url
    else
      render :new
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to foods_url
  end

  private

  def form_sanitizer
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end

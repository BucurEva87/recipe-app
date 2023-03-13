class FoodsController < ApplicationController
  def index
    @foods = Food.all
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(form_sanitizer.merge(user: current_user))

    if @food.save
      redirect_to foods_url
    else
      render :new
    end
  end

  def destroy
    @food = Post.find(params[:id])
    @food.destroy
    redirect_to foods_url
  end

  private

  def form_sanitizer
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
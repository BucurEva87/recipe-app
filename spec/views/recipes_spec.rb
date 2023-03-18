require 'rails_helper'

RSpec.describe "recipes/index.html.erb", type: :view do
  include Devise::Test::ControllerHelpers

  before(:each) do
    @user = User.create!(name: 'Maria', email: 'maria@gmail.com', password: 'abramburica', confirmed_at: Time.now)
    @recipes = assign(:recipes, [
      Recipe.create!(name: 'Mancare de cartofi', preparation_time: 40, cooking_time: 110, description: 'Mancarica buna de cartofi', public: true, author: @user),
      Recipe.create!(name: 'Oua umplute', preparation_time: 40, cooking_time: 110, description: 'Niste oua umplute', public: false, author: @user),
      Recipe.create!(name: 'Friptura cu cartofi', preparation_time: 60, cooking_time: 90, description: 'Nu mancati ca ingrasa', public: true, author: @user)
    ])
    sign_in @user
  end

  it "displays a list of articles" do
    render
    @recipes.each do |recipe|
      expect(rendered).to match recipe.name
    end
  end
end

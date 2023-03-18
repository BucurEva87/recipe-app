require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, author: user) }
  let(:valid_attributes) { attributes_for(:recipe) }
  let(:invalid_attributes) { attributes_for(:recipe, name: nil) }

  before { sign_in user }

  describe "GET #index" do
    it "assigns current user as @user" do
      get :index
      expect(assigns(:user)).to eq(user)
    end

    it "assigns current user's authored recipes as @recipes" do
      authored_recipe = create(:recipe, author: user)
      get :index
      expect(assigns(:recipes)).to include(authored_recipe)
    end
  end

  describe "GET #show" do
    it "assigns the requested recipe as @recipe" do
      get :show, params: { id: recipe.id }
      expect(assigns(:recipe)).to eq(recipe)
    end
  end

  describe "GET #new" do
    it "assigns a new recipe as @recipe" do
      get :new
      expect(assigns(:recipe)).to be_a_new(Recipe)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Recipe" do
        expect {
          post :create, params: { recipe: valid_attributes }
        }.to change(Recipe, :count).by(1)
      end

      it "assigns a newly created recipe as @recipe" do
        post :create, params: { recipe: valid_attributes }
        expect(assigns(:recipe)).to be_a(Recipe)
        expect(assigns(:recipe)).to be_persisted
      end

      it "redirects to the index" do
        post :create, params: { recipe: valid_attributes }
        expect(response).to redirect_to(recipes_path)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested recipe" do
      recipe = create(:recipe, author: user)
      expect {
        delete :destroy, params: { id: recipe.id }
      }.to change(Recipe, :count).by(-1)
    end

    it "redirects to the recipes list" do
      delete :destroy, params: { id: recipe.id }
      expect(response).to redirect_to(recipes_path)
    end
  end
end

require 'rails_helper'

RSpec.describe RecipeFoodsController, type: :controller do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, author: user) }
  let(:food) { create(:food, author: user) }
  let(:recipe_food) { create(:recipe_food, recipe:, food:) }

  before { sign_in user }

  describe 'GET #index' do
    before do
      post :create, params: { recipe_id: recipe.id, food_id: food.id, quantity: 1 }
      get :index, params: { recipe_id: recipe.id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns the recipe and recipe_foods variables' do
      expect(assigns(:recipe)).to eq(recipe)
      expect(assigns(:recipe_foods)).to eq(recipe.recipe_foods)
    end
  end

  describe 'GET #new' do
    before { post :create, params: { recipe_id: recipe.id, food_id: food.id, quantity: 1 } }

    context 'when there are no ingredients left out of the recipe' do
      before { recipe.update(foods: user.authored_foods) }

      before { get :new, params: { recipe_id: recipe.id } }

      it 'redirects to recipe show page' do
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(recipe_path(recipe))
      end

      it 'sets a flash message' do
        expect(flash[:failure]).to eq('This recipe already contains all the ingredients availalbe. Maybe add more?')
      end
    end

    context 'when there are ingredients left out of the recipe' do
      before { create(:food, author: user) }

      before { get :new, params: { recipe_id: recipe.id } }
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'assigns the foods variable' do
        expect(assigns(:foods)).to eq(user.authored_foods.where.not(id: recipe.foods.pluck(:id)))
      end
    end
  end

  describe 'POST #create' do
    let(:params) { { recipe_id: recipe.id, food_id: food.id, quantity: 1 } }

    context 'with valid parameters' do
      before { post :create, params: }

      it 'creates a new recipe_food and redirects to the recipe page' do
        expect(RecipeFood.count).to eq(1)
        expect(response).to redirect_to(recipe_path(recipe))
      end
    end

    context 'with invalid parameters' do
      before do
        allow_any_instance_of(RecipeFood).to receive(:save).and_return(false)
        post :create, params:
      end

      it 'does not create a new recipe_food and renders the new template' do
        expect(RecipeFood.count).to eq(0)
        expect(response).to render_template(:new)
      end
    end
  end
end

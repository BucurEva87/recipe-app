require 'rails_helper'

RSpec.describe FoodsController, type: :controller do
describe "GET #index" do
  it "returns http success" do
    user = create(:user)
    sign_in user

    get :index

    expect(response).to have_http_status(:success)
  end

  it "assigns the current user's foods to @user_foods" do
    user = create(:user)
    sign_in user
    food = create(:food, author: user)

    get :index

    expect(assigns(:user_foods)).to eq([food])
  end
end

  describe "GET #new" do
    it "returns http success" do
      user = create(:user)
      sign_in user

      get :new

      expect(response).to have_http_status(:success)
    end

    it "assigns a new food to @food" do
      user = create(:user)
      sign_in user

      get :new

      expect(assigns(:food)).to be_a_new(Food)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new food" do
        user = create(:user)
        sign_in user

        expect {
          post :create, params: { food: attributes_for(:food) }
        }.to change(Food, :count).by(1)
      end

      it "assigns the author to the current user" do
        user = create(:user)
        sign_in user

        post :create, params: { food: attributes_for(:food) }

        expect(assigns(:food).author).to eq(user)
      end

      it "redirects to the foods index page" do
        user = create(:user)
        sign_in user

        post :create, params: { food: attributes_for(:food) }

        expect(response).to redirect_to(foods_path)
      end
    end

    context "with invalid attributes" do
      it "does not create a new food" do
        user = create(:user)
        sign_in user

        expect {
          post :create, params: { food: attributes_for(:food, name: "") }
        }.not_to change(Food, :count)
      end

      it "re-renders the new template" do
        user = create(:user)
        sign_in user

        post :create, params: { food: attributes_for(:food, name: "") }

        expect(response).to render_template(:new)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the food" do
      user = create(:user)
      food = create(:food, author: user)

      sign_in user

      expect {
        delete :destroy, params: { id: food.id }
      }.to change(Food, :count).by(-1)
    end

    it "redirects to the foods index page" do
      user = create(:user)
      food = create(:food, author: user)

      sign_in user

      delete :destroy, params: { id: food.id }

      expect(response).to redirect_to(foods_path)
    end
  end
end

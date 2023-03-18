# spec/views/shared/_navbar.html.erb_spec.rb
require 'rails_helper'

RSpec.describe 'shared/_navbar.html.erb', type: :view do
 before(:each) do
    @user = FactoryBot.create(:user)
    login_as(@user, scope: :user)
    allow(view).to receive(:current_user).and_return(@user) end

    
    context 'when user is logged in' do
    before { allow(view).to receive(:current_user).and_return(@user) }

    it 'displays welcome message, navigation links, and sign out link' do
      render

      expect(rendered).to have_content("Welcome, #{@user.name} !")
      expect(rendered).to have_link('Foods', href: foods_path)
      expect(rendered).to have_link('Recipes', href: recipes_path)
      expect(rendered).to have_link('Public recipes', href: public_recipes_path)
      expect(rendered).to have_link('Shopping List', href: general_shopping_list_path)
      expect(rendered).to have_link('Sign out', href: destroy_user_session_path)
    end
  end
end

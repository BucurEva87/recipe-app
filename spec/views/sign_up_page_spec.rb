require_relative '../rails_helper'

RSpec.describe 'Sign Up page ', type: :feature do
    before(:each) do
      DatabaseCleaner.clean_with(:truncation)
      @user = User.create(
        name: 'Krishna'
      )
      visit new_user_registration_path
    end

    it 'should display the Sign up button', :passed do
        expect(page).to have_content("Sign up")
    end
end

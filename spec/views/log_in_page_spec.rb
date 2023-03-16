require_relative '../rails_helper'

RSpec.describe 'Log in page', type: :feature do
    before(:each) do
      DatabaseCleaner.clean_with(:truncation)
      @user = User.create(
        name: 'Krishna'
      )
      visit user_session_path
    end

    it 'should display the Log in button', :passed do
        expect(page).to have_content("Log in")
    end
end

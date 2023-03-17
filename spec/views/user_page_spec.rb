require 'rails_helper'

RSpec.describe 'Account confirmation', type: :system do
  before(:each) do
    DatabaseCleaner.clean_with(:truncation)

    @user = User.create(
      name: 'Krishna',
      email: 'krishna122333@example.com',
      password: '123456'
    )
  end

  scenario 'User confirms their account' do
visit new_user_registration_path
    fill_in 'Email', with: @user.email
    fill_in 'Name', with: @name
    fill_in 'Password', with: @user.password
    click_button 'Sign up'
    click_link 'Confirm my account'
    expect(page).to have_content 'Your email address has been successfully confirmed.'
  end

  scenario 'User resends confirmation instructions' do
    visit new_user_confirmation_path

    expect(page).to have_content 'Resend confirmation instructions'

    fill_in 'Email', with: @user.email
    click_button 'Resend confirmation instructions'

    expect(page).to have_content 'You will receive an email with instructions for how to confirm your email address in a few minutes.'
  end
end

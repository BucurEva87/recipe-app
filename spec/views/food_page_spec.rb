require_relative '../rails_helper'

RSpec.describe 'Food page', type: :system do
  before(:each) do
    DatabaseCleaner.clean_with(:truncation)
    @user = User.create(
      name: 'Test',
      email: 'test@test.com',
      password: '123456'
    )
    visit user_session_path
    fill_in 'Email', with: @user.email.to_s
    fill_in 'Password', with: @user.password.to_s
    find("input[type='submit']").click

    @food1 = Food.new(name: 'Apple', measurement_unit: 'kg', price: 2, quantity: 100)
    @food1.author_id = @user.id
    @food1.save
  end


  it 'shows the  food Button' do
    expect(page).to have_content('Add food')
  end

  it 'shows the delete button for food' do
    visit foods_path
    expect(page).to have_content('Delete')
  end

  it 'shows the food name' do
    visit foods_path
    expect(page).to have_content(@food1.name)
  end

  it 'shows the food Measurement Unit' do
    visit foods_path
    expect(page).to have_content(@food1.measurement_unit)
  end

  it 'shows the food Unit price' do
    visit foods_path
    expect(page).to have_content(@food1.price.to_s)
  end
  it 'shows the food quantity' do
    visit foods_path
    expect(page).to have_content(@food1.quantity.to_s)
  end
end

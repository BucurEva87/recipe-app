require_relative '../rails_helper'

RSpec.describe 'Food page', type: :system do
  before(:each) do
    @user = FactoryBot.create(:user)
    login_as(@user, scope: :user)
    @food1 = Food.new(name: 'Apple', measurement_unit: 'kg', price: 2, quantity: 100)
    @food1.author_id = @user.id
    @food1.save
  end

  it 'Add Food  adds a new food ' do
    visit foods_path
    click_link 'Add Food'
    fill_in 'Name', with: @food1.name
    fill_in 'Measurement unit', with: @food1.measurement_unit
    fill_in 'Price', with: @food1.price
    fill_in 'Quantity', with: @food1.quantity
    click_button 'Add Food'
    expect(page).to have_content(@food1.name)
  end

  it 'displays the food name, measurement unit, unit price, quantity, and delete action' do
    visit foods_path
    expect(page).to have_content(@food1.name)
    expect(page).to have_content(@food1.measurement_unit)
    expect(page).to have_content(@food1.price)
    expect(page).to have_content(@food1.quantity)
    expect(page).to have_button('Delete')
  end
  it 'can delete a food' do
    visit foods_path
    click_button 'Delete'
    expect(page).to_not have_content(@food1.name)
  end
end

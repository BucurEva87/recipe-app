require_relative '../rails_helper'

RSpec.describe 'Food page', type: :system do

  before(:each) do
  @user = FactoryBot.create(:user)
  login_as(@user, :scope => :user)
  @food1 = Food.new(name: 'Apple', measurement_unit: 'kg', price: 2, quantity: 100)
  @food1.author_id = @user.id
  @food1.save
  end


  it 'shows the  food Button' do
    visit foods_path
    expect(page).to have_content('Add Food')
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

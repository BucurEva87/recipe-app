require_relative '../rails_helper'

RSpec.describe 'Food page', type: :controller do
  let(:user) { create(:new_user) }
  it 'shows the Toggle button' do
    visit food_recipes_path
    expect(page).to have_button(class: 'toggle-btn')
  end

  it 'shows the modify link of  foods' do
    visit food_recipes_path
    expect(page).to have_content('Modify')
  end

  it 'shows the Remove link of  foods' do
    visit food_recipes_path
    expect(page).to have_content('Remove')
  end

  it 'shows the food name' do
    visit food_recipes_path
    expect(page).to have_content('Food')
  end

  it 'shows the Quantity' do
    visit food_recipes_path
    expect(page).to have_content(@food1.price.to_s)
  end
  it 'shows the food Value' do
    visit food_recipes_path
    expect(page).to have_content(@food1.quantity.to_s)
  end
end

# In spec/factories/recipes.rb

FactoryBot.define do
  factory :recipe do
    name { 'French Omellete' }
    author { create(:user) }
    preparation_time { 20 }
    cooking_time { 30 }
    description do
      'Heat a non-stick pan over medium heat and add butter pour in the egg mixture and use a spatula to gently stir.'
    end
  end
end

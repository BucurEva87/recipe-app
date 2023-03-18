FactoryBot.define do
  factory :recipe_food do
    recipe
    food
    quantity { Faker::Number.between(from: 1, to: 10) }
  end
end

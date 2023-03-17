FactoryBot.define do
  factory :food do
    name { "Dragon Fruit" }
    measurement_unit { 'lbs' }
    price { 1 }
    quantity { 100 }
    created_at { Time.now }
    updated_at { Time.now }
  end
end

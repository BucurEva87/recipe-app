FactoryBot.define do
  factory :recipes do
    name { "Recipe Name" }
    description { "Recipe Description" }
    author { nil }
  end
end

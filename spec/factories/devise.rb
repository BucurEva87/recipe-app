FactoryBot.define do
  factory :user do
    name { 'Example Test' }
    sequence :email do |n|
      "user#{n}@example.com"
    end
    password { '123456' }
    confirmed_at { Time.now }
  end
end

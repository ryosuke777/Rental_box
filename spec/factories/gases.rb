FactoryBot.define do
  factory :gase do
    name { Faker::Lorem.characters(number: 5) }
    amount { 5 }
    price { 2200.to_i }
    is_active { true }
  end
end

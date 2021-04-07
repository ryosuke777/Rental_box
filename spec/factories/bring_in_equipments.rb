FactoryBot.define do
  factory :bring_in_equipment do
    name { Faker::Lorem.characters(number: 5) }
    power_consumption { Faker::Number.within(range: 100..1500) }
    power_consumption_option { true }
    amount { Faker::Number.within(range: 1..3) }
    group
  end
end

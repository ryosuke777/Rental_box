FactoryBot.define do
  factory :cart_item do
    item_id { 1 }
    item_amount { Faker::Number.within(range: 1..10) }
    group
  end
end

FactoryBot.define do
  factory :item do
   name { Faker::Lorem.characters(number:5) }
   introduction { Faker::Lorem.characters(number:100) }
   price { Faker::Number.within(range: 6000..10000) }
   add_price { Faker::Number.within(range: 1000..3000) }
   power_consumption { Faker::Number.within(range: 201..400) }
   fuel_economy { Faker::Number.within(range: 0.1..1.5).round(2) }
   video {true}
   video_url {"https://www.youtube.com/watch?v=iMegsUWKMks"}
   manual {true}
   manual_url {"https://d-ucom.co.jp/image/pdf/daituki.pdf"}
   power_consumption_option {true}
   fuel_economy_option {true}
   genre
  end
end
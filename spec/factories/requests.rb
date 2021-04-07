FactoryBot.define do
  factory :request do
    item_for_sale { Faker::Lorem.characters(number: 5) }
    date { Faker::Number.within(range: 0..2) }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/profile.png'), 'image/png') }
    group
  end
end

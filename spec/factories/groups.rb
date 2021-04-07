FactoryBot.define do
  factory :group do
    gimei1 = Gimei.name
    gimei2 = Gimei.name
    group_name { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    group_name_kana { Faker::Lorem.characters(number: 10) }
    representative_name { gimei1.kanji }
    representative_name_kana { gimei1.katakana }
    representative_telephone_number { Faker::Number.number(digits: 11) }
    subdelegate_name { gimei2.kanji }
    subdelegate_name_kana { gimei2.katakana }
    subdelegate_telephone_number { Faker::Number.number(digits: 11) }
    subdelegate_email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end

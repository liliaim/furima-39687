FactoryBot.define do
  factory :order_address do
    token { 'tok_abcdefghijk00000000000000000' }
    postal_code { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    city { Gimei.city.kanji }
    house_number { Gimei.town.kanji }
    building_name { Faker::Address.community }
    phone_number { Faker::PhoneNumber.subscriber_number(length: 11) }
  end
end

FactoryBot.define do
  factory :item do
    item_name               { Faker::Camera.brand_with_model }
    item_description        { Faker::Movies::HarryPotter.quote }
    category_id             { Faker::Number.between(from: 2, to: 11) }
    condition_id            { Faker::Number.between(from: 2, to: 7) }
    shipping_cost_burden_id { Faker::Number.between(from: 2, to: 3) }
    prefecture_id           { Faker::Number.between(from: 2, to: 48) }
    days_until_shipment_id  { Faker::Number.between(from: 2, to: 4) }
    price                   { Faker::Number.between(from: 300, to: 9_999_999) }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end

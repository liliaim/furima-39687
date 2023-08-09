FactoryBot.define do
  factory :item do
    item_name               {Faker::Camera.brand_with_model}
    item_description        {Faker::Movies::HarryPotter.quote}
    category_id             {Faker::Number.between(from: 2, to: 12)}
    condition_id            {Faker::Number.between(from: 2, to: 8)}
    shipping_cost_burden_id {Faker::Number.between(from: 2, to: 4)}
    prefecture_id           {Faker::Number.between(from: 2, to: 48)}
    days_until_shipment_id  {Faker::Number.between(from: 2, to: 5)}
    price                   {Faker::Number.between(from: 300, to: 9999999)}

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end

  end
end

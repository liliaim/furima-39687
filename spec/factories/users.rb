FactoryBot.define do
  factory :user do
    nickname { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Alphanumeric.alphanumeric(number: 10, min_alpha: 3, min_numeric: 3) }
    password_confirmation { password }
    last_name { Gimei.last.kanji }
    first_name { Gimei.first.kanji }
    last_name_reading { Gimei.last.katakana }
    first_name_reading { Gimei.last.katakana }
    birth_date { Faker::Date.between(from: '1930-01-01', to: '2018-12-31') }
  end
end

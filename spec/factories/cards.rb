FactoryBot.define do
  factory :card do
    token { 'tok_abcdefghijk00000000000000000' }
    association :user

  end
end

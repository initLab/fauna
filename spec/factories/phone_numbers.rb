# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :phone_number do
    owner
    sequence(:phone_number) { |n| "088123456#{n}" }
  end
end

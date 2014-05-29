# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :phone do
    owner
    value { Faker::Number.number 10 }
    type 'phone'
  end
end

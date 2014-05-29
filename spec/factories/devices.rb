# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :device do
    owner
    value { Faker::Number.number 10 }
    type 'mac'
  end
end

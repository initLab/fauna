# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :phone_number do
    owner
    phone_number { Faker::PhoneNumber.phone_number }
  end
end

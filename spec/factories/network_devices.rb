# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :network_device do
    owner
    value { "#{Faker::Number.number(6)}".ljust(12, '0') }
  end
end

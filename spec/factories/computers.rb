# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :computer do
    owner
    value { "#{Faker::Number.number(6)}".ljust(12, '0') }
    type 'mac'
  end
end

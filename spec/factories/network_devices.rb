# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :network_device do
    owner
    mac_address { Faker::Internet.mac_address }
  end
end

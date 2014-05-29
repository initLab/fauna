# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { |u| Faker::Internet.email(u.name) }
    twitter { |u| Faker::Internet.user_name(u.name) }
    url { Faker::Internet.url }
    password Faker::Internet.password
    password_confirmation { |u| u.password }
  end
end

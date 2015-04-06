# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user, aliases: [:owner] do
    name { Faker::Name.name }
    sequence(:username) { |u| "username#{u}" }
    email { |u| Faker::Internet.email(u.name) }
    twitter 'foobar'
    url { Faker::Internet.url }
    password Faker::Internet.password
    password_confirmation { |u| u.password }
    confirmed_at Time.now
    github 'foobar'
    jabber 'foo@bar.com'
    gpg_fingerprint 'AAAA AAAA AAAA AAAA AAAA  AAAA AAAA AAAA AAAA AAAA'

    factory :board_member do
      after(:create) { |user| user.add_role(:board_member) }
    end
  end

  factory :registration, class: User do
    name { Faker::Name.name }
    sequence(:username) { |u| "username#{u}" }
    email { |u| Faker::Internet.email(u.username) }
    password Faker::Internet.password
    password_confirmation { |u| u.password }
  end
end

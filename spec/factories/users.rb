# frozen_string_literal: true

# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :user, aliases: [:owner] do
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
    sequence(:username) { |u| "username#{u}" }
    email { Faker::Internet.email }
    locale { I18n.available_locales.first.to_s }
    twitter { 'foobar' }
    url { Faker::Internet.url }
    password { Faker::Internet.password }
    password_confirmation(&:password)
    confirmed_at { Time.current }
    github { 'foobar' }
    jabber { 'foo@bar.com' }

    factory :board_member do
      after(:create) { |user| user.add_role Role.find_or_create_by!(name: :board_member) }
    end

    factory :trusted_member do
      after(:create) { |user| user.add_role Role.find_or_create_by!(name: :trusted_member) }
    end
  end

  factory :registration, class: 'User' do
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
    sequence(:username) { |u| "username#{u}" }
    email { |u| Faker::Internet.email(name: u.username) }
    password { Faker::Internet.password }
    password_confirmation(&:password)
  end
end

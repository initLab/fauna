FactoryBot.define do
  factory :door_action, class: 'Door::Action' do
    association :initiator, factory: :board_member
    origin_information { "IP: 127.0.0.1" }

    factory :door_actions_open, class: 'Door::Actions::Open'
    factory :door_actions_unlock, class: 'Door::Actions::Unlock'
    factory :door_actions_lock, class: 'Door::Actions::Lock'
  end
end

FactoryGirl.define do
  factory :door_action, class: 'Door::Action' do
    initiator board_member
    origin_information "IP: 127.0.0.1"
  end
end

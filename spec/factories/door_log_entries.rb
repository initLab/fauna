FactoryGirl.define do
  factory :door_status_notification, class: 'Door::StatusNotification' do
    door "Closed"
    latch "Locked"
  end
end

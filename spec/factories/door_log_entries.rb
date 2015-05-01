FactoryGirl.define do
  factory :door_log_entry, :class => 'Door::LogEntry' do
    door "Closed"
    latch "Locked"
  end
end

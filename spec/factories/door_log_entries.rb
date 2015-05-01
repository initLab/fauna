FactoryGirl.define do
  factory :door_log_entry, :class => 'Door::LogEntry' do
    door "closed"
    latch "locked"
  end
end

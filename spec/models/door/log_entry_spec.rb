require 'rails_helper'

module Door
  RSpec.describe LogEntry, type: :model do
    it 'has a door attribute' do
      expect(build(:door_log_entry, door: 'foo').door).to eq 'foo'
    end

    it 'has a latch attribute' do
      expect(build(:door_log_entry, latch: 'foo').latch).to eq 'foo'
    end
  end
end

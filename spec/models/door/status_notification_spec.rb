require 'rails_helper'

module Door
  RSpec.describe StatusNotification, type: :model do
    it 'has a door attribute' do
      expect(build(:door_status_notification, door: 'foo').door).to eq 'foo'
    end

    it 'has a latch attribute' do
      expect(build(:door_status_notification, latch: 'foo').latch).to eq 'foo'
    end

    describe '#door' do
      it 'can be only Open or Closed' do
        expect(build(:door_status_notification, door: 'foo')).to have_error_on :door
        expect(build(:door_status_notification, door: '')).to have_error_on :door
        expect(build(:door_status_notification, door: 'Open')).to_not have_error_on :door
        expect(build(:door_status_notification, door: 'Closed')).to_not have_error_on :door
      end
    end

    describe '#latch' do
      it 'can be only Unlocked or Locked' do
        expect(build(:door_status_notification, latch: 'foo')).to have_error_on :latch
        expect(build(:door_status_notification, latch: '')).to have_error_on :latch
        expect(build(:door_status_notification, latch: 'Unlocked')).to_not have_error_on :latch
        expect(build(:door_status_notification, latch: 'Locked')).to_not have_error_on :latch
      end
    end

  end
end

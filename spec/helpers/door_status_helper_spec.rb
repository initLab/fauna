require 'rails_helper'

describe DoorStatusHelper, type: :helper do
  before(:each) { Rails.cache.clear }

  describe '::door_status' do
    it 'returns the current status of the door' do
      status_indicator = instance_double(DoorStatus)
      expect(status_indicator).to receive(:latch).and_return(:locked)
      expect(DoorStatus).to receive(:new).and_return(status_indicator)
      expect(helper.door_status).to eq :locked
    end

    it 'caches the door status' do
      lifetime = Rails.application.config.door_status_manager.cache_lifetime
      expect(Rails.cache).to receive(:fetch).with('door_status', hash_including(expires_in: lifetime)).and_return(:locked)
      expect(helper.door_status).to eq :locked
    end
  end
end

require 'rails_helper'

module DoorStatusManager
  describe Dummy do
    describe '#status' do
      it 'returns {"door" => "closed", "latch" => "locked"}' do
        expect(subject.status).to eq({"door" => "closed", "latch" => "locked"})
      end
    end
  end
end

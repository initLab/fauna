require 'rails_helper'

describe Door::CurrentStatus do
  let(:backend) { Rails.application.config.door_status_manager.backend }

  context 'when the door status is retreived successfuly' do
    before do
      allow(backend).to receive(:status).and_return({'door' => 'closed', 'latch' => 'locked'})
    end

    describe '#door' do
      it 'returns the state of the door' do
        expect(subject.door).to eq :closed
      end
    end

    describe '#latch' do
      it 'returns the state of the latch' do
        expect(subject.latch).to eq :locked
      end
    end
  end

  context 'when the door status couldn\'t be retreived' do
    before do
      allow(backend).to receive(:status).and_raise(StandardError)
    end

    describe '#door' do
      it 'returns :unknown' do
        expect(subject.door).to eq :unknown
      end

      it 'logs the unsuccessful attempt' do
        expect(Rails.logger).to receive(:warn).with("Error retreiving door status: StandardError")
        subject.door
      end
    end

    describe '#latch' do
      it 'returns :unknown' do
        expect(subject.door).to eq :unknown
      end

      it 'logs the unsuccessful attempt' do
        expect(Rails.logger).to receive(:warn).with("Error retreiving door status: StandardError")
        subject.door
      end
    end
  end
end

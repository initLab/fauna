require 'rails_helper'

describe Door::StatusManager::Pesho do
  let(:client) { instance_double JSONClient }
  let(:message) { instance_double HTTP::Message }

  before do
    allow(JSONClient).to receive(:new).and_return client
    allow(client).to receive(:connect_timeout=)
    allow(client).to receive(:send_timeout=)
    allow(client).to receive(:receive_timeout=)
    allow(client).to receive(:get).and_return(message)
    allow(client).to receive(:post).and_return(message)
  end

  it 'sets the correct time out for the HTTP connections' do
    timeout = Rails.application.config.door_status_manager.timeout
    expect(client).to receive(:connect_timeout=).with(timeout)
    expect(client).to receive(:send_timeout=).with(timeout)
    expect(client).to receive(:receive_timeout=).with(timeout)
    Door::StatusManager::Pesho.new
  end

  context 'when the Pesho instance returns HTTP 200' do
    before do
      allow(message).to receive(:ok?).and_return(true)
    end

    describe '#status' do
      it 'returns the hash that results from parsing the JSON response' do
        allow(message).to receive(:body).and_return({'door' => 'closed', 'latch' => 'locked'})
        expect(subject.status).to eq({"door" => "closed", "latch" => "locked"})
      end
    end

    describe '#lock!' do
      it 'returns the hash that results from parsing the JSON response' do
        allow(message).to receive(:body).and_return({'door' => 'closed', 'latch' => 'locked'})
        expect(subject.lock!).to eq({"door" => "closed", "latch" => "locked"})
      end
    end

    describe '#unlock!' do
      it 'returns the hash that results from parsing the JSON response' do
        allow(message).to receive(:body).and_return({'door' => 'closed', 'latch' => 'unlocked'})
        expect(subject.unlock!).to eq({"door" => "closed", "latch" => "unlocked"})
      end
    end
  end

  context 'when the Pesho instance does not return HTTP 200' do
    before do
      allow(message).to receive(:ok?).and_return(false)
      allow(message).to receive(:status).and_return(500)
    end

    describe '#status' do
      it 'raises a Door::StatusManager::Error' do
        expect { subject.status }.to raise_error Door::StatusManager::Error
      end
    end

    describe '#lock!' do
      it 'raises a Door::StatusManager::Error' do
        expect { subject.lock! }.to raise_error Door::StatusManager::Error
      end
    end

    describe '#unlock!' do
      it 'raises a Door::StatusManager::Error' do
        expect { subject.unlock! }.to raise_error Door::StatusManager::Error
      end
    end
  end
end

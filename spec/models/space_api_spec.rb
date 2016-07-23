require 'rails_helper'

describe SpaceApi do
  let (:spaceapi_config) { {foo: '123', bar: '345'} }
  before { stub_const "SPACEAPI_CONFIG", spaceapi_config }

  it 'has methods for all keys in the SPACEAPI_CONFIG' do
    spaceapi_config.each do |key, _|
      expect(SpaceApi.new).to respond_to key
    end
  end

  it 'sets the return values of all methods to the values in SPACEAPI_CONFIG' do
    spaceapi_config.each do |key, value|
      expect(SpaceApi.new.public_send(key)).to eq value
    end
  end

  describe '#to_json' do
    it 'returns a json object that contains all attributes of the class' do
      expected = HashWithIndifferentAccess.new(SpaceApi.new.serializable_hash)
      actual = JSON.parse(expected.to_json)
      expect(actual).to eq expected
    end
  end

  describe '#api' do
    it 'returns 13' do
      expect(SpaceApi.new.api).to eq '0.13'
    end
  end

  describe '#sensors' do
    let(:backend) { Rails.application.config.door_status_manager.backend }

    context 'when there are people in the lab' do
      it 'returns a hash containing people_present: {value: <number of people>}' do
        allow(Presence).to receive(:present_users).and_return(create_list(:user, 2))
        expect(SpaceApi.new.sensors[:present_users][:value]).to eq(2)
      end

      it 'returns a hash containing people_present: {names: <array of the names of the present people>}' do
        present_users = create_list(:user, 2)
        allow(Presence).to receive(:present_users).and_return(present_users)
        expect(SpaceApi.new.sensors[:present_users][:names]).to eq(present_users.map(&:name))
      end
    end

    context 'when there are not people in the lab' do
      it 'returns a hash containing people_present: {value: 0}' do
        expect(SpaceApi.new.sensors[:present_users]).to eq({value: 0})
      end

      it 'returns a hash containing a people_present hash that contains no names key' do
        expect(SpaceApi.new.sensors[:present_users][:names]).to be_nil
      end
    end

    context 'when the door is locked' do
      before do
        allow(backend).to receive(:status).and_return({"door" => "closed", "latch" => "locked"})
      end

      it 'returns a hash containing door_locked: {value: true, location: "Front"}' do
        expect(SpaceApi.new.sensors[:door_locked]).to eq({value: true, location: "Front"})
      end
    end

    context 'when the door is unlocked' do
      before do
        allow(backend).to receive(:status).and_return({"door" => "closed", "latch" => "unlocked"})
      end

      it 'returns a hash containing door_locked: {value: false, location: "Front"}' do
        expect(SpaceApi.new.sensors[:door_locked]).to eq({value: false, location: "Front"})
      end
    end

    context 'when the door is in an unknown state' do
      before do
        allow(backend).to receive(:status).and_return({"door" => "closed", "latch" => "unknown"})
      end

      it 'returns a hash that does not contain a door_locked key' do
        expect(SpaceApi.new.sensors[:door_locked]).to be_nil
      end
    end
  end

  describe '#state' do
    let(:backend) { Rails.application.config.door_status_manager.backend }

    context 'when the door is locked' do
      before do
        allow(backend).to receive(:status).and_return({"door" => "closed", "latch" => "locked"})
      end

      it 'returns a hash that contains open: false' do
        expect(SpaceApi.new.status[:open]).to be_falsy
      end
    end

    context 'when the door is unlocked' do
      before do
        allow(backend).to receive(:status).and_return({"door" => "closed", "latch" => "unlocked"})
      end

      it 'returns a hash that contains open: true' do
        expect(SpaceApi.new.status[:open]).to be_truthy
      end
    end

    context 'when the door is in an unknown state' do
      before do
        allow(backend).to receive(:status).and_return({"door" => "closed", "latch" => "unknown"})
      end

      it 'returns a hash that contains open: nil' do
        expect(SpaceApi.new.status[:open]).to be_nil
      end
    end
  end
end

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
    it 'returns 0.13' do
      expect(SpaceApi.new.api).to eq '0.13'
    end
  end

  describe '#sensors' do
    let(:backend) { Rails.application.config.door_status_manager.backend }
    describe 'its entry with key people_now_present' do
      it 'is an array' do
        expect(SpaceApi.new.sensors[:people_now_present]).to be_an Array
      end

      it 'contains a single member' do
        expect(SpaceApi.new.sensors[:people_now_present].count).to eq 1
      end

      it 'contains a member that is a hash with the name of the hackerspace in its entry with a key of location' do
        stub_const "SPACEAPI_CONFIG", {'space' => 'foobar'}
        expect(SpaceApi.new.sensors[:people_now_present][0][:location]).to eq 'foobar'
      end
    end

    context 'when there are people in the lab' do
      describe 'its entry with key people_now_present' do
        it 'contains a member that is a hash with the current number of present people in its entry with a key of value' do
          allow(Presence).to receive(:present_users).and_return(create_list(:user, 2))
          expect(SpaceApi.new.sensors[:people_now_present][0][:value]).to eq 2
        end

        it 'contains a member that is a hash with the names of the present users in its entry with a key of names' do
          present_people = create_list :user, 2
          allow(Presence).to receive(:present_users).and_return(present_people)
          expect(SpaceApi.new.sensors[:people_now_present][0][:names]).to eq(present_people.map(&:name))
        end
      end
    end

    context 'when there are not people in the lab' do
      describe 'its entry with key people_now_present' do
        it 'contains a member that is a hash with the current number of present people in its entry with a key of value' do
          allow(Presence).to receive(:present_users).and_return([])
          expect(SpaceApi.new.sensors[:people_now_present][0][:value]).to eq 0
        end

        it 'contains a member that is a hash that does not have an entry with a key of names' do
          allow(Presence).to receive(:present_users).and_return([])
          expect(SpaceApi.new.sensors[:people_now_present][0]).to_not have_key :names
        end
      end
    end

    context 'when the door is locked' do
      before do
        allow(backend).to receive(:status).and_return({"door" => "closed", "latch" => "locked"})
      end

      it 'returns a hash containing an entry with a key door_locked and value - an array containing {value: true, location: "Front"}' do
        expect(SpaceApi.new.sensors[:door_locked]).to include({value: true, location: "Front"})
      end
    end

    context 'when the door is unlocked' do
      before do
        allow(backend).to receive(:status).and_return({"door" => "closed", "latch" => "unlocked"})
      end

      it 'returns a hash containing an entry with a key door_locked and value - an array containing {value: false, location: "Front"}' do
        expect(SpaceApi.new.sensors[:door_locked]).to include({value: false, location: "Front"})
      end
    end

    context 'when the door is in an unknown state' do
      before do
        allow(backend).to receive(:status).and_return({"door" => "closed", "latch" => "unknown"})
      end

      it 'returns a hash that does not contain an entry with a key of door_locked' do
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
        expect(SpaceApi.new.state[:open]).to be_falsy
      end
    end

    context 'when the door is unlocked' do
      before do
        allow(backend).to receive(:status).and_return({"door" => "closed", "latch" => "unlocked"})
      end

      it 'returns a hash that contains open: true' do
        expect(SpaceApi.new.state[:open]).to be_truthy
      end
    end

    context 'when the door is in an unknown state' do
      before do
        allow(backend).to receive(:status).and_return({"door" => "closed", "latch" => "unknown"})
      end

      it 'returns a hash that contains open: nil' do
        expect(SpaceApi.new.state[:open]).to be_nil
      end
    end
  end
end

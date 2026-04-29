# frozen_string_literal: true

require 'rails_helper'

describe RadWho, type: :model do
  let :sample_output do
    <<~MACS
      0000000C-AA-BB-CC-DD-EE-D8
      00000001-AA-BB-CC-DD-EE-8C
      00000005-AA-BB-CC-DD-EE-8C
      0000216A-AA-BB-CC-DD-EE-F0
    MACS
  end

  describe '#mac_addresses' do
    it 'normalizes the mac address to a downcase colon-delimited form' do
      allow(described_class).to receive(:radwho).and_return "0000000C-AA-AA-AA-AA-AA-AA\n"

      expect(described_class.new.mac_addresses).to all match(/\A[0-9a-f]{2}:([0-9a-f]{2}:){4}[0-9a-f]{2}\z/)
    end

    context 'when the radwho output is empty' do
      it 'returns an empty list' do
        allow(described_class).to receive(:radwho).and_return ''
        expect(described_class.new.mac_addresses).to be_empty
      end
    end

    it 'contains only unique MAC addresses' do
      allow(described_class).to receive(:radwho).and_return sample_output

      mac_addresses = described_class.new.mac_addresses
      expect(mac_addresses).to eq mac_addresses.uniq
    end

    context 'when the radwho output contains badly formatted entries' do
      let :sample_output do
        <<~NOTMACS
          0000000C-AA-BB-CC-DD-EE-D8

          00000001-AA-BB-CC-DD-EE-Z
          00000005-AA-BB-CC-DD
          foobar
        NOTMACS
      end

      it 'contains only correctly formatted MAC addresses' do
        allow(described_class).to receive(:radwho).and_return sample_output

        expect(described_class.new.mac_addresses).to all(match(/\A[0-9A-F]{2}([:-]?)([0-9A-F]{2}\1){4}[0-9A-F]{2}\z/i))
      end
    end
  end

  describe '#present_known_and_visible_users' do
    it 'returns a list of users that have entered their device MACs' do
      device = create(:network_device, mac_address: 'aa:bb:cc:dd:ee:ff',
                                       owner: create(:user, announce_my_presence: true))
      allow(described_class).to receive(:radwho).and_return "0000000C-AA-BB-CC-DD-EE-FF\n"
      expect(described_class.new.present_known_and_visible_users.count).to eq 1
      expect(described_class.new.present_known_and_visible_users).to include(device.owner)
    end

    it 'does not list users by devices that are are not to be used for presence detection' do
      device = create(:network_device, mac_address: 'aa:bb:cc:dd:ee:ff', use_for_presence: false,
                                       owner: create(:user, announce_my_presence: true))
      allow(described_class).to receive(:radwho).and_return "0000000C-AA-BB-CC-DD-EE-FF\n"
      expect(described_class.new.present_known_and_visible_users).not_to include(device.owner)
    end

    it "does not list users that have stated they don't want to be visible" do
      device = create(:network_device, mac_address: 'aa:bb:cc:dd:ee:ff',
                                       owner: create(:user, announce_my_presence: false))
      allow(described_class).to receive(:radwho).and_return "0000000C-AA-BB-CC-DD-EE-FF\n"
      expect(described_class.new.present_known_and_visible_users).not_to include(device.owner)
    end
  end

  describe '#present_unknown_users' do
    before do
      allow(described_class).to receive(:radwho).and_return sample_output
    end

    it 'returns a list of unknown user entries for MACs that are not in the database' do
      unknown_users = described_class.new.present_unknown_users
      expect(unknown_users.map(&:username)).to all eq('mystery_user')
    end

    it 'returns unknown user objects that are all not stored in the database' do
      expect(described_class.new.present_unknown_users).to all be_new_record
    end

    it 'does not return unknown user entries for devices that are not to be used for presence detection' do
      create(:network_device, mac_address: 'aa:bb:cc:dd:ee:ff', use_for_presence: false,
                              owner: create(:user, announce_my_presence: true))
      allow(described_class).to receive(:radwho).and_return "0000000C-AA-BB-CC-DD-EE-FF\n"
      expect(described_class.new.present_unknown_users).to be_empty
    end

    it 'includes users with a turned off announce_my_presence flag' do
      create(:network_device, mac_address: 'aa:bb:cc:dd:ee:ff', owner: create(:user, announce_my_presence: false))
      allow(described_class).to receive(:radwho).and_return "0000000C-AA-BB-CC-DD-EE-FF\n"
      expect(described_class.new.present_unknown_users).not_to be_empty
    end
  end

  describe '#present_users' do
    before { allow(described_class).to receive(:radwho).and_return sample_output }

    it 'returns a list of all users -- both known and unknown' do
      create :network_device, mac_address: 'aa:bb:cc:dd:ee:d8'

      expect(described_class.new.present_users.count).to eq 3
    end

    it 'return the users with an announce_my_presence flag unset as unknown' do
      device = create :network_device, mac_address: 'aa:bb:cc:dd:ee:d8',
                                       owner: create(:user, announce_my_presence: false)

      expect(described_class.new.present_users.count).to eq 3
      expect(described_class.new.present_users).not_to include device.owner
    end
  end

  describe '#sessions' do
    it 'is a hash map of current sessions for each MAC address' do
      allow(described_class).to receive(:radwho).and_return sample_output

      expect(described_class.new.sessions['aa:bb:cc:dd:ee:d8']).to eq ['0000000C']
      expect(described_class.new.sessions['aa:bb:cc:dd:ee:8c']).to eq %w[00000001 00000005]
    end
  end
end

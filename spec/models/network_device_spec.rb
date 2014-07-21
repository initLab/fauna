require 'rails_helper'

describe NetworkDevice do
  it 'cannot exist without an owner' do
    device = build :network_device, owner: nil
    expect(device).to have_error_on :owner_id
  end

  it 'cannot exist without a value' do
    device = build :network_device, value: nil
    expect(device).to have_error_on :value
  end

  describe '#mac_address' do
    it 'returns the value downcased and delimited with colons' do
      expect(build(:network_device, value: 'aaaaaaaaaaaa').mac_address).to eq 'aa:aa:aa:aa:aa:aa'
    end

    it 'returns an empty string when the value is empty or nil' do
      expect(build(:network_device, value: nil).mac_address).to eq ''
      expect(build(:network_device, value: '').mac_address).to eq ''
    end
  end

  describe 'value' do
    let(:mac_formats) do
      %w(aa:aa:aa:aa:aa:aa aa:Aa:aa:aa:aa:aa aa-aa-aa-aa-aa-aa aaaaaaaaaaaa)
    end

    let(:invalid_macs) do
      %w(aaagafaaaaaa aaaaafaaaaaaa aaaaafaaaaaaa abc 123)
    end

    it 'is stored capitalized and without delimiters' do
      mac_formats.each do |mac_format|
        expect(build(:network_device, value: mac_format).value).to eq 'AAAAAAAAAAAA'
      end
    end

    it 'can not be an invalid mac address' do
      invalid_macs.each do |mac_address|
        network_device = build :network_device, value: mac_address
        expect(network_device).to have_error_on :value
      end
    end

    it 'must be unique' do
      existing_network_device = create(:network_device)
      new_network_device = build :network_device, value: existing_network_device.value
      expect(new_network_device).to have_error_on :value
    end
  end
end

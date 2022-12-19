require "rails_helper"

describe NetworkDevice do
  it "cannot exist without an owner" do
    device = build :network_device, owner: nil
    expect(device).to have_error_on :owner_id
  end

  describe "#mac_address" do
    let(:mac_formats) do
      %w[aa:aa:aa:aa:aa:aa aa:Aa:aa:aa:aa:aa aa-aa-aa-aa-aa-aa aaaaaaaaaaaa]
    end

    let(:invalid_macs) do
      %w[aaagafaaaaaa aaaaafaaaaaaa aaaaafaaaaaaa abc 123]
    end

    it "must be present" do
      device = build :network_device, mac_address: nil
      expect(device).to have_error_on :mac_address
    end

    it "stores the mac_address downcased and delimited with colons" do
      expect(create(:network_device, mac_address: "aaaaaaaaaaaa").mac_address).to eq "aa:aa:aa:aa:aa:aa"
    end

    it "can not be an invalid mac address" do
      invalid_macs.each do |mac_address|
        network_device = build :network_device, mac_address: mac_address
        expect(network_device).to have_error_on :mac_address
      end
    end

    it "must be unique" do
      existing_network_device = create(:network_device)
      new_network_device = build :network_device, mac_address: existing_network_device.mac_address
      expect(new_network_device).to have_error_on :mac_address
    end
  end
end

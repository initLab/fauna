require 'rails_helper'

describe Computer do
  it { is_expected.to be_a Device }

  describe '::sti_name' do
    it 'is mac' do
      expect(Computer.sti_name).to eq 'mac'
    end
  end

  describe '#mac_address' do
    it 'returns the value downcased and delimited with colons' do
      expect(build(:computer, value: 'aaaaaaaaaaaa').mac_address).to eq 'aa:aa:aa:aa:aa:aa'
    end

    it 'returns an empty string when the value is empty or nil' do
      expect(build(:computer, value: nil).mac_address).to eq ''
      expect(build(:computer, value: '').mac_address).to eq ''
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
        expect(build(:computer, value: mac_format).value).to eq 'AAAAAAAAAAAA'
      end
    end

    it 'can not be an invalid mac address' do
      invalid_macs.each do |mac_address|
        computer = build :computer, value: mac_address
        expect(computer).to have_error_on :value
      end
    end

    it 'must be unique' do
      existing_computer = create(:computer)
      new_computer = build :computer, value: existing_computer.value
      expect(new_computer).to have_error_on :value
    end
  end
end

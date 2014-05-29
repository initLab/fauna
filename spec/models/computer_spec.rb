require 'spec_helper'

describe Computer do
  it { should be_a Device }

  describe '::sti_name' do
    it 'is mac' do
      Computer.sti_name.should eq 'mac'
    end
  end

  describe '#mac_address' do
    it 'returns the value downcased and delimited with colons' do
      build(:computer, value: 'aaaaaaaaaaaa').mac_address.should eq 'aa:aa:aa:aa:aa:aa'
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
        build(:computer, value: mac_format).value.should eq 'AAAAAAAAAAAA'
      end
    end

    it 'can not be an invalid mac address' do
      invalid_macs.each do |mac_address|
        build(:computer, value: mac_address).should have(1).error_on :value
      end
    end

    it 'must be unique' do
      computer = create(:computer)
      build(:computer, value: computer.value).should have(1).error_on :value
    end
  end
end

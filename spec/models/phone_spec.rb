require 'spec_helper'

describe Phone do
  it { should be_a Device }

  describe '::sti_name' do
    it 'is phone' do
      Phone.sti_name.should eq 'phone'
    end
  end

  describe '#number' do
    it 'returns the value prepended with 0' do
      build(:phone, value: '0883444555').number.should eq '0883444555'
      build(:phone, value: nil).number.should eq ''
    end
  end

  describe '#separated_number' do
    it 'returns the number separated in a 3-3-4 fashion' do
      build(:phone, value: '0883444555').separated_number.should eq '088 344 4555'
      build(:phone, value: nil).separated_number.should eq ''
    end
  end

  describe 'value' do
    it 'is stored without a starting 0' do
      build(:phone, value: '0883444555').value.should eq '883444555'
    end

    it 'can only be a 9-10 digit number' do
      build(:phone, value: '0883444555').should have(:no).errors_on :value
      build(:phone, value: '1234').should have(1).error_on :value
      build(:phone, value: '1234567890987').should have(1).error_on :value
      build(:phone, value: 'abcd').should have(2).errors_on :value
    end

    it 'must be unique' do
      create :phone, value: '0883444555'
      build(:phone, value: '0883444555').should have(1).error_on :value
    end
  end
end

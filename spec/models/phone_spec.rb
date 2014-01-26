require 'spec_helper'

describe Phone do
  it { should be_a(Device) }

  describe 'validation' do
    it { should_not allow_value('').for :value }
    it { should_not allow_value('abcdef').for :value }
  end

  describe 'phone number normalization' do
    it 'should normalize the phone number' do
      Phone.new(value: '0883444555').value.should eq '883444555'
    end
  end
end

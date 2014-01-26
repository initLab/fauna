require 'spec_helper'

describe Computer do
  it { should be_a(Device) }

  describe 'validation' do
    it { should allow_value('aa:aa:aa:aa:aa:aa').for(:value) }
    it { should allow_value('aa:Aa:aa:aa:aa:aa').for(:value) }
    it { should allow_value('aa-aa-aa-aa-aa-aa').for(:value) }
    it { should allow_value('aaaaaaaaaaaa').for(:value) }
    it { should_not allow_value('').for(:value) }
    it { should_not allow_value('aa:ag:af:aa:aa:aa').for(:value) }
    it { should_not allow_value('aa:aa:af:aa:aa:aaa').for(:value) }
    it { should_not allow_value('aaaaafaaaaaaa').for(:value) }
  end

  describe 'mac normalization' do
    it 'should normalize the mac address' do
      Computer.new(value: 'aa-aa-aa-aa-aa-aa').value.should eq 'AAAAAAAAAAAA'
    end
  end
end

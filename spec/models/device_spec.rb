require 'rails_helper'

describe Device do
  it 'cannot exist without an owner' do
    build(:device, owner: nil).should have(1).error_on :userid
  end

  it 'cannot exist without a value' do
    build(:device, value: nil).should have(1).error_on :value
  end

  describe 'STI hacks' do
    before do
      create :device, type: 'mac', value: 'aa:aa:aa:aa:aa:aa'
      create :device, type: 'phone', value: '0881222333'
    end

    it 'allow records with type mac to be recognized as Computers' do
      Device.where(type: 'mac').all? { |device| device.should be_a Computer }
    end

    it 'allow records with type phone to be recognized as Phones' do
      Device.where(type: 'phone').all? { |device| device.should be_a Phone }
    end
  end
end

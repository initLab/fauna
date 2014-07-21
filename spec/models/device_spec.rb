require 'rails_helper'

describe Device do
  it 'cannot exist without an owner' do
    device = build :device, owner: nil
    expect(device).to have_error_on :userid
  end

  it 'cannot exist without a value' do
    device = build :device, value: nil
    expect(device).to have_error_on :value
  end

  describe 'STI hacks' do
    before do
      create :device, type: 'mac', value: 'aa:aa:aa:aa:aa:aa'
    end

    it 'allow records with type mac to be recognized as Computers' do
      Device.where(type: 'mac').all? { |device| expect(device).to be_a Computer }
    end
  end
end

require 'rails_helper'

describe Phone do
  it { should be_a Device }

  describe '::sti_name' do
    it 'is phone' do
      expect(Phone.sti_name).to eq 'phone'
    end
  end

  describe '#number' do
    it 'returns the value prepended with 0' do
      expect(build(:phone, value: '0883444555').number).to eq '0883444555'
      expect(build(:phone, value: nil).number).to eq ''
    end
  end

  describe '#separated_number' do
    it 'returns the number separated in a 3-3-4 fashion' do
      expect(build(:phone, value: '0883444555').separated_number).to eq '088 344 4555'
      expect(build(:phone, value: nil).separated_number).to eq ''
    end
  end

  describe 'value' do
    it 'is stored without a starting 0' do
      expect(build(:phone, value: '0883444555').value).to eq '883444555'
    end

    it 'can be a 9-10 digit number' do
      expect(build(:phone, value: '0883444555')).to_not have_error_on :value
    end

    it 'cannot be anything else but a 9-10 digit number' do
      invalid_phone_numbers = ['1234', '1234567890987', 'abcdefghij']
      invalid_phone_numbers.each do |number|
        phone = build :phone, value: ''
        expect(phone).to have_error_on :value
      end
    end

    it 'must be unique' do
      existing_phone = create :phone, value: '0883444555'
      new_phone = build :phone, value: existing_phone.value
      expect(new_phone).to have_error_on :value
    end
  end
end

require 'rails_helper'

describe PhoneNumber do
  describe 'phone_number' do
    it 'can be a valid phone number' do
      expect(build(:phone_number, phone_number: '0883444555')).to_not have_error_on :phone_number
      expect(build(:phone_number, phone_number: '+359888344555')).to_not have_error_on :phone_number
    end

    it 'must be numeric' do
      expect(build(:phone_number, phone_number: 'abcd')).to have_error_on :phone_number
    end

    it 'must be unique' do
      existing_phone = create :phone_number, phone_number: '0883444555'
      new_phone = build :phone_number, phone_number: existing_phone.phone_number
      expect(new_phone).to have_error_on :phone_number
    end

    it 'must be present' do
      expect(build(:phone_number, phone_number: nil)).to have_error_on :phone_number
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

describe PhoneNumber, type: :model do
  describe 'phone_number' do
    it 'can be a valid phone number with zero' do
      expect(build(:phone_number, phone_number: '0883444555')).not_to have_error_on :phone_number
    end

    it 'can be a valid phone number with country code' do
      expect(build(:phone_number, phone_number: '+359888344555')).not_to have_error_on :phone_number
    end

    it 'can be a valid phone number with e164' do
      expect(build(:phone_number, phone_number: '00359888344555')).not_to have_error_on :phone_number
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

    it 'must be stored in a normalized form in the database' do
      phone_number = create :phone_number, phone_number: '0883444555'
      expect(described_class.find(phone_number.id).phone_number).to eq '+359883444555'
    end
  end
end

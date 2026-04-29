# frozen_string_literal: true

require 'rails_helper'

describe Role, type: :model do
  it 'is only valid whenever its name is one of the predefined ones' do
    expect(described_class.new(name: :foo)).to have_error_on :name
    expect(described_class.new(name: Role::PREDEFINED_ROLES.first)).not_to have_error_on :name
  end

  describe '#localized_name' do
    it 'returns the translated name of the role' do
      allow(I18n).to receive(:t).with('roles.board_member').and_return('УС')

      role = described_class.new name: :board_member

      expect(role.localized_name).to eq 'УС'
    end
  end

  describe '::predefined' do
    it 'returns instances of the predefined roles' do
      predefined_roles = described_class.predefined

      expect(predefined_roles.first).to be_a described_class
      expect(predefined_roles.map(&:name)).to eq Role::PREDEFINED_ROLES.map(&:to_s)
    end
  end
end

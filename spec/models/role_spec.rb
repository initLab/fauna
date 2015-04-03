require 'rails_helper'

describe Role do
  it 'is only valid whenever its name is one of the predefined ones' do
    expect(Role.new name: :foo).to have_error_on :name
    expect(Role.new name: Role::PREDEFINED_ROLES.first).to_not have_error_on :name
  end
end

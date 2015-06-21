require 'rails_helper'

RSpec.describe Door::Actions::Action, type: :model do
  it 'raises a NotImplementedError when created' do
    expect { subject.save }.to raise_error NotImplementedError
  end
end

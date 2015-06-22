require 'rails_helper'

RSpec.describe Door::Actions::Action, type: :model do
  it 'raises a NotImplementedError when created' do
    expect { subject.save }.to raise_error NotImplementedError
  end

  describe '::from_name' do
    it 'returns a new instance for known action names' do
      expect(Door::Actions::Action.from_name('open')).to be_a Door::Actions::Open
    end

    it 'returns nil if the action name is not known' do
      expect(Door::Actions::Action.from_name('foo')).to be nil
    end
  end
end

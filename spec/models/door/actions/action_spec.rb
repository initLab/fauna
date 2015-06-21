require 'rails_helper'

RSpec.describe Door::Actions::Action, type: :model do
  it 'is an abstract class' do
    expect(Door::Actions::Action).to be_abstract_class
    expect { Door::Actions::Action.new }.to raise_error NotImplementedError
  end

  describe '#execute!' do
    it 'raises a NotImplementedError' do
      expect { subject.execute! }.to raise_error NotImplementedError
    end
  end
end

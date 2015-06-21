require 'rails_helper'

RSpec.describe Door::Actions::Action, type: :model do
  describe '#execute!' do
    it 'raises a NotImplementedError' do
      expect { subject.execute! }.to raise_error NotImplementedError
    end
  end
end

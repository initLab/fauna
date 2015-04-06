require 'rails_helper'

describe ApplicationAuthorizer do
  describe 'class' do
    it 'lets board members do anything by default' do
      board_member = create :board_member
      expect(ApplicationAuthorizer.default(:anything, board_member)).to be true
    end

    it "doesn't let all users do everything by default" do
      user = build :user
      expect(ApplicationAuthorizer.default(:anything, user)).to_not be true
    end
  end
end

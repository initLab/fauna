require 'rails_helper'

describe DoorHandleAuthorizer do
  describe 'class' do
    it 'lets board members create' do
      board_member = create :board_member
      expect(DoorHandleAuthorizer).to be_creatable_by board_member
    end

    it 'lets trusted members create' do
      trusted_member = create :trusted_member
      expect(DoorHandleAuthorizer).to be_creatable_by trusted_member
    end

    it "doesn't let users create" do
      user = build :user
      expect(DoorHandleAuthorizer).to_not be_creatable_by user
    end
  end
end

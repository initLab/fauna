require 'rails_helper'

describe DoorHandleAuthorizer do
  describe 'class' do
    it "lets users create" do
      user = build :user
      expect(DoorHandleAuthorizer).to be_creatable_by user
    end
  end
end

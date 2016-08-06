require 'rails_helper'

describe LightsPolicyAuthorizer do
  describe 'class' do
    it 'lets trusted users create' do
      user = create :trusted_member
      expect(LightsPolicyAuthorizer).to be_creatable_by user
    end

    it 'lets board members create' do
      user = create :board_member
      expect(LightsPolicyAuthorizer).to be_creatable_by user
    end

    it 'doesn\'t let other users create' do
      user = create :user
      expect(LightsPolicyAuthorizer).to_not be_creatable_by user
    end

    it 'lets trusted users read' do
      user = create :trusted_member
      expect(LightsPolicyAuthorizer).to be_readable_by user
    end

    it 'lets board members read' do
      user = create :board_member
      expect(LightsPolicyAuthorizer).to be_readable_by user
    end

    it 'doesn\'t let other users read' do
      user = create :user
      expect(LightsPolicyAuthorizer).to_not be_readable_by user
    end
  end
end

require 'rails_helper'

describe Lights::Policy do
  describe '#authorizer_name' do
    it 'is LightsPolicyAuthorizer' do
      policy = Lights::Policy.new(policy: 'force_on')
      expect(policy.authorizer_name).to eq 'LightsPolicyAuthorizer'
    end
  end
end

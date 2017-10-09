require 'rails_helper'

describe Lights::PoliciesController, type: :controller do
  describe 'PATCH #update' do
    describe 'authentication' do
      it 'redirects to the login page when the current user is not signed in' do
        patch :update, params: {lights_policy: 'always_on'}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'authorization' do
      it 'returns HTTP 403 Forbidden if the current user cannot change lights policy' do
        sign_in create :user
        patch :update, params: {lights_policy: 'always_on'}
        expect(response.code).to eq '403'
      end
    end

    describe 'when performed by an authorized user' do
      before do
        sign_in create :trusted_member
      end

      it 'redirects to the previous page' do
        request.env['HTTP_REFERER'] = 'back'
        patch :update, params: {lights_policy: {policy:'always_on'}}
        expect(response).to redirect_to 'back'
      end
    end
  end
end

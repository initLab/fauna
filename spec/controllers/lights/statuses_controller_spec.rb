require 'rails_helper'

describe Lights::StatusesController, type: :controller do
  describe 'GET #show' do
    describe 'authentication' do
      it 'redirects to the login page when the current user is not signed in' do
        get :show
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'authorization' do
      it 'returns HTTP 403 Forbidden if the current user cannot change lights policy' do
        sign_in create :user
        get :show
        expect(response.code).to eq '403'
      end
    end

    describe 'when performed by an authorized user' do
      before do
        sign_in create :trusted_member
      end

      it 'returns HTTP Success' do
        get :show
        expect(response.code).to eq '200'
      end
    end
  end
end

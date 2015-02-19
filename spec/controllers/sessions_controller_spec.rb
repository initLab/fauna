require 'rails_helper'

describe SessionsController do
  before { @request.env["devise.mapping"] = Devise.mappings[:user] }

  it { is_expected.to be_kind_of Devise::SessionsController }

  describe 'POST #create' do
    describe 'after sign in' do
      let(:user) { create :user }

      describe 'when there is no stored location' do
        it 'redirects to the user profile path' do
          expect(post(:create, user: {login: user.username, password: user.password})).to redirect_to edit_user_registration_path
        end
      end

      describe 'when there is a stored location' do
        it 'redirects to the stored path' do
          session["user_return_to"] = '/some-path'
          expect(post(:create, user: {login: user.username, password: user.password})).to redirect_to '/some-path'
        end
      end
    end
  end
end

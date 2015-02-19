require 'rails_helper'

describe Devise::RegistrationsController do
  before { @request.env["devise.mapping"] = Devise.mappings[:user] }

  it { is_expected.to be_kind_of Devise::RegistrationsController }

  describe 'POST #create' do
    describe 'after sign up' do
      describe 'when there is no stored location' do
        it 'redirects to the user profile path' do
          expect(post(:create, user: attributes_for(:registration))).to redirect_to edit_user_registration_path
        end
      end

      describe 'when there is a stored location' do
        it 'redirects to the stored path' do
          session["user_return_to"] = '/some-path'
          expect(post(:create, user: attributes_for(:registration))).to redirect_to '/some-path'
        end
      end
    end
  end

  describe 'PUT #update' do
    it 'redirects to the user profile path after update' do
      @user = create :user
      sign_in @user
      expect(put(:update, user: {name: 'some name', current_password: @user.password})).to redirect_to edit_user_registration_path
    end
  end
end

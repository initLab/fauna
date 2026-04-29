# frozen_string_literal: true

require 'rails_helper'

describe Devise::SessionsController, type: :request do
  # before { @request.env['devise.mapping'] = Devise.mappings[:user] }

  it { is_expected.to be_a described_class }

  describe 'POST #create' do
    describe 'after sign in' do
      let(:user) { create :user }

      describe 'when there is no stored location' do
        it 'redirects to the user profile path' do
          expect(
            post(new_user_session_path,
                 params: { user: { login: user.username, password: user.password } })
          ).to redirect_to edit_user_registration_path
        end
      end
    end
  end
end

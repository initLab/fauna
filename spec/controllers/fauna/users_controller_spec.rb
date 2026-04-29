# frozen_string_literal: true

require 'rails_helper'

module Fauna
  describe UsersController, type: :request do
    describe 'GET #index' do
      describe 'authentication' do
        it 'redirects if the current user has not been authenticated' do
          get fauna_users_path
          expect(response).to be_redirect
        end

        it 'returns HTTP 403 Forbidden if the current user is not a board member' do
          sign_in create :user
          get fauna_users_path
          expect(response).to be_forbidden
        end
      end

      it 'returns an HTTP 200 OK status code' do
        users = create_list :user, 3
        current_user = users.last
        current_user.add_role Role.find_or_create_by name: :board_member
        sign_in current_user

        get fauna_users_path
        expect(response).to have_http_status(:ok)
      end
    end
  end
end

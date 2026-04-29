# frozen_string_literal: true

require 'rails_helper'

module Fauna
  describe RoleAssignmentsController, type: :controller do
    describe 'POST #create' do
      before do
        @current_user = create :board_member
        sign_in @current_user
      end

      describe 'authentication' do
        before do
          @user = create :user
          @board_member = Role.find_or_create_by!(name: :board_member)
          sign_out @current_user
        end

        it 'returns HTTP 401 Unauthorized when the current user is not authenticated' do
          post :create, params: { user_id: @user.id, role: { name: :board_member } }, format: :js
          expect(response).to have_http_status(:unauthorized)
        end

        it 'returns HTTP 403 Forbidden when the current user is not authorized' do
          sign_in create :user
          post :create, params: { user_id: @user.id, role: { name: :board_member } }, format: :js
          expect(response).to have_http_status(:forbidden)
        end
      end

      context 'when a valid user and role are specified' do
        before do
          @user = create :user
          @board_member = Role.find_or_create_by!(name: :board_member)
          post :create,
               params: {
                 user_id: @user.id,
                 user_role: { role: @board_member.id, start_time: Time.current, end_time: nil }
               },
               format: :js
        end

        it 'adds the specified role to the user' do
          expect(@user).to be_role(:board_member)
        end

        it 'returns an HTTP 201 Created' do
          expect(response).to redirect_to fauna_user_role_assignments_path(user_id: @user.id)
        end
      end

      it 'raises a Record Not Found error when the user does not exist' do
        expect { post :create, params: { user_id: 1337, role: :board_member }, format: :js }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    describe 'DELETE #destroy' do
      before do
        @current_user = create :board_member
        sign_in @current_user
      end

      describe 'authentication' do
        before do
          @user = create :board_member
          @board_member = Role.find_or_create_by!(name: :board_member)

          sign_out @current_user
        end

        it 'returns HTTP 401 Unauthorized when the current user is not signed in' do
          delete :destroy, params: { user_id: @user.id, id: @board_member.id }, format: :js
          expect(response).to have_http_status(:unauthorized)
        end

        it 'returns HTTP 403 Forbidden when the current user is not authorized' do
          sign_in create :user
          delete :destroy, params: { user_id: @user.id, id: @board_member.id }, format: :js
          expect(response).to have_http_status(:forbidden)
        end
      end

      context 'when a valid user and role are specified' do
        before do
          @user = create :board_member
          @board_member = Role.find_or_create_by!(name: :board_member)
          @trusted_member = Role.find_or_create_by!(name: :trusted_member)

          delete :destroy, params: { user_id: @user.id, id: @board_member.id }, format: :js
        end

        it 'removes the specified role from the user' do
          expect(@user).not_to be_role(:board_member)
        end

        it 'goes back to the list of roles for the user' do
          expect(response).to redirect_to fauna_user_role_assignments_path(user_id: @user.id)
        end

        it 'returns an HTTP 422 Unprocessable Entity when the user does not have the specified role' do
          print @trusted_member
          delete :destroy, params: { user_id: @user.id, id: @trusted_member.id }, format: :js

          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end

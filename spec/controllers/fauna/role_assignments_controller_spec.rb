require 'rails_helper'

module Fauna
  describe RoleAssignmentsController do
    describe 'POST #create' do
      before do
        @current_user = create :board_member
      end

      before(:each) do
        sign_in @current_user
      end

      context 'when a valid user and role are specified' do
        before(:each) do
          @user = create :user
        end

        it 'redirects when the current user is not authenticated' do
          sign_out @current_user
          post :create, user_id: @user.id, role: {name: :board_member}
          expect(response).to be_redirect
        end

        it 'returns HTTP 403 Forbidden when the current user is not authorized' do
          sign_out @current_user
          sign_in create :user
          post :create, user_id: @user.id, role: {name: :board_member}
          expect(response).to be_forbidden
        end

        it 'adds the specified role to the user' do
          post :create, user_id: @user.id, role: {name: :board_member}
          expect(@user).to have_role(:board_member)
        end

        it 'returns an HTTP 201 Created' do
          post :create, user_id: @user.id, role: {name: :board_member}
          expect(response).to be_created
        end
      end

      it 'raises a Record Not Found error when the user does not exist' do
        expect { post :create, user_id: 1337, role: :board_member }.to raise_error ActiveRecord::RecordNotFound
      end

      it 'returns an HTTP 422 Unprocessable Entity when the specified role name is invalid' do
        allow(User).to receive(:find).and_return(build :user)

        post :create, user_id: 1337, role: {name: :foo}

        expect(response).to be_unprocessable
      end
    end

    describe 'DELETE #destroy' do
      before do
        @current_user = create :board_member
      end

      before(:each) do
        sign_in @current_user
      end

      context 'when a valid user and role are specified' do
        before(:each) do
          @user = create :board_member
        end

        it 'redirects when the current user is not authenticated' do
          sign_out @current_user
          delete :destroy, user_id: @user.id, role_name: :board_member
          expect(response).to be_redirect
        end

        it 'returns HTTP 403 Forbidden when the current user is not authorized' do
          sign_out @current_user
          sign_in create :user
          delete :destroy, user_id: @user.id, role_name: :board_member
          expect(response).to be_forbidden
        end

        it 'removes the specified role from the user' do
          delete :destroy, user_id: @user.id, role_name: :board_member
          expect(@user).to_not have_role(:board_member)
        end

        it 'returns HTTP 204 No Content' do
          delete :destroy, user_id: @user.id, role_name: :board_member
          expect(response.code).to eq '204'
        end
      end

      it 'raises a Record Not Found error when the user does not exist' do
        expect { delete :destroy, user_id: 1337, role_name: :board_member }.to raise_error ActiveRecord::RecordNotFound
      end

      it 'returns an HTTP 422 Unprocessable Entity when the user does not have the specified role' do
        allow(User).to receive(:find).and_return(build :user)

        delete :destroy, user_id: 1337, role_name: :foo

        expect(response).to be_unprocessable
      end
    end
  end
end

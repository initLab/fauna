require "rails_helper"

module Fauna
  describe RoleAssignmentsController do
    describe "POST #create" do
      before do
        @current_user = create :board_member
      end

      before(:each) do
        sign_in @current_user
      end

      describe "authentication" do
        before(:each) do
          @user = create :user
          sign_out @current_user
        end

        it "returns HTTP 401 Unauthorized when the current user is not authenticated" do
          post :create, params: {user_id: @user.id, role: {name: :board_member}}, format: :js
          expect(response).to have_http_status(:unauthorized)
        end

        it "returns HTTP 403 Forbidden when the current user is not authorized" do
          sign_in create :user
          post :create, params: {user_id: @user.id, role: {name: :board_member}}, format: :js
          expect(response).to have_http_status(:forbidden)
        end
      end

      context "when a valid user and role are specified" do
        before(:each) do
          @user = create :user
          post :create, params: {user_id: @user.id, role: {name: :board_member}}, format: :js
        end

        it "adds the specified role to the user" do
          expect(@user).to have_role(:board_member)
        end

        it "returns an HTTP 201 Created" do
          expect(response).to have_http_status(:created)
        end
      end

      it "raises a Record Not Found error when the user does not exist" do
        expect { post :create, params: {user_id: 1337, role: :board_member}, format: :js }.to raise_error ActiveRecord::RecordNotFound
      end

      it "returns an HTTP 422 Unprocessable Entity when the specified role name is invalid" do
        allow(User).to receive(:find).and_return(build(:user))

        post :create, params: {user_id: 1337, role: {name: :foo}}, format: :js

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    describe "DELETE #destroy" do
      before do
        @current_user = create :board_member
      end

      before(:each) do
        sign_in @current_user
      end

      describe "authentication" do
        before(:each) do
          @user = create :board_member
          sign_out @current_user
        end

        it "returns HTTP 401 Unauthorized when the current user is not signed in" do
          delete :destroy, params: {user_id: @user.id, role_name: :board_member}, format: :js
          expect(response).to have_http_status(:unauthorized)
        end

        it "returns HTTP 403 Forbidden when the current user is not authorized" do
          sign_in create :user
          delete :destroy, params: {user_id: @user.id, role_name: :board_member}, format: :js
          expect(response).to have_http_status(:forbidden)
        end
      end

      context "when a valid user and role are specified" do
        before(:each) do
          @user = create :board_member
          delete :destroy, params: {user_id: @user.id, role_name: :board_member}, format: :js
        end

        it "removes the specified role from the user" do
          expect(@user).to_not have_role(:board_member)
        end

        it "returns HTTP 200 OK" do
          expect(response).to have_http_status(:ok)
        end
      end

      it "raises a Record Not Found error when the user does not exist" do
        expect { delete :destroy, params: {user_id: 1337, role_name: :board_member}, format: :js }.to raise_error ActiveRecord::RecordNotFound
      end

      it "returns an HTTP 422 Unprocessable Entity when the user does not have the specified role" do
        allow(User).to receive(:find).and_return(build(:user))

        delete :destroy, params: {user_id: 1337, role_name: :foo}, format: :js

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end

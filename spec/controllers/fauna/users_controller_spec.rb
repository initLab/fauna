require "rails_helper"

module Fauna
  describe UsersController do
    describe "GET #index" do
      describe "authentication" do
        it "redirects if the current user has not been authenticated" do
          get "index"
          expect(response).to be_redirect
        end

        it "returns HTTP 403 Forbidden if the current user is not a board member" do
          sign_in create :user
          get "index"
          expect(response).to be_forbidden
        end
      end

      it "returns an HTTP 200 OK status code" do
        users = create_list :user, 3
        current_user = users.last
        current_user.add_role :board_member
        sign_in current_user

        get "index"
        expect(response).to have_http_status(:ok)
      end
    end
  end
end

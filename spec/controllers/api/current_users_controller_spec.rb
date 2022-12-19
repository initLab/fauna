require "rails_helper"

describe Api::CurrentUsersController, type: :controller do
  let(:user) { create :user }
  let(:token) { create :access_token, resource_owner_id: user.id, scopes: :account_data_read }

  describe "GET #show" do
    it "returns HTTP 200 OK for authenticated users" do
      get "show", params: {format: :json, access_token: token.token}
      expect(response.code).to eq "200"
    end

    it "returns HTTP 401 Authentication Required for unauthenticated users" do
      get "show", params: {format: :json, access_token: "foo"}
      expect(response.code).to eq "401"
    end
  end
end

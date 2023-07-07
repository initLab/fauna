require "rails_helper"

describe UsersController, type: :controller do
  describe "GET #present" do
    it "returns an HTTP 200 OK status code" do
      get "present"
      expect(response).to have_http_status(:ok)
    end
  end
end

require "rails_helper"

describe Api::UsersController, type: :controller do
  describe "GET #present" do
    it "returns HTTP 200 OK" do
      get "present", format: :json
      expect(response.code).to eq "200"
    end
  end
end

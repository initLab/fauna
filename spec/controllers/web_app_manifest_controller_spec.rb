require "rails_helper"

describe WebAppManifestController, type: :controller do
  describe "#GET manifest" do
    it "returns HTTP 200 Success" do
      get :manifest, format: :json
      expect(response.code).to eq "200"
    end
  end
end

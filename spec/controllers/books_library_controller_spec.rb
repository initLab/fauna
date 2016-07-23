require 'rails_helper'

RSpec.describe BooksLibraryController, type: :controller do

  describe "GET #homepage" do
    it "returns http success" do
      get :homepage
      expect(response).to have_http_status(:success)
    end
  end

end

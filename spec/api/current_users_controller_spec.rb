require 'rails_helper'

describe Api::CurrentUsersController, type: :controller do
  describe 'GET #show' do
    it 'returns HTTP 200 OK for authenticated users' do
	  sign_in create :user
      get 'show', {format: :json}
      expect(response.code).to eq '200'
    end
	
    it 'returns HTTP 401 Authentication Required for unauthenticated users' do
      get 'show', {format: :json}
      expect(response.code).to eq '401'
    end
  end
end

require 'rails_helper'

describe SpaceApiController, type: :controller do
  describe '#GET status' do
    it 'returns json data' do
      get :status, format: :json
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'returns an HTTP 200 OK status code' do
      get :status, format: :json
      expect(response).to have_http_status(:ok)
    end
  end
end

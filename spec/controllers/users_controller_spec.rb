require 'rails_helper'

describe UsersController, type: :controller do
  describe 'GET #present_embeddable' do
    it 'returns HTTP 410 Gone' do
      get 'present_embeddable'
      expect(response).to have_http_status(:gone)
    end
  end

  describe 'GET #present' do
    it 'returns an HTTP 200 OK status code' do
      get 'present'
      expect(response).to have_http_status(:ok)
    end
  end
end

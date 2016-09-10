require 'rails_helper'

describe Api::Lights::StatusesController, type: :controller do
  describe 'GET #show' do
    it 'returns HTTP 200 OK' do
      get 'show', {format: :json}
      expect(response.code).to eq '200'
    end
  end
end

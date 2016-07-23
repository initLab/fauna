require 'rails_helper'

describe SpaceApiController, type: :controller do
  describe '#GET status' do
    it 'renders the status json template' do
      get :status, format: :json
      expect(response).to render_template('status')
    end

    it 'assigns an instance of the SpaceApi object to @space_api' do
      get :status, format: :json
      expect(assigns(:space_api)).to be_a SpaceApi
    end
  end
end

require 'rails_helper'

describe SpaceApiController, type: :controller do
  describe '#GET spaceapi' do
    it 'renders the spaceapi json template' do
      get :spaceapi, format: :json
      expect(response).to render_template('spaceapi')
    end

    it 'assigns an instance of the SpaceApi object to @space_api' do
      get :spaceapi, format: :json
      expect(assigns(:space_api)).to be_a SpaceApi
    end
  end
end

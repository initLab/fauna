require 'rails_helper'

describe NetworkDevicesController, type: :controller do
  let(:user) { create :user }
  before { sign_in user }

  describe 'GET #index' do
    it "assigns the user's devices to @network_devices" do
      users_devices = create_list :network_device, 3, owner: user
      others_devices = create_list :network_device, 3

      get 'index'
      expect(assigns(:network_devices)).to eq users_devices
    end
  end

  describe 'POST #create' do
    let(:network_device_attributes) { build(:network_device).attributes }

    it 'assigns the new network device to @network_device' do
      post 'create', network_device: {foo: :bar}
      expect(assigns(:network_device )).to be_a NetworkDevice
      expect(assigns(:network_device )).to be_new_record
    end

    context 'when passed valid parameters' do
      it 'creates a new network device' do
        expect { post :create, network_device: network_device_attributes }.to change(NetworkDevice, :count).by(1)
      end

      it 'redirects to the device index' do
        post :create, network_device: network_device_attributes
        expect(response).to redirect_to user_network_devices_path
      end
    end

    context 'when passed invalid parameters' do
      before do
        allow_any_instance_of(NetworkDevice).to receive(:save).and_return(false)
        post :create, network_device: network_device_attributes
      end

      it 'renders the new template' do
        expect(response).to render_template :new
      end

      it 'returns an unprocessable entity status' do
        expect(response).to be_unprocessable
      end
    end
  end

  describe 'PATCH #update' do
    let(:network_device) { create :network_device, owner: user }

    context 'when passed valid parameters' do
      it 'updates the specified network device' do
        network_device = create :network_device, owner: user, mac_address: 'aa:aa:aa:aa:aa:aa'
        patch :update, format: :js, id: network_device.id, network_device: {mac_address: 'aa:aa:aa:aa:aa:ab'}
        expect(assigns(:network_device).mac_address).to eq 'aa:aa:aa:aa:aa:ab'
      end
    end

    context 'when passed invalid parameters' do
      before do
        allow_any_instance_of(NetworkDevice).to receive(:save).and_return(false)
        patch :update, format: :js, id: network_device.id, network_device: network_device.attributes
      end

      it 'returns an unprocessable entity status' do
        expect(response).to be_unprocessable
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the specified network device' do
      network_device = create :network_device, owner: user
      expect { delete :destroy, id: network_device.id }.to change(NetworkDevice, :count).by(-1)
    end

    it 'redirects to the device index' do
      allow_any_instance_of(NetworkDevice).to receive(:destroy).and_return(true)
      network_device = create :network_device, owner: user
      delete :destroy, id: network_device.id
      expect(response).to redirect_to user_network_devices_path
    end
  end
end

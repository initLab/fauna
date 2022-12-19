require "rails_helper"

describe NetworkDevicesController, type: :controller do
  let(:user) { create :user }
  before { sign_in user }

  describe "GET #index" do
    it "returns a 200 OK HTTP status" do
      get "index"
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #create" do
    let(:network_device_attributes) { build(:network_device).attributes }

    context "when passed valid parameters" do
      it "creates a new network device" do
        expect { post :create, params: {network_device: network_device_attributes} }.to change(NetworkDevice, :count).by(1)
      end

      it "redirects to the device index" do
        post :create, params: {network_device: network_device_attributes}
        expect(response).to redirect_to user_network_devices_path
      end
    end

    context "when passed invalid parameters" do
      before do
        allow_any_instance_of(NetworkDevice).to receive(:save).and_return(false)
        post :create, params: {network_device: network_device_attributes}
      end

      it "returns an unprocessable entity status" do
        expect(response).to be_unprocessable
      end
    end
  end

  describe "PATCH #update" do
    let(:network_device) { create :network_device, owner: user }

    context "when passed valid parameters" do
      it "updates the specified network device" do
        network_device = create :network_device, owner: user, mac_address: "aa:aa:aa:aa:aa:aa"
        patch :update, format: :js, params: {id: network_device.id, network_device: {mac_address: "aa:aa:aa:aa:aa:ab"}}
        expect(network_device.reload.mac_address).to eq "aa:aa:aa:aa:aa:ab"
      end
    end

    context "when passed invalid parameters" do
      before do
        allow_any_instance_of(NetworkDevice).to receive(:save).and_return(false)
        patch :update, format: :js, params: {id: network_device.id, network_device: network_device.attributes}
      end

      it "returns an unprocessable entity status" do
        expect(response).to be_unprocessable
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the specified network device" do
      network_device = create :network_device, owner: user
      expect { delete :destroy, params: {id: network_device.id} }.to change(NetworkDevice, :count).by(-1)
    end

    it "redirects to the device index" do
      allow_any_instance_of(NetworkDevice).to receive(:destroy).and_return(true)
      network_device = create :network_device, owner: user
      delete :destroy, params: {id: network_device.id}
      expect(response).to redirect_to user_network_devices_path
    end
  end
end

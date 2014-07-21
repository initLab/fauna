class NetworkDevicesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :assign_network_device, only: [:edit, :update, :destroy]

  def new
    @network_device = NetworkDevice.new mac_address: current_mac_address
  end

  def create
    @network_device = NetworkDevice.new network_device_params
    @network_device.owner = current_user
    if @network_device.save
      render status: :created
    else
      render status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @network_device.update(network_device_params)
      render status: :ok
    else
      render status: :unprocessable_entity
    end
  end

  def destroy
    @network_device.destroy
  end

  private

  def network_device_params
    params.require(:network_device).permit(:mac_address)
  end

  def assign_network_device
    @network_device = NetworkDevice.find params[:id]
  end
end

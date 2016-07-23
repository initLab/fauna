class NetworkDevicesController < ApplicationController
  before_filter :authenticate_user!
  before_action :assign_network_device, only: [:edit, :update, :destroy]

  def index
    @network_devices = current_user.network_devices
  end

  def new
    @network_device = NetworkDevice.new
  end

  def create
    @network_device = NetworkDevice.new network_device_params
    @network_device.owner = current_user

    if @network_device.save
      redirect_to user_network_devices_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @network_device.update(network_device_params)
      redirect_to user_network_devices_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @network_device.destroy
    redirect_to user_network_devices_path
  end

  private

  def network_device_params
    params.require(:network_device).permit(:mac_address, :description, :use_for_presence)
  end

  def assign_network_device
    @network_device = NetworkDevice.find params[:id]
  end
end

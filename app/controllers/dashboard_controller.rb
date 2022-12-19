class DashboardController < ApplicationController
  def index
    @users = Presence.present_users
    @mqtt_sensors = SENSORS_CONFIG["mqtt"]["sensors"]
  end
end

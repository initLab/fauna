class DashboardController < ApplicationController
  def index
    @users = Presence.present_users
	@sensor_ids = SENSORS_CONFIG['thingspeak']['channel_ids']
  end
end

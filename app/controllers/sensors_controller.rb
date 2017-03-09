class SensorsController < ApplicationController
  def index
	@sensor_ids = SENSORS_CONFIG['thingspeak']['channel_ids']
  end
end

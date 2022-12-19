class SensorsController < ApplicationController
  def index
    @grafana = SENSORS_CONFIG["grafana"]
  end
end

class LightsController < ApplicationController
  def show
    @lights_status = LightsManager.status
  end
end

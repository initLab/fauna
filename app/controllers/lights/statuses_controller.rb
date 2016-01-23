class Lights::StatusesController < ApplicationController
  before_filter :authenticate_user!
  authorize_actions_for Lights::Policy

  def show
    @lights_status = Lights::StatusManager.status
    @lights_forced_on = Lights::StatusManager.forced_on?
  end
end

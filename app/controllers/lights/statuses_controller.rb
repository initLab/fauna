class Lights::StatusesController < ApplicationController
  before_filter :authenticate_user!
  authorize_actions_for Lights::Policy

  def show
    @policy_manager = Rails.application.config.lights_policy_manager.new
    @status = @policy_manager.status
    @policy = @policy_manager.policy
  end
end

class Lights::StatusesController < ApplicationController
  before_action :authenticate_user!

  def show
    authorize :lights_manipulation

    @policy_manager = Rails.application.config.lights_policy_manager.new
    @status = @policy_manager.status
    @policy = @policy_manager.policy
  rescue Pundit::NotAuthorizedError
    head :forbidden
  end
end

class Lights::PoliciesController < ApplicationController
  before_action :authenticate_user!
  authorize_actions_for Lights::Policy

  def update
    @lights_policy = Lights::Policy.new lights_policy_params

    if @lights_policy.update
      flash[:success] = I18n.t('views.lights.success')
      redirect_back fallback_location: lights_status_path
    else
      flash[:alert] = I18n.t('views.lights.an_error_occurred')
      redirect_to fallback_location: lights_status_path
    end
  end

  private

  def lights_policy_params
    params.require(:lights_policy).permit(:policy)
  end
end

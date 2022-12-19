require "active_support/concern"

module Api::PublicApiExposingController
  extend ActiveSupport::Concern

  included do
    before_action :set_access_control_headers
  end

  private

  def set_access_control_headers
    if request.format.json?
      response.headers["Access-Control-Allow-Origin"] = "*"
    end
  end
end

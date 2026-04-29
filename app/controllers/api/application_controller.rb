# frozen_string_literal: true

module Api
  class ApplicationController < ::ApplicationController
    protect_from_forgery with: :null_session

    protected

    def current_resource_owner
      User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end

    def pundit_user
      current_resource_owner
    end

    helper_method :current_resource_owner
  end
end

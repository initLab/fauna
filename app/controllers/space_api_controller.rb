# frozen_string_literal: true

class SpaceApiController < ApplicationController
  before_action :set_access_control_headers, only: :status
  before_action :authenticate_user!, only: :oauth_status

  def status
    @space_api = SpaceApi.new
  end

  def oauth_status
    @space_api = SpaceApi.new
    render :status
  end

  private

  def set_access_control_headers
    return unless request.format.json?

    response.headers['Access-Control-Allow-Origin'] = '*'
  end
end

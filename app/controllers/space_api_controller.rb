class SpaceApiController < ApplicationController
  before_action :set_access_control_headers, only: :status

  def status
    @space_api = SpaceApi.new
  end

    private
    def set_access_control_headers
      if request.format.json?
        response.headers['Access-Control-Allow-Origin'] = '*'
        response.headers['Access-Control-Request-Method'] = '*'
      end
    end
end

class UsersController < ApplicationController
  before_action :set_access_control_headers, only: :present

  def present
    @users = Arp.present_users
  end

  def present_embeddable
    head :gone
  end

  private
    def set_access_control_headers
      if request.format.json?
        response.headers['Access-Control-Allow-Origin'] = '*'
        response.headers['Access-Control-Request-Method'] = '*'
      end
    end
end

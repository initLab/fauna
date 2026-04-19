class DashboardController < ApplicationController
  def index
    redirect_to 'https://space.initlab.org', allow_other_host: true
  end
end

class Api::Lights::StatusesController < Api::ApplicationController
  include Api::PublicApiExposingController
  
  def show
    @status = ::Lights::CurrentStatus.new
  end
end

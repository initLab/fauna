class Api::Lights::StatusesController < Api::ApplicationController
  def show
    @status = ::Lights::CurrentStatus.new
  end
end

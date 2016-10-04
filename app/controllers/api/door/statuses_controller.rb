class Api::Door::StatusesController < Api::ApplicationController
  include Api::PublicApiExposingController

  def show
    @status = ::Door::CurrentStatus.new
  end
end

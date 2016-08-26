class Api::Door::StatusesController < Api::ApplicationController
  def show
    @status = ::Door::CurrentStatus.new
  end
end

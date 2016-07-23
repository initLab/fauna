class SpaceApiController < ApplicationController
  def status
    @space_api = SpaceApi.new
  end
end

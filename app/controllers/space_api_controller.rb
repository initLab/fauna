class SpaceApiController < ApplicationController
  def spaceapi
    @space_api = SpaceApi.new
  end
end

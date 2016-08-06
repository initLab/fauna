class WebAppManifestController < ApplicationController
  before_action :set_access_control_headers, only: :manifest

  def manifest
  end
end

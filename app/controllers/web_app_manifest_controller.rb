class WebAppManifestController < ApplicationController
  def manifest
    @icon_sizes = [16, 32, 36, 48, 57, 72, 96, 114, 120, 144, 152, 192, 256, 384, 512]
  end
end

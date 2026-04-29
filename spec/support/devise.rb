# frozen_string_literal: true

RSpec.configure do |config|
  # Add Devise's helpers for controller and view tests
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view
  config.include Devise::Test::IntegrationHelpers, type: :request
end

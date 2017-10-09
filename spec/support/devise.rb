RSpec.configure do |config|
  # Add Devise's helpers for controller and view tests
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view
end

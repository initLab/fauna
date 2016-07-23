RSpec.configure do |config|
  # Add Devise's helpers for controller tests
  config.include Devise::Test::ControllerHelpers, type: :controller
end

RSpec.configure do |config|
  # Add Devise's helpers for controller tests
  config.include Devise::TestHelpers, type: :controller
end

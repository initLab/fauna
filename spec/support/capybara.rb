require 'capybara/rspec'
require_relative 'helpers/general_system_spec_helpers'

Capybara.default_max_wait_time = 5
Capybara.asset_host = "http://localhost:3000"

Capybara.server = :puma, {Silent: true}
Capybara.javascript_driver = :selenium_chrome

# RSpec.configure do |config|
#   config.before(:each, type: :feature, js: true) do
#     driven_by :selenium, using: :headless_chrome, screen_size: [1920, 1080]
#   end
# end

RSpec.configure do |config|
  config.include GeneralSystemSpecHelpers, type: :feature

  config.alias_example_group_to :feature, capybara_feature: true, type: :feature
  config.alias_example_group_to :xfeature, capybara_feature: true, type: :feature, skip: "Temporarily disabled with xfeature"
  config.alias_example_group_to :ffeature, capybara_feature: true, type: :feature, focus: true
  config.alias_example_to :scenario
  config.alias_example_to :xscenario, skip: "Temporarily disabled with xscenario"
  config.alias_example_to :fscenario, focus: true
end

require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Fauna
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.available_locales = [:bg, :en]
    config.i18n.enforce_available_locales = true
    config.i18n.default_locale = :bg

    config.action_view.field_error_proc = Proc.new do |html_tag, instance|
      html_tag
    end

    # Tweak what's getting generated
    config.generators do |g|
      g.test_framework :rspec,
        fixtures:         true,
        view_specs:       false,
        helper_specs:     false,
        routing_specs:    true,
        controller_specs: true,
        request_specs:    false
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
    end

    config.door_status_manager = ActiveSupport::OrderedOptions.new

    config.to_prepare do
      Doorkeeper::AuthorizedApplicationsController.layout "application"
    end
  end
end

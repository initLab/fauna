source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 8.1.1"
gem "bootsnap"

# Use SCSS for stylesheets
gem "sprockets"
gem 'dartsass-sprockets'

# Use Uglifier as compressor for JavaScript assets
gem "uglifier"

# Use CoffeeScript for .js.coffee assets and views
gem "coffee-rails"

# Use jquery as the JavaScript library
gem "jquery-rails"

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder"

# Use devise for authentication
gem "devise"
gem "devise-i18n"

# Rails i18n
gem "rails-i18n"

# bundle exec rake doc:rails generates the API under doc/api.
gem "sdoc", require: false, group: :doc

# Spring speeds up development by keeping your application running in the
# background. Read more: https://github.com/rails/spring
gem "spring", group: :development

# Phone number validation
gem "phony_rails"

# Slim templating engine
gem "slim-rails"

# Use the Bootstrap CSS framework and the FA icon font
gem "bootstrap"
gem "font-awesome-sass", :github => 'sunbirddcim/font-awesome-sass'
gem "bootswatch", :github => "thomaspark/bootswatch"

# Gravatar helper
gem "gravatar-ultimate"
# Add Ruby 2.4.0 support
gem "xmlrpc"

# SpaceApi
gem 'ostruct'

# Use simple form for form building
gem "simple_form"
gem "cocoon"

# Use Kaminari for pagination
gem "kaminari"

# Use rolify and pundit for authorization
gem "pundit"

# Asynchronous job execution
gem "delayed_job"
gem "delayed_job_active_record"
gem "daemons"

# SNMP Protocol handling
gem "snmp"

# Database dumping
gem "yaml_db"

# OAuth
gem "doorkeeper", "> 1.0beta"
gem "doorkeeper-i18n"

gem "net-smtp", require: false
gem "matrix"

# CORS
gem "rack-cors"

group :development do
  gem "web-console"
end

# Use debugger
# gem 'debugger', group: [:development, :test]

group :test, :development do
  # Use SQLite for development
  gem "sqlite3"

  # RSpec for testing
  gem "rspec-rails"

  # Use factory bot instead of fixtures
  gem "factory_bot_rails"

  # Used for creating fake names, emails, etc.
  gem "faker"

  # Use Spring for RSpec
  gem "spring-commands-rspec"

  # Simplecov for code coverage statistics
  gem "simplecov"

  # Do feature testing with capybara
  gem "capybara"
  gem "capybara-screenshot"
  gem "selenium-webdriver"

  # File system modification testing
  gem "fakefs", require: "fakefs/safe"

  gem "byebug"

  gem "brakeman"
  gem "bundler-audit"
  gem "standard"
end

group :production do
  # Use postgresql as the database for Active Record in production
  gem "pg"

  gem "puma"

  gem "sd_notify"
end

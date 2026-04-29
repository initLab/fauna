source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'bootsnap'
gem 'rails', '~> 8.1.1'

# Use SCSS for stylesheets
gem 'dartsass-sprockets'
gem 'sprockets'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

# Use devise for authentication
gem 'devise'
gem 'devise-i18n'

# Rails i18n
gem 'rails-i18n'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', require: false, group: :doc

# Spring speeds up development by keeping your application running in the
# background. Read more: https://github.com/rails/spring
gem 'spring', group: :development

# Phone number validation
gem 'phony_rails'

# Slim templating engine
gem 'slim-rails'

# Use the Bootstrap CSS framework and the FA icon font
gem 'bootstrap'
gem 'font-awesome-sass', github: 'sunbirddcim/font-awesome-sass'

# Gravatar helper
gem 'gravatar-ultimate'
# Add Ruby 2.4.0 support
gem 'xmlrpc'

# SpaceApi
gem 'ostruct'

# Use simple form for form building
gem 'cocoon'
gem 'simple_form'

# Use Kaminari for pagination
gem 'kaminari'

# Use rolify and pundit for authorization
gem 'pundit'

# Asynchronous job execution
gem 'daemons'
gem 'delayed_job'
gem 'delayed_job_active_record'

# SNMP Protocol handling
gem 'snmp'

# Database dumping
gem 'yaml_db'

# OAuth
gem 'doorkeeper', '> 1.0beta'
gem 'doorkeeper-i18n'

gem 'matrix'
gem 'net-smtp', require: false

# CORS
gem 'rack-cors'

group :development do
  gem 'web-console'
end

# Use debugger
# gem 'debugger', group: [:development, :test]

group :test, :development do
  # Use SQLite for development
  gem 'sqlite3'

  # RSpec for testing
  gem 'rspec-rails'

  # Use factory bot instead of fixtures
  gem 'factory_bot_rails'

  # Used for creating fake names, emails, etc.
  gem 'faker'

  # Use Spring for RSpec
  gem 'spring-commands-rspec'

  # Simplecov for code coverage statistics
  gem 'simplecov'

  # Do feature testing with capybara
  gem 'capybara'

  # File system modification testing
  gem 'fakefs', require: 'fakefs/safe'

  gem 'byebug'

  gem 'bundler-audit'
  gem 'rubocop', require: false
  gem 'rubocop-capybara', require: false
  gem 'rubocop-factory_bot', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubocop-rspec_rails', require: false

  gem 'brakeman'
end

group :production do
  # Use postgresql as the database for Active Record in production
  gem 'pg'

  gem 'puma'

  gem 'sd_notify'
end

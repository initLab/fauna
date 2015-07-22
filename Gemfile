source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.3'

# Use SCSS for stylesheets
gem 'sass-rails'
gem 'sprockets', '~> 2.12'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more:
# https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

# Create decorators with Draper
gem 'draper'

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
gem 'bootstrap-sass'
gem 'bootstrap-sass-extras', github: 'doabit/bootstrap-sass-extras'
gem 'font-awesome-sass'

# Gravatar helper
gem 'gravatar-ultimate'

# Use simple form for form building
gem 'simple_form'
gem 'nested_form'

# Use Kaminari for pagination
gem 'kaminari'

# Use rolify and authority for authorization
gem 'rolify'
gem 'authority'

# GPG Signing
gem 'mail-gpg'

# HTTP requests
gem 'httpclient'

group :development do
  # Use Capistrano for deployment
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'

  gem 'pry'
  gem 'pry-rails'
  gem 'pry-doc'

  # Continuous testing with Guard
  gem 'guard-rspec'

  # Deploy to a puma  server
  gem 'capistrano3-puma'

  # Use SQLite for development
  gem 'sqlite3'

  # Goodies for prettier printing of records in the console
  gem 'awesome_print'
  gem 'hirb'

  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'quiet_assets'
end

# Use debugger
# gem 'debugger', group: [:development, :test]

group :test, :development do
  # RSpec for testing
  gem 'rspec-rails'

  # Use factory girl instead of fixtures
  gem 'factory_girl_rails'

  # Used for creating fake names, emails, etc.
  gem 'faker'

  # Use Spring for RSpec
  gem 'spring-commands-rspec'

  # Simplecov for code coverage statistics
  gem 'simplecov'

  # Do feature testing with capybara
  gem 'capybara'

  # Database dumping
  gem 'yaml_db', github: 'jetthoughts/yaml_db', ref: 'fb4b6bd7e12de3cffa93e0a298a1e5253d7e92ba'
end

group :production do
  # Use postgresql as the database for Active Record in production
  gem 'pg'

  gem 'puma'
end

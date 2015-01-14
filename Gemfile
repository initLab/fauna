source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.0'

# Use SCSS for stylesheets
gem 'sass-rails'
gem 'sprockets'

# Use mysql as the database for Active Record
gem 'mysql2'

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

group :development do
  # Use Capistrano for deployment
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'

  gem 'pry'
  gem 'pry-doc'

  # Continuous testing with Guard
  gem 'guard-rspec'

  # Deploy to a puma  server
  gem 'capistrano3-puma'

  # Use SQLite for development
  gem 'sqlite3'
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
end

group :production do
  gem 'puma'
end

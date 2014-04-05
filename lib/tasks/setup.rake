require 'fileutils'

namespace :initial_setup do
  desc 'Copy over initial db config'
  task :db_config do
    example_config = File.join(Rails.root, 'config', 'database.yml.example')
    new_config = File.join(Rails.root, 'config', 'database.yml')
    FileUtils.cp example_config, new_config
  end

  desc 'Generate a new secret token'
  task :secret_token do
    secret_token = File.join Rails.root, 'config', 'initializers', 'secret_token.rb'
    File.open(secret_token, 'w') do |f|
      f.puts "Fauna::Application.config.secret_key_base = '#{`rake secret`.chomp}'"
    end
  end
end

desc 'Perform initial setup of the application'
task initial_setup: ['initial_setup:secret_token',
                     'initial_setup:db_config',
                     'db:create',
                     'db:migrate',
                     'db:test:prepare']

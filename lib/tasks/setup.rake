require 'fileutils'
require 'yaml'
require 'securerandom'

namespace :initial_setup do
  desc 'Copy over initial db config'
  task :db_config do
    example_config_file = File.join(Rails.root, 'config', 'database.yml.example')
    new_config_file = File.join(Rails.root, 'config', 'database.yml')
    FileUtils.cp example_config_file, new_config_file
  end

  desc 'Generate new secret tokens'
  task :secret_tokens do
    secret_tokens_file = File.join Rails.root, 'config', 'secrets.yml'

    secrets = {
      'development' => {'secret_key_base' => SecureRandom.hex(64)},
      'test'        => {'secret_key_base' => SecureRandom.hex(64)},
      'production'  => {'secret_key_base' => '<%= ENV["SECRET_KEY_BASE"] %>'}
    }

    File.open(secret_tokens_file, 'w') do |f|
      f.puts secrets.to_yaml
    end
  end
end

desc 'Perform initial setup of the application'
task initial_setup: ['initial_setup:secret_tokens',
                     'initial_setup:db_config',
                     'db:create',
                     'db:migrate',
                     'db:test:prepare']

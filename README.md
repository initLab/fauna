initLab Identity System
=======================

A simple system for tracking who's in initLab.

Installation
------------

1. `git clone https://github.com/ignisf/init-lab-auth.git --recursive`
2. Create a database configuration `config/database.yml` (use
   `config/database.yml.example` as a reference).
3. Copy `config/initializers/secret_token.rb.example` to
   `config/initializers/secret_token.rb`
4. Generate a secret with `rake secret` and use it to set the value of
   `config.secret_key_base` in `config/initializers/secret_token.rb`
5. Run `bundle install; bundle exec rake db:create db:migrate`
6. You can now run the rails server with `rails s`
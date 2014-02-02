initLab Identity System
=======================

A simple system for tracking who's in initLab.

Installation
------------

1. `git clone https://github.com/ignisf/init-lab-auth.git --recursive`
2. Create a database configuration `config/database.yml` (use
   `config/database.yml.example` as a reference).
3. Copy `config/initializers/devise.rb.example` a
   `config/initializers/secret_token.rb.example` to `config/initializers/devise.rb`
   and `config/initializers/secret_token.rb`
4. Generate two secrets with `rake secret` and use them to set the values of
   `config.secret_key` in `config/initializers/devise.rb` and
   `config.secret_key_base` in `config/initializers/secret_token.rb`
5. Run `bundle install; bundle exec rake db:create db:migrate`
6. You can now run the rails server with `rails s`
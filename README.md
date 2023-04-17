init Lab Management Automation System
=====================================

A not so simple system for hackerspace management automation.

Installation
------------

1. `git clone https://github.com/initlab/fauna.git`
2. Run `bin/setup` and follow the instructions.
3. You can now run the rails server with `bin/rails s` and login.

Deploying a New Version
-----------------------

The deployment is done using `capistrano`.

Initial setup:

```
bundle config set --local path '.bundle'
bundle install

# add your public ssh key in fauna@spitfire.initlab.org:./.ssh/authorized_keys
```

If you need to add/change secrets/config, do so in `~fauna/fauna/shared/config/*.yml` .

Deploy using:

```
bundle exec cap fauna deploy
```

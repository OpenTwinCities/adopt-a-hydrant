The following are notes and instructions on how to deploy on Heroku.

## Install locally

These instructions are for Mac.

1. [Install RVM](https://rvm.io/rvm/install/).  This is needed because Mac comes with Ruby 1.8 and you'll need 1.9.
1. Setup a Postgres database (instructions?)
1. If you have credentials for your Postgres, update ```config/database.yml``` as needed.
1. ```bundle install```
1. ```bundle exec rake db:create```
1. ```bundle exec rake db:schema:load```
1. ```rails server```

Seed data

1. ```bundle exec rake db:seed```

## Deploying to Heroku

The following are notes and instructions on how to deploy on Heroku.

## Install locally

These instructions are for Mac.

1. [Install RVM](https://rvm.io/rvm/install/).  This is needed because Mac comes with Ruby 1.8 and you'll need 1.9.
1. Setup a Postgres database (instructions?)
1. If you have credentials for your Postgres, update ```config/database.yml``` as needed.
1. Install gems: ```bundle install```
1. Setup database: ```bundle exec rake db:create; bundle exec rake db:schema:load```
1. Seed the data: ```bundle exec rake db:seed```
1. Run the server: ```rails server```

## Deploying to Heroku

1. Create a heroku app (change app name as needed): ```heroku apps:create otc-adoptahydrant```
1. Set up a DB: ```heroku addons:add heroku-postgresql```
1. Push the code and deply the application: ```git push heroku master```
1. Set up the db: ```heroku run rake db:create; heroku run rake db:schema:load```
1. Seed the data: ```heroku run rake db:seed```
1. Go to application: http://otc-adoptahydrant.herokuapp.com

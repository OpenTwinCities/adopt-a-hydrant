# Adopt-a-Hydrant (Twin Cities) [![Build Status](https://secure.travis-ci.org/codeforamerica/adopt-a-hydrant.png?branch=master)][travis] [![Dependency Status](https://gemnasium.com/codeforamerica/adopt-a-hydrant.png?travis)][gemnasium]

Claim responsibility for shoveling out a fire hydrant after it snows.

For original documentation, see the this [Adopt-a-Hydrant Github page](https://github.com/codeforamerica/adopt-a-hydrant).

## Installation and Setup

### Install locally

These instructions are for Mac.

1. [Install RVM](https://rvm.io/rvm/install/).  This is needed because Mac comes with Ruby 1.8 and you'll need 1.9.
1. Setup a Postgres database (instructions?)
1. If you have credentials for your Postgres, update ```config/database.yml``` as needed.
1. Install gems: ```bundle install```
1. Setup database: ```bundle exec rake db:create; bundle exec rake db:schema:load```
1. Seed the data: ```bundle exec rake db:seed```
1. Run the server: ```rails server```

### Deploying to Heroku

1. Create a heroku app (change app name as needed): ```heroku apps:create otc-adoptahydrant```
1. Set up a DB: ```heroku addons:add heroku-postgresql```
1. Push the code and deply the application: ```git push heroku master```
1. Set up the db: ```heroku run rake db:create; heroku run rake db:schema:load```
1. Seed the data: ```heroku run rake db:seed```
1. Go to application: http://otc-adoptahydrant.herokuapp.com

### Rails Admin

The data seeding (see below) will create an admin user.  Make sure to log into the application with the default credentials:

    accounts@opentwincities.org
    CHANGE.ME

And ***CHANGE THE PASSWORD***.  Do note that this may not be the best way to make a new admin user, so suggestions are welcome.

The admin dashboard is located at `/admin` on your server.


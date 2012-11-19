require 'json'

# Add admin user.  Change password after creation.  This may
# not be the best way to do this.

class User < ActiveRecord::Base
  attr_accessible :email, :name, :organization, :password, :admin
end

user_found = User.find_by_email('accounts@opentwincities.org')
if user_found == nil
  User.create!(:email => 'accounts@opentwincities.org', :name => 'Open Twin Cities Admin', :organization => 'Open Twin Cities', :password => 'CHANGE.ME', :admin => true)
  puts 'Recreated default admin user.'
end


# Data

class Thing < ActiveRecord::Base
  attr_accessible :city_id, :lng, :lat, :name
end

# For working on Heroku, the dev db only allows for
# 10,000 rows so we want to limit this for now.
# Use 0 for no rowlimit
rowlimit = 0

# For the St Paul data, it comes as a shapefile, so we convert it to geojson
# as that will be easier to work with.  (also, convert to lat/lon 4326)
#
# Use this command: ogr2ogr -f GeoJSON -t_srs EPSG:4326 db/data/st-paul/st-paul.json db/data/st-paul/Hydrants.shp

spjson = File.read('db/data/st-paul/st-paul.json')
sphydrants = JSON.parse(spjson)
spcount = 0
spid = 10000000
spfound = {};

sphydrants['features'].each do |feature|
  # Check limit
  if rowlimit != 0 && spcount > rowlimit
    break
  end

  # Add a prefix for the saint paul data.  Some don't
  # have asset ids
  if feature['properties']['ASSET_ID'] != nil
    id = Integer('11' + feature['properties']['ASSET_ID'])
  else
    spid = spid + 1
    id = 1100000000 + spid
  end
  
  # For some reason there are duplicate asset id
  if spfound[id] == true
    spid = spid + 1
    id = 1100000000 + spid
  end
  spfound[id] = true
  
  # Save new row, check if exists first
  spexists = Thing.find_by_city_id(id)
  if spexists == nil
    Thing.create(
      :city_id => id, 
      :lng => feature['geometry']['coordinates'][0], 
      :lat=> feature['geometry']['coordinates'][1], 
      :name => ''
    )
    spcount = spcount + 1
  end
end

puts "Imported #{spcount} St Paul Hydrants"


# For the Minneapolis data, it comes as a shapefile, so we convert it to geojson
# as that will be easier to work with.  (also, convert to lat/lon 4326)
#
# Use this command: ogr2ogr -f GeoJSON -t_srs EPSG:4326 db/data/minneapolis/minneapolis.json db/data/minneapolis/Hydrant.shp
#
# The Minneapolis data also comes with an NDA so it cannot be
# uploaded to github.

mplsfile = 'db/data/minneapolis/minneapolis.json'
if !File.exist?(mplsfile)
  puts 'Minneapolis file not found.'
else
  mplsjson = File.read(mplsfile)
  mplshydrants = JSON.parse(mplsjson)
  mplscount = 0
  mplsid = 20000000
  mplsfound = {};
  
  mplshydrants['features'].each do |feature|
    # Check limit
    if rowlimit != 0 && mplscount > rowlimit
      break
    end
    
    # The GlobalID is the attribute that should be used
    # for the ID, but the database only wants to
    # to use integer identifiers.
  
    # Add a prefix for the saint paul data.  Some don't
    # have asset ids
    if feature['properties']['OBJECTID'] != nil
      id = 1200000000 + Integer(feature['properties']['OBJECTID'])
    else
      mplsid = mplsid + 1
      id = 1200000000 + mplsid
    end
    
    # If there are duplicated
    if mplsfound[id] == true
      mplsid = mplsid + 1
      id = 1200000000 + mplsid
    end
    mplsfound[id] = true
    
    # Save new row, check if exists first
    mplsexists = Thing.find_by_city_id(id)
    if mplsexists == nil
      Thing.create(
        :city_id => id, 
        :lng => feature['geometry']['coordinates'][0], 
        :lat=> feature['geometry']['coordinates'][1], 
        :name => ''
      )
      mplscount = mplscount + 1
    end
  end
  
  puts "Imported #{mplscount} Minneapolis Hydrants"
end
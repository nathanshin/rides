require 'geokit'
require_relative 'db'

module Rides
	class Geokit
		# db = Rides::Database.new
		# client = db.client
		
		def update_geocodes(drivers, riders)
			drivers.each do |row|
				unless row["geocode"]
					address = row["address"]
					name = row["name"]
					geocode = Geokit::Geocoders::GoogleGeocoder.geocode address
					serialized_geocode = YAML::dump(geocode)
					client.query("UPDATE drivers SET geocode = \"#{serialized_geocode}\" WHERE name = '#{name}';")
				end
			end

			riders.each do |row|
				unless row["geocode"]
					address = row["address"]
					name = row["name"]
					geocode = Geokit::Geocoders::GoogleGeocoder.geocode address
					serialized_geocode = YAML::dump(geocode)
					client.query("UPDATE riders SET geocode = \"#{serialized_geocode}\" WHERE name = '#{name}';")
				end
			end
		end
	end
end
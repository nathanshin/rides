module Rides
	class CLI::Arrange
		attr_reader :options

		def initialize(options)
			@options = options
		end

		def run
			require 'geokit'
			require_relative '../db'
			require_relative '../ui'

			db = Rides::Database.new
			ui = Rides::UI.new
		
			# Pulls drivers and riders data from the database
			client = db.client

			drivers = client.query('SELECT * FROM drivers;')
			riders = client.query('SELECT * FROM riders;')

			# Updates geocode if there isn't one already
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

			# Pulls updated drivers and riders data from the database
			drivers = client.query('SELECT * FROM drivers;')
			riders = client.query('SELECT * FROM riders;')

			# Creates a mutable array to manipulate driver and rider data
			drivers_list = []
			riders_list = []

			# Populates mutable lists with driver and rider data
			drivers.each do |driver|
				deserialized_geocode = YAML::load(driver["geocode"])
				drivers_list << { name: driver["name"], geocode: deserialized_geocode, spots: driver["spots"], ll: deserialized_geocode.ll, riders: [] }
			end

			riders.each do |rider|
				deserialized_geocode = YAML::load(rider["geocode"])
				riders_list << { name: rider["name"], geocode: deserialized_geocode, ll: deserialized_geocode.ll, distance: nil }
			end

			# Tries to make for better rider sorting. Maybe take this out in the future?
			drivers_list = drivers_list.sort_by { |driver| driver[:ll] }
			riders_list = riders_list.sort_by { |rider| rider[:ll] }

			# Assigns riders to drivers based on distance
			drivers_list.each do |driver|

				# Calculate distance from the driver to each rider
				riders_list.each do |rider|
					rider[:distance] = driver[:geocode].distance_to(rider[:geocode])
				end

				# Sorts the list of riders by distance from the driver
				riders_list = riders_list.sort_by { |rider| rider[:distance] }

				# Pulls driver[:spots] number of rider OUT of the list and assigns to driver[:riders]
				driver[:spots].times do
					if !riders_list.empty?
						driver[:riders] << riders_list.shift[:name] 
					else
						break
					end
				end
			end

			ui.display_arranged_rides(drivers_list, riders_list)
			
		end
	end
end
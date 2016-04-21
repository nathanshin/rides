module Rides
	class CLI::List 
		attr_reader :options

		def initialize(arg)
			@type = arg
		end

		def run
			require_relative '../db'
			require_relative '../ui'

			db = Rides::Database.new
			ui = Rides::UI.new

			client = db.client

			if @type == "drivers"
				drivers = client.query("SELECT * from drivers;")
				drivers.each do |driver|
					puts "#{driver["name"]}", "..."
				end
			elsif @type == "riders"
				riders = client.query("SELECT * from riders;")
				riders.each do |rider|
					puts "#{rider["name"]}", "..."
				end
			end
		end
	end
end
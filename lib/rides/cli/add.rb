require 'thor'

module Rides
	class CLI::Add < Thor
		include Thor::Actions

		attr_reader :options

		def initialize(arg)
			@name = arg
		end

		no_commands {
			def run
				require_relative '../db'
				require_relative '../ui'

				db = Rides::Database.new
				ui = Rides::UI.new

				client = db.client

				type = ask("Driver or rider?")
				address = ask("What is the address?")

				if type.downcase == "driver"
					spots = ask("How many car spots are available?")
					client.query("INSERT INTO drivers (name, address, spots) VALUES ('#{@name}', '#{address}', #{spots.to_i});")
				else
					client.query("INSERT INTO riders (name, address) VALUES ('#{@name}', '#{address}');")
				end

				ui.added_user(type, @name)
			end
		}
	end
end
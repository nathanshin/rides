require 'thor'

module Rides
	class CLI::Remove < Thor
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

				if type.downcase == "driver"
					client.query("DELETE FROM drivers WHERE name = '#{@name}';")
				elsif type.downcase == "rider"
					client.query("DELETE FROM riders WHERE name = '#{@name}';")
				end

				ui.removed_user(type, @name)
			end
		}
	end
end
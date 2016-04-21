require 'thor'

module Rides
	class CLI < Thor		
		desc "arrange [OPTIONS]", "Assigns riders to drivers based on location"
		option "exceptions", :type => :string, :banner => "Text file where the names of the exceptions are held"
		def arrange
			require_relative 'cli/arrange'
			Arrange.new(options).run
		end

		desc "add NAME", "Adds NAME to DRIVERS/RIDERS table"
		def add(name)
			require_relative 'cli/add'
			Add.new(name).run
		end

		desc "remove NAME", "Removes NAME from DRIVERS/RIDERS table"
		def remove(name)
			require_relative 'cli/remove'
			Remove.new(name).run
		end

		desc "list DRIVER/RIDER", "Lists all DRIVERS/RIDERS"
		def list(type)
			require_relative 'cli/list'
			List.new(type).run
		end
	end
end
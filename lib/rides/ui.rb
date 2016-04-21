module Rides
	class UI

		def display_arranged_rides(drivers_list, riders_list)
			drivers_list.each do |driver| 
				spacer
				puts "Driver: #{driver[:name]} \n Riders: #{driver[:riders].join(", ")}"
			end

			spacer

			if !riders_list.empty?
				puts "\nRiders that still do not have a driver:"
				riders_list.each do |rider|
					puts "#{rider[:name]}"
				end
			else
				puts "\nRides successfully arranged!"
			end
		end

		def added_user(type, name)
			spacer
			puts "Added #{type}: #{name}!\n"
		end

		def removed_user(type, name)
			spacer
			puts "Removed #{type}: #{name}!\n"
		end

		private
			def spacer
				puts puts "-------------------------------------------------------------------"
			end
	end
end
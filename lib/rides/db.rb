require 'mysql2'

module Rides
	class Database
		def client
			Mysql2::Client.new(:host => "localhost", 
												 :username => "nathanshin", 
												 :password => "password", 
												 :database => "rides_2016")
		end
	end
end

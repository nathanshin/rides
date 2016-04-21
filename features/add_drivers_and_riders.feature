Feature: New Riders or Drivers can be added
	As a rides coordinater
	I want to be able to add or remove riders and drivers
	So that the database can be accurate

	Scenario: Add driver
		When I run `rides add "Nathan Shin"`
		Then the output should contain "Added NAME!"
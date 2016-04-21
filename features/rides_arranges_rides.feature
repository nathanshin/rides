Feature: Drivers are assigned riders
	As a rides coordinater
	I want to be able to click a button to coordinate rides
	So that I can spend my time doing better things

	Scenario: Arranging rides
		When I run `rides arrange`
		Then the output should contain "Rides arranged!"
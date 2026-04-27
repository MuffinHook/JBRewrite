return function(vehicleConfig)
	return if vehicleConfig.Type == "Chassis" or vehicleConfig.Type == "DuneBuggy" then true else vehicleConfig.Type == "Motorcycle"
end

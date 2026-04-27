return function(vehicleConfig)
	return if vehicleConfig.Type == "Chassis" and vehicleConfig.Make ~= "Volt4x4" or vehicleConfig.Type == "DuneBuggy" then true else vehicleConfig.Type == "Motorcycle"
end

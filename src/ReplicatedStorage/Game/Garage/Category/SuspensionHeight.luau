return function(vehicleType)
	return if vehicleType.Type == "Chassis" or vehicleType.Type == "DuneBuggy" then true else vehicleType.Type == "Motorcycle"
end

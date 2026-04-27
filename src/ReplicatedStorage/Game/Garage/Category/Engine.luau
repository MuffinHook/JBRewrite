return function(vehicle)
	return if vehicle.Type == "Chassis" or vehicle.Type == "DuneBuggy" then true else vehicle.Type == "Motorcycle"
end

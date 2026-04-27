return function(vehicle)
	return if vehicle.Type == "Chassis" or (vehicle.Type == "DuneBuggy" or vehicle.Type == "Motorcycle") then true else vehicle.Make == "Tank"
end

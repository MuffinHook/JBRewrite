return function(item)
	return if item.Type == "Chassis" or item.Type == "DuneBuggy" then true else item.Type == "Motorcycle"
end

return function(p1) --[[ Line: 1 ]]
	return if p1.Type == "Chassis" or p1.Type == "DuneBuggy" then true else p1.Type == "Motorcycle"
end
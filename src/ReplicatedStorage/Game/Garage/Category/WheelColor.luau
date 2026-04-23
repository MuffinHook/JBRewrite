return function(p1) --[[ Line: 1 ]]
	return if p1.Type == "Chassis" or (p1.Type == "DuneBuggy" or p1.Type == "Motorcycle") then true else p1.Make == "Tank"
end
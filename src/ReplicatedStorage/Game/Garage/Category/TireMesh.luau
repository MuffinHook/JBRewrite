-- Reviewed by Claude
return function(p1)
	return if p1.Type == "Chassis" and p1.Make ~= "Volt4x4" or p1.Type == "DuneBuggy" then true else p1.Type == "Motorcycle"
end
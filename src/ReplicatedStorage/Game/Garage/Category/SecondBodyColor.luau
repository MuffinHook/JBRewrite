return function(vehicleConfig)
	local Model = vehicleConfig.Model
	if Model then
		local SecondBody = Model:FindFirstChild("SecondBody", true)
		if not SecondBody then
			SecondBody = if vehicleConfig.Make == "Tank" or (vehicleConfig.Make == "TheRattler" or (vehicleConfig.Make == "MCL36" or vehicleConfig.Make == "MCL36FREE")) then true else vehicleConfig.Make == "Sloop"
		end
		return SecondBody
	end
end
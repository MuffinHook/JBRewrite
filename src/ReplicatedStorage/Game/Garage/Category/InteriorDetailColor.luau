return function(vehicleData)
	local Model = vehicleData.Model
	if Model then
		return Model:FindFirstChild("SecondInterior", true) or vehicleData.Make == "Sloop"
	end
end

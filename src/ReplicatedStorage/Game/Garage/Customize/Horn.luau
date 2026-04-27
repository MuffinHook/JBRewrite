return function(horn, vehicleData)
	local Model = vehicleData.Model
	if horn then
		Model:SetAttribute("VehicleHornId", horn.SoundId)
		Model:SetAttribute("VehicleHornLoopable", horn.Loopable)
	end
end

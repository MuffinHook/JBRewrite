return function(vehicleModel)
	return if vehicleModel.Model:GetAttribute("VehicleHornId") == nil then false else not vehicleModel.Model:GetAttribute("VehicleHornCustom")
end

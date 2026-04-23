return function(p1) --[[ Line: 1 ]]
	return if p1.Model:GetAttribute("VehicleHornId") == nil then false else not p1.Model:GetAttribute("VehicleHornCustom")
end
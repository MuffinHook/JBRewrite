-- Reviewed by Claude
return function(p1)
	return if p1.Model:GetAttribute("VehicleHornId") == nil then false else not p1.Model:GetAttribute("VehicleHornCustom")
end
return function(p1, p2) --[[ Line: 1 ]]
	local Model = p2.Model
	if p1 then
		Model:SetAttribute("VehicleHornId", p1.SoundId)
		Model:SetAttribute("VehicleHornLoopable", p1.Loopable)
	end
end
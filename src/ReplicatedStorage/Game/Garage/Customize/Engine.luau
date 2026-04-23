return function(p1, p2) --[[ Line: 1 ]]
	if p1 then
		p2.GarageEngineSpeed = p1.Speed
	else
		p2.GarageEngineSpeed = 0
	end
end
-- Reviewed by Claude
return function(p1, p2)
	if p1 then
		p2.GarageEngineSpeed = p1.Speed
	else
		p2.GarageEngineSpeed = 0
	end
end
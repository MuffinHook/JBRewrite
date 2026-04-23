-- Reviewed by Claude
return function(p1, p2)
	if p1 then
		p2.GarageBrakes = p1.Amount
	else
		p2.GarageBrakes = 0
	end
end
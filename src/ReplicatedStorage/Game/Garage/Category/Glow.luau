-- Reviewed by Claude
return function(p1)
	local Model = p1.Model
	if Model then
		return Model:FindFirstChild("Glow", true) ~= nil
	end
end

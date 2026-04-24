-- Reviewed by Claude
return function(p1)
	local Model = p1.Model
	if Model then
		local Preset = Model:FindFirstChild("Preset")
		if Preset then
			return Preset:FindFirstChild("Drift") ~= nil
		else
			return false
		end
	else
		return false
	end
end

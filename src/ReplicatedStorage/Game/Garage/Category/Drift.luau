return function(garageItem)
	local Model = garageItem.Model
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

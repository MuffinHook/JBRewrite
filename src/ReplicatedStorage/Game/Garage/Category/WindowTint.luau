return function(config)
	local Model = config.Model
	if Model then
		local Model_2 = Model:FindFirstChild("Model")
		if Model_2 then
			local Windows = Model:FindFirstChild("Windows", true)
			return if config.Type == "Chassis" and not (Model_2:FindFirstChild("Interior") or Model_2:FindFirstChild("SecondInterior")) then false else Windows
		else
			return false
		end
	else
		return false
	end
end

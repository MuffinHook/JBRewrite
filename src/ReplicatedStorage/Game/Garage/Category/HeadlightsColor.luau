return function(carPartData)
	local Model = carPartData.Model
	if Model then
		local Model_2 = Model:FindFirstChild("Model")
		if Model_2 then
			return Model_2:FindFirstChild("Headlights")
		end
	end
end

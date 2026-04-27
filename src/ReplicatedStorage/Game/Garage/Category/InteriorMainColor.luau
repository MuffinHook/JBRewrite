return function(carConfig)
	local Model = carConfig.Model
	if Model then
		return Model:FindFirstChild("Interior", true) or carConfig.Make == "Sloop"
	end
end

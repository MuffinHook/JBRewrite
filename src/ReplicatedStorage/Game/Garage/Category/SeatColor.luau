return function(config)
	local Model = config.Model
	if Model then
		local seatModel = Model:FindFirstChild("Model")
		if seatModel then
			return seatModel:FindFirstChild("Seats")
		end
	end
end

-- Reviewed by Claude
return function(p1)
	local Model = p1.Model
	if Model then
		local Model_2 = Model:FindFirstChild("Model")
		if Model_2 then
			return Model_2:FindFirstChild("Seats")
		end
	end
end
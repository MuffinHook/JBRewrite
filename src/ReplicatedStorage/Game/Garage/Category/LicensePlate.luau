-- Reviewed by Claude
-- variables reassigned
return function(p1)
	local Model = p1.Model
	if Model then
		local modelChild = Model:FindFirstChild("Model")
		if modelChild then
			return modelChild:FindFirstChild("plate")
		end
	end
end

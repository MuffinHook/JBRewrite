-- Reviewed by Claude
return function(p1)
	local Model = p1.Model
	if Model then
		return Model:FindFirstChild("Body", true) or p1.Make == "Sloop"
	end
end

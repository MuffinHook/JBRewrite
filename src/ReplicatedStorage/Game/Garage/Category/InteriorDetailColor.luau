return function(p1) --[[ Line: 1 ]]
	local Model = p1.Model
	if Model then
		return Model:FindFirstChild("SecondInterior", true) or p1.Make == "Sloop"
	end
end
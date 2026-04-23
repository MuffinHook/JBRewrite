return function(p1) --[[ Line: 1 ]]
	local Model = p1.Model
	if Model then
		local SecondBody = Model:FindFirstChild("SecondBody", true)
		if not SecondBody then
			SecondBody = if p1.Make == "Tank" or (p1.Make == "TheRattler" or (p1.Make == "MCL36" or p1.Make == "MCL36FREE")) then true else p1.Make == "Sloop"
		end
		return SecondBody
	end
end
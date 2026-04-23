return function(p1, p2) --[[ Line: 1 ]]
	if p1 then
		p2.Model:SetAttribute("GarageSuspensionHeight", p1.Height)
	else
		p2.Model:SetAttribute("GarageSuspensionHeight", 0)
	end
end
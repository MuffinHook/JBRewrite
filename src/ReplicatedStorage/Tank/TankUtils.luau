local Players = game:GetService("Players")
local t = {}
function t.getGunner(p1) --[[ Line: 3 | Upvalues: Players (copy), t (copy) ]]
	local t2 = {}
	for v1, v2 in p1:GetChildren() do
		if v2.Name == "Seat" or v2.Name == "Passenger" then
			local ControlGunPriority = v2:FindFirstChild("ControlGunPriority")
			if ControlGunPriority and ControlGunPriority:IsA("IntValue") then
				local v3 = ControlGunPriority.Value
				local PlayerName = v2:FindFirstChild("PlayerName")
				if PlayerName then
					local v4 = Players:FindFirstChild(PlayerName.Value)
					if v4 then
						table.insert(t2, {
							player = v4,
							priority = v3
						})
					end
				end
			end
		end
	end
	table.sort(t2, function(p1, p2) --[[ Line: 27 ]]
		return p1.priority > p2.priority
	end)
	if #t2 > 0 then
		return t2[1].player
	else
		return t.getDriver(p1)
	end
end
function t.getDriver(p1) --[[ Line: 36 | Upvalues: Players (copy) ]]
	for v1, v2 in p1:GetChildren() do
		if v2.Name == "Seat" then
			local PlayerName = v2:FindFirstChild("PlayerName")
			if PlayerName then
				local v3 = Players:FindFirstChild(PlayerName.Value)
				if v3 then
					return v3
				end
			end
		end
	end
	return nil
end
return t
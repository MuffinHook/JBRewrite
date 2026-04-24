-- Reviewed by Claude
local Players = game:GetService("Players")
local t = {}
function t.getGunner(p1)
	local t2 = {}
	for v1, v2 in p1:GetChildren() do
		if v2.Name == "Seat" or v2.Name == "Passenger" then
			local ControlGunPriority = v2:FindFirstChild("ControlGunPriority")
			if ControlGunPriority and ControlGunPriority:IsA("IntValue") then
				local var3 = ControlGunPriority.Value
				local PlayerName = v2:FindFirstChild("PlayerName")
				if PlayerName then
					local localPlayer = Players:FindFirstChild(PlayerName.Value)
					if localPlayer then
						table.insert(t2, {
							player = localPlayer,
							priority = var3
						})
					end
				end
			end
		end
	end
	table.sort(t2, function(p1, p2)
		return p1.priority > p2.priority
	end)
	if #t2 > 0 then
		return t2[1].player
	else
		return t.getDriver(p1)
	end
end
function t.getDriver(p1)
	for v1, v2 in p1:GetChildren() do
		if v2.Name == "Seat" then
			local PlayerName = v2:FindFirstChild("PlayerName")
			if PlayerName then
				local var3 = Players:FindFirstChild(PlayerName.Value)
				if var3 then
					return var3
				end
			end
		end
	end
	return nil
end
return t

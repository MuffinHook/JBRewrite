local Players = game:GetService("Players")
local TankUtils = {}
function TankUtils.getGunner(tank)
	local gunnerCandidates = {}
	for index, seat in tank:GetChildren() do
		if seat.Name == "Seat" or seat.Name == "Passenger" then
			local ControlGunPriority = seat:FindFirstChild("ControlGunPriority")
			if ControlGunPriority and ControlGunPriority:IsA("IntValue") then
				local priority = ControlGunPriority.Value
				local PlayerName = seat:FindFirstChild("PlayerName")
				if PlayerName then
					local foundPlayer = Players:FindFirstChild(PlayerName.Value)
					if foundPlayer then
						table.insert(gunnerCandidates, {
							player = foundPlayer,
							priority = priority
						})
					end
				end
			end
		end
	end
	table.sort(gunnerCandidates, function(candidateA, candidateB)
		return candidateA.priority > candidateB.priority
	end)
	if #gunnerCandidates > 0 then
		return gunnerCandidates[1].player
	else
		return TankUtils.getDriver(tank)
	end
end
function TankUtils.getDriver(tank)
	for index, seat in tank:GetChildren() do
		if seat.Name == "Seat" then
			local PlayerName = seat:FindFirstChild("PlayerName")
			if PlayerName then
				local driverPlayer = Players:FindFirstChild(PlayerName.Value)
				if driverPlayer then
					return driverPlayer
				end
			end
		end
	end
	return nil
end
return TankUtils

-- Reviewed by Claude
-- variables reassigned
game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Telemetry = require(script.Parent.Telemetry)
local configTable = {}
configTable.__index = configTable
local PromptCashBooster = ReplicatedStorage:WaitForChild("AdRewardSystem"):WaitForChild("AdRewardEvents"):WaitForChild("PromptCashBooster")
local function firePromptSignal(p1)
	if PromptCashBooster then
		PromptCashBooster:Fire(p1)
	end
end
function configTable.new(p1, p2)
	local v2 = setmetatable({}, configTable)
	v2.Player = p1
	v2.RegionFolder = p2
	v2.Regions = {}
	v2._running = false
	v2._loopThread = nil
	v2:_initRegions()
	v2:_connectFolderChanges()
	return v2
end
function configTable._initRegions(p1)
	for i, v in ipairs(p1.RegionFolder:GetChildren()) do
		if v:IsA("BasePart") then
			p1:_addRegion(v)
		end
	end
end
function configTable._connectFolderChanges(p1)
	p1.RegionFolder.ChildAdded:Connect(function(p12)
		if p12:IsA("BasePart") then
			p1:_addRegion(p12)
		end
	end)
	p1.RegionFolder.ChildRemoved:Connect(function(p12)
		if p12:IsA("BasePart") then
			p1.Regions[p12] = nil
		end
	end)
end
function configTable._addRegion(p1, p2)
	p1.Regions[p2] = {
		Part = p2,
		Team = p2:GetAttribute("Team"),
		IsValid = true,
		IsPlayerInside = false,
		NextRecheckTime = 0
	}
end
function configTable._getCharacter(p1)
	local Character = p1.Player.Character
	if Character and Character.Parent then
		local Humanoid = Character:FindFirstChildOfClass("Humanoid")
		local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
		if Humanoid and HumanoidRootPart then
			return Character, Humanoid, HumanoidRootPart
		else
			return nil, nil, nil
		end
	else
		return nil, nil, nil
	end
end
function configTable._forceLeaveAllRegions(p1)
	for k, v in pairs(p1.Regions) do
		if v.IsPlayerInside then
			v.IsPlayerInside = false
			local v1 = k:GetAttribute("RegionTag")
			if v1 then
				Telemetry.send("ExitRegion_" .. v1)
			end
			if PromptCashBooster then
				PromptCashBooster:Fire(nil)
			end
		end
	end
end
function configTable._step(p1)
	local v1, v2, v3 = p1:_getCharacter()
	if v1 and (v2 and not (v2.Health <= 0 or v2.Health < 100)) then
		local v4 = os.time()
		local Position = v3.Position
		local Team = p1.Player.Team
		for k, v in pairs(p1.Regions) do
			local v5
			if k and k.Parent then
				if not (v4 < (v.NextRecheckTime or 0)) then
					if (k.Position - Position).Magnitude > 1000 then
						v.IsValid = false
						if v.IsPlayerInside then
							v.IsPlayerInside = false
							local v6 = k:GetAttribute("RegionTag")
							if v6 then
								Telemetry.send("ExitRegion_" .. v6)
							end
						else

						end
					else
						v.IsValid = true
						local v7 = k.Size * 0.5
						local cframe = k.CFrame:PointToObjectSpace(Position)
						v5 = if math.abs(cframe.X) <= v7.X then if math.abs(cframe.Y) <= v7.Y then math.abs(cframe.Z) <= v7.Z else false else false
						if v5 then
							if not v.IsPlayerInside then
								local Team_2 = v.Team
								local isEnabled = false
								if Team ~= nil then
									local _ = Team.Name or tostring(Team)
								end
								if typeof(Team_2) == "Instance" and Team_2:IsA("Team") then
									local _ = Team_2.Name
									if Team and Team == Team_2 then
										isEnabled = true
									end
								elseif typeof(Team_2) == "string" then
									if Team and Team.Name == Team_2 then
										isEnabled = true
									end
								elseif Team_2 ~= nil then
									tostring(Team_2)
								end
								if isEnabled then
									v.IsPlayerInside = true
									local v10 = k:GetAttribute("RegionTag")
									if v10 then
										Telemetry.send("EnterRegion_" .. v10)
									end
								else
									v.IsValid = false
									v.NextRecheckTime = v4 + 10
								end
							end
						elseif v.IsPlayerInside then
							v.IsPlayerInside = false
							local v11 = k:GetAttribute("RegionTag")
							if v11 then
								Telemetry.send("ExitRegion_" .. v11)
							end
						else

						end
					end
					if PromptCashBooster then
						PromptCashBooster:Fire(nil)
					end
				end
			else
				p1.Regions[k] = nil
			end
		end
	else
		p1:_forceLeaveAllRegions()
	end
end
function configTable.Start(p1)
	if not p1._running then
		p1._running = true
		p1._loopThread = task.spawn(function()
			while p1._running do
				p1:_step()
				task.wait(2)
			end
		end)
	end
end
function configTable.Stop(p1)
	p1._running = false
	p1._loopThread = nil
end
function configTable.IsInAnyTeamMatchedRegion(p1)
	for k, v in pairs(p1.Regions) do
		if v.IsPlayerInside then
			return true
		end
	end
	return false
end
function configTable.GetCurrentRegionTag(p1)
	for k, v in pairs(p1.Regions) do
		if v.IsPlayerInside then
			local v1 = k:GetAttribute("RegionTag")
			if v1 then
				return v1
			end
		end
	end
	return nil
end
return configTable

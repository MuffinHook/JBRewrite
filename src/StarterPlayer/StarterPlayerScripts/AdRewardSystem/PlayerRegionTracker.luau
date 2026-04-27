game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Telemetry = require(script.Parent.Telemetry)
local configTable = {}
configTable.__index = configTable
local PromptCashBooster = ReplicatedStorage:WaitForChild("AdRewardSystem"):WaitForChild("AdRewardEvents"):WaitForChild("PromptCashBooster")
local function firePromptSignal(promptSignal)
	if PromptCashBooster then
		PromptCashBooster:Fire(promptSignal)
	end
end
function configTable.new(player, regionFolder)
	local newTracker = setmetatable({}, configTable)
	newTracker.Player = player
	newTracker.RegionFolder = regionFolder
	newTracker.Regions = {}
	newTracker._running = false
	newTracker._loopThread = nil
	newTracker:_initRegions()
	newTracker:_connectFolderChanges()
	return newTracker
end
function configTable._initRegions(self)
	for i, v in ipairs(self.RegionFolder:GetChildren()) do
		if v:IsA("BasePart") then
			self:_addRegion(v)
		end
	end
end
function configTable._connectFolderChanges(self)
	self.RegionFolder.ChildAdded:Connect(function(newPart)
		if newPart:IsA("BasePart") then
			self:_addRegion(newPart)
		end
	end)
	self.RegionFolder.ChildRemoved:Connect(function(removedPart)
		if removedPart:IsA("BasePart") then
			self.Regions[removedPart] = nil
		end
	end)
end
function configTable._addRegion(self, regionPart)
	self.Regions[regionPart] = {
		Part = regionPart,
		Team = regionPart:GetAttribute("Team"),
		IsValid = true,
		IsPlayerInside = false,
		NextRecheckTime = 0
	}
end
function configTable._getCharacter(self)
	local Character = self.Player.Character
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
function configTable._forceLeaveAllRegions(self)
	for k, v in pairs(self.Regions) do
		if v.IsPlayerInside then
			v.IsPlayerInside = false
			local regionTag = k:GetAttribute("RegionTag")
			if regionTag then
				Telemetry.send("ExitRegion_" .. regionTag)
			end
			if PromptCashBooster then
				PromptCashBooster:Fire(nil)
			end
		end
	end
end
function configTable._step(self)
	local character, humanoid, humanoidRootPart = self:_getCharacter()
	if character and (humanoid and not (humanoid.Health <= 0 or humanoid.Health < 100)) then
		local currentTime = os.time()
		local playerPosition = humanoidRootPart.Position
		local playerTeam = self.Player.Team
		for k, v in pairs(self.Regions) do
			local isPlayerInsideRegion
			if k and k.Parent then
				if not (currentTime < (v.NextRecheckTime or 0)) then
					if (k.Position - playerPosition).Magnitude > 1000 then
						v.IsValid = false
						if v.IsPlayerInside then
							v.IsPlayerInside = false
							local exitRegionTag = k:GetAttribute("RegionTag")
							if exitRegionTag then
								Telemetry.send("ExitRegion_" .. exitRegionTag)
							end
						else

						end
					else
						v.IsValid = true
						local regionHalfSize = k.Size * 0.5
						local localPosition = k.CFrame:PointToObjectSpace(playerPosition)
						isPlayerInsideRegion = if math.abs(localPosition.X) <= regionHalfSize.X then if math.abs(localPosition.Y) <= regionHalfSize.Y then math.abs(localPosition.Z) <= regionHalfSize.Z else false else false
						if isPlayerInsideRegion then
							if not v.IsPlayerInside then
								local regionTeam = v.Team
								local isTeamMatched = false
								if playerTeam ~= nil then
									local _ = playerTeam.Name or tostring(playerTeam)
								end
								if typeof(regionTeam) == "Instance" and regionTeam:IsA("Team") then
									local _ = regionTeam.Name
									if playerTeam and playerTeam == regionTeam then
										isTeamMatched = true
									end
								elseif typeof(regionTeam) == "string" then
									if playerTeam and playerTeam.Name == regionTeam then
										isTeamMatched = true
									end
								elseif regionTeam ~= nil then
									tostring(regionTeam)
								end
								if isTeamMatched then
									v.IsPlayerInside = true
									local enterRegionTag = k:GetAttribute("RegionTag")
									if enterRegionTag then
										Telemetry.send("EnterRegion_" .. enterRegionTag)
									end
								else
									v.IsValid = false
									v.NextRecheckTime = currentTime + 10
								end
							end
						elseif v.IsPlayerInside then
							v.IsPlayerInside = false
							local exitRegionTag = k:GetAttribute("RegionTag")
							if exitRegionTag then
								Telemetry.send("ExitRegion_" .. exitRegionTag)
							end
						else

						end
					end
					if PromptCashBooster then
						PromptCashBooster:Fire(nil)
					end
				end
			else
				self.Regions[k] = nil
			end
		end
	else
		self:_forceLeaveAllRegions()
	end
end
function configTable.Start(self)
	if not self._running then
		self._running = true
		self._loopThread = task.spawn(function()
			while self._running do
				self:_step()
				task.wait(2)
			end
		end)
	end
end
function configTable.Stop(self)
	self._running = false
	self._loopThread = nil
end
function configTable.IsInAnyTeamMatchedRegion(self)
	for k, v in pairs(self.Regions) do
		if v.IsPlayerInside then
			return true
		end
	end
	return false
end
function configTable.GetCurrentRegionTag(self)
	for k, v in pairs(self.Regions) do
		if v.IsPlayerInside then
			local regionTag = k:GetAttribute("RegionTag")
			if regionTag then
				return regionTag
			end
		end
	end
	return nil
end
return configTable

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Signal = require(ReplicatedStorage.Std.Signal)
require(ReplicatedStorage.Module.Math)
local module = if RunService:IsServer() then require(game:GetService("ServerStorage").Game.ServerPlayerUtils) else nil
local _ = Vector3.new
local cframe2 = CFrame.new
local Angles = CFrame.Angles
local pointToObjectSpace = cframe2().pointToObjectSpace
local insert = table.insert
local remove = table.remove
local function MakePrism()
	return {
		cframe = nil,
		size = nil
	}
end
local function MakePrismA(cframe, size)
	return {
		cframe = cframe,
		size = size
	}
end
local function MakeRegion()
	return {
		Prisms = {},
		Names = {},
		NamesFastIndex = {},
		NameAdded = nil,
		NameRemoving = nil,
		NameAddedSignal = Signal.new(),
		NameRemovedSignal = Signal.new(),
		IsInRegion = nil
	}
end
local function CastPoint(prism, position)
	local size = prism.size
	local relativePosition = pointToObjectSpace(prism.cframe, position) + size * 0.5
	return if relativePosition.x >= 0 and (relativePosition.x < size.x and (relativePosition.y >= 0 and (relativePosition.y < size.y and relativePosition.z >= 0))) then relativePosition.z < size.z else false
end
local function RegionCastPoint(region, position)
	local Prisms = region.Prisms
	for i = 1, #Prisms do
		if CastPoint(Prisms[i], position) then
			return true
		end
	end
	return false
end
local Players = game:GetService("Players")
local function IsInRegionPlayerName(region, playerName)
	local localPlayer = Players:FindFirstChild(playerName)
	if localPlayer then
		local Character = localPlayer.Character
		if Character then
			local PrimaryPart = Character.PrimaryPart
			if PrimaryPart then
				local Humanoid = Character:FindFirstChild("Humanoid")
				if Humanoid then
					local playerPosition = module and module.getLastPosition(localPlayer) or PrimaryPart.Position
					if Humanoid.Health > 0 then
						local Prisms = region.Prisms
						for i = 1, #Prisms do
							if CastPoint(Prisms[i], playerPosition) then
								return true
							end
						end
					end
					return false
				else
					return false
				end
			else
				return false
			end
		else
			return false
		end
	end
end
return {
	MakePrism = MakePrism,
	MakePrismA = MakePrismA,
	MakeRegion = MakeRegion,
	Update = function(region, playerNames)
		local IsInRegion = region.IsInRegion
		local NamesFastIndex = region.NamesFastIndex
		local Names = region.Names
		local processedNames = {}
		for i = 1, #playerNames do
			local playerName = playerNames[i]
			local isInRegion = IsInRegion(region, playerName)
			local isNameInRegion = NamesFastIndex[playerName]
			if isInRegion and not isNameInRegion then
				table.insert(Names, playerName)
				NamesFastIndex[playerName] = true
				if region.NameAdded then
					local success, errorMessage = pcall(function()
						region.NameAdded(region, playerName)
					end)
					if not success then
						warn("REGIONADDED", errorMessage)
					end
				elseif region.NameAddedSignal then
					region.NameAddedSignal:Fire(region, playerName)
				end
			elseif not isInRegion and isNameInRegion then
				if region.NameRemoving then
					local success, errorMessage = pcall(function()
						region.NameRemoving(region, playerName)
					end)
					if not success then
						warn("REGIONREMOVING", errorMessage)
					end
				end
				NamesFastIndex[playerName] = nil
				for j = 1, #region.Names do
					if region.Names[j] == playerName then
						table.remove(region.Names, j)
						break
					end
				end
				if region.NameRemovedSignal then
					region.NameRemovedSignal:Fire(region, playerName)
				end
			end
			processedNames[playerName] = true
		end
		for k = #region.Names, 1, -1 do
			local name = region.Names[k]
			if not (processedNames[name] or IsInRegion(region, name)) then
				if region.NameRemoving then
					local success, errorMessage = pcall(function()
						region.NameRemoving(region, name)
					end)
					if not success then
						warn("REGIONREMOVING", errorMessage)
					end
				end
				NamesFastIndex[name] = nil
				table.remove(region.Names, k)
			end
		end
	end,
	RegionCastPoint = RegionCastPoint,
	CastPoint = CastPoint,
	IsInRegionPlayerName = IsInRegionPlayerName
}

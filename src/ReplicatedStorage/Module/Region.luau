-- Reviewed by Claude
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
		c = nil,
		s = nil
	}
end
local function MakePrismA(p1, p2)
	return {
		c = nil,
		s = nil,
		c = p1,
		s = p2
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
local function CastPoint(p1, p2)
	local s = p1.s
	local module = pointToObjectSpace(p1.c, p2) + s * 0.5
	return if module.x >= 0 and (module.x < s.x and (module.y >= 0 and (module.y < s.y and module.z >= 0))) then module.z < s.z else false
end
local function RegionCastPoint(p1, p2)
	local Prisms = p1.Prisms
	for i = 1, #Prisms do
		if CastPoint(Prisms[i], p2) then
			return true
		end
	end
	return false
end
local Players = game:GetService("Players")
local function IsInRegionPlayerName(p1, p2)
	local localPlayer = Players:FindFirstChild(p2)
	if localPlayer then
		local Character = localPlayer.Character
		if Character then
			local PrimaryPart = Character.PrimaryPart
			if PrimaryPart then
				local Humanoid = Character:FindFirstChild("Humanoid")
				if Humanoid then
					local cframe2 = module and module.getLastPosition(localPlayer) or PrimaryPart.Position
					if Humanoid.Health > 0 then
						local Prisms = p1.Prisms
						for i = 1, #Prisms do
							if CastPoint(Prisms[i], cframe2) then
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
	Update = function(p1, p2)
		local IsInRegion = p1.IsInRegion
		local NamesFastIndex = p1.NamesFastIndex
		local Names = p1.Names
		local t = {}
		for i = 1, #p2 do
			local module = p2[i]
			local cframe2 = IsInRegion(p1, module)
			local var3 = NamesFastIndex[module]
			if cframe2 and not var3 then
				table.insert(Names, module)
				NamesFastIndex[module] = true
				if p1.NameAdded then
					local v4, v5 = pcall(function()
						p1.NameAdded(p1, module)
					end)
					if not v4 then
						warn("REGIONADDED", v5)
					end
				elseif p1.NameAddedSignal then
					p1.NameAddedSignal:Fire(p1, module)
				end
			elseif not cframe2 and var3 then
				if p1.NameRemoving then
					local v6, v7 = pcall(function()
						p1.NameRemoving(p1, module)
					end)
					if not v6 then
						warn("REGIONREMOVING", v7)
					end
				end
				NamesFastIndex[module] = nil
				for j = 1, #p1.Names do
					if p1.Names[j] == module then
						table.remove(p1.Names, j)
						break
					end
				end
				if p1.NameRemovedSignal then
					p1.NameRemovedSignal:Fire(p1, module)
				end
			end
			t[module] = true
		end
		for k = #p1.Names, 1, -1 do
			local var8 = p1.Names[k]
			if not (t[var8] or IsInRegion(p1, var8)) then
				if p1.NameRemoving then
					local v9, v10 = pcall(function()
						p1.NameRemoving(p1, var8)
					end)
					if not v9 then
						warn("REGIONREMOVING", v10)
					end
				end
				NamesFastIndex[var8] = nil
				table.remove(p1.Names, k)
			end
		end
	end,
	RegionCastPoint = RegionCastPoint,
	CastPoint = CastPoint,
	IsInRegionPlayerName = IsInRegionPlayerName
}

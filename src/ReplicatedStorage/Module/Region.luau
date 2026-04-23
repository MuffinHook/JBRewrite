local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Signal = require(ReplicatedStorage.Std.Signal)
require(ReplicatedStorage.Module.Math)
local v1 = if RunService:IsServer() then require(game:GetService("ServerStorage").Game.ServerPlayerUtils) else nil
local _ = Vector3.new
local v2 = CFrame.new
local Angles = CFrame.Angles
local pointToObjectSpace = v2().pointToObjectSpace
local insert = table.insert
local remove = table.remove
local function MakePrism() --[[ Line: 21 ]]
	return {
		c = nil,
		s = nil
	}
end
local function MakePrismA(p1, p2) --[[ Line: 27 ]]
	return {
		c = nil,
		s = nil,
		c = p1,
		s = p2
	}
end
local function MakeRegion() --[[ Line: 34 | Upvalues: Signal (copy) ]]
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
local function CastPoint(p1, p2) --[[ Line: 47 | Upvalues: pointToObjectSpace (copy) ]]
	local s = p1.s
	local v1 = pointToObjectSpace(p1.c, p2) + s * 0.5
	return if v1.x >= 0 and (v1.x < s.x and (v1.y >= 0 and (v1.y < s.y and v1.z >= 0))) then v1.z < s.z else false
end
local function RegionCastPoint(p1, p2) --[[ Line: 52 | Upvalues: CastPoint (copy) ]]
	local Prisms = p1.Prisms
	for i = 1, #Prisms do
		if CastPoint(Prisms[i], p2) then
			return true
		end
	end
	return false
end
local Players = game:GetService("Players")
local function IsInRegionPlayerName(p1, p2) --[[ Line: 63 | Upvalues: Players (copy), v1 (ref), CastPoint (copy) ]]
	local v12 = Players:FindFirstChild(p2)
	if v12 then
		local Character = v12.Character
		if Character then
			local PrimaryPart = Character.PrimaryPart
			if PrimaryPart then
				local Humanoid = Character:FindFirstChild("Humanoid")
				if Humanoid then
					local v2 = v1 and v1.getLastPosition(v12) or PrimaryPart.Position
					if Humanoid.Health > 0 then
						local Prisms = p1.Prisms
						for i = 1, #Prisms do
							if CastPoint(Prisms[i], v2) then
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
	Update = function(p1, p2) --[[ Name: Update | Line: 84 ]]
		local IsInRegion = p1.IsInRegion
		local NamesFastIndex = p1.NamesFastIndex
		local Names = p1.Names
		local t = {}
		for i = 1, #p2 do
			local v1 = p2[i]
			local v2 = IsInRegion(p1, v1)
			local v3 = NamesFastIndex[v1]
			if v2 and not v3 then
				table.insert(Names, v1)
				NamesFastIndex[v1] = true
				if p1.NameAdded then
					local v4, v5 = pcall(function() --[[ Line: 97 | Upvalues: p1 (copy), v1 (copy) ]]
						p1.NameAdded(p1, v1)
					end)
					if not v4 then
						warn("REGIONADDED", v5)
					end
				elseif p1.NameAddedSignal then
					p1.NameAddedSignal:Fire(p1, v1)
				end
			elseif not v2 and v3 then
				if p1.NameRemoving then
					local v6, v7 = pcall(function() --[[ Line: 109 | Upvalues: p1 (copy), v1 (copy) ]]
						p1.NameRemoving(p1, v1)
					end)
					if not v6 then
						warn("REGIONREMOVING", v7)
					end
				end
				NamesFastIndex[v1] = nil
				for j = 1, #p1.Names do
					if p1.Names[j] == v1 then
						table.remove(p1.Names, j)
						break
					end
				end
				if p1.NameRemovedSignal then
					p1.NameRemovedSignal:Fire(p1, v1)
				end
			end
			t[v1] = true
		end
		for k = #p1.Names, 1, -1 do
			local v8 = p1.Names[k]
			if not (t[v8] or IsInRegion(p1, v8)) then
				if p1.NameRemoving then
					local v9, v10 = pcall(function() --[[ Line: 140 | Upvalues: p1 (copy), v8 (copy) ]]
						p1.NameRemoving(p1, v8)
					end)
					if not v9 then
						warn("REGIONREMOVING", v10)
					end
				end
				NamesFastIndex[v8] = nil
				table.remove(p1.Names, k)
			end
		end
	end,
	RegionCastPoint = RegionCastPoint,
	CastPoint = CastPoint,
	IsInRegionPlayerName = IsInRegionPlayerName
}
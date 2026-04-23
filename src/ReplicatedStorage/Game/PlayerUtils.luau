game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CharacterUtils = require(ReplicatedStorage.Std.CharacterUtils)
require(ReplicatedStorage.Std.Region.RegionUtils)
local GameUtil = require(ReplicatedStorage.Game.GameUtil)
local Settings = require(ReplicatedStorage.Resource.Settings)
local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local LocalPlayer = Players.LocalPlayer
local v1 = nil
local PlayerConsts = require(script.Parent.PlayerConsts)
local t = {
	init = function() --[[ Name: init | Line: 16 | Upvalues: v1 (ref), ReplicatedStorage (copy) ]]
		v1 = require(ReplicatedStorage.Inventory.InventoryItemSystem)
	end,
	getLastVehicleSpawnedAt = function() --[[ Name: getLastVehicleSpawnedAt | Line: 19 | Upvalues: LocalPlayer (copy), PlayerConsts (copy) ]]
		local v1 = LocalPlayer:FindFirstChild(PlayerConsts.LAST_VEHICLE_SPAWNED_AT_VALUE_NAME)
		assert(v1)
		return v1.Value
	end,
	getHumanoid = function(p1) --[[ Name: getHumanoid | Line: 24 ]]
		local Character = p1.Character
		if Character then
			return Character:FindFirstChild("Humanoid")
		end
	end,
	getRootPart = function(p1) --[[ Name: getRootPart | Line: 31 ]]
		local Character = p1.Character
		if Character then
			return Character.PrimaryPart
		end
	end,
	getTeam = function(p1) --[[ Name: getTeam | Line: 39 ]]
		local TeamValue = p1:FindFirstChild("TeamValue")
		return TeamValue and TeamValue.Value
	end,
	getTeamId = function(p1) --[[ Name: getTeamId | Line: 43 | Upvalues: Teams (copy), Settings (copy) ]]
		if p1.Team == Teams:FindFirstChild("Prisoner") then
			return Settings.EnumTeam.Prisoner
		elseif p1.Team == Teams:FindFirstChild("Criminal") then
			return Settings.EnumTeam.Criminal
		elseif p1.Team == Teams:FindFirstChild("Police") then
			return Settings.EnumTeam.Police
		else
			return nil
		end
	end,
	hasKey = function() --[[ Name: hasKey | Line: 53 | Upvalues: GameUtil (copy), Settings (copy), v1 (ref), LocalPlayer (copy) ]]
		if GameUtil.Team == Settings.EnumTeam.Police then
			return true
		else
			return v1.playerHasItem(LocalPlayer, "Key")
		end
	end,
	getPlayerFromDescendant = function(p1) --[[ Name: getPlayerFromDescendant | Line: 59 | Upvalues: Players (copy) ]]
		if p1 then
			for i, v in ipairs(Players:GetPlayers()) do
				if v.Character and p1:IsDescendantOf(v.Character) then
					return v
				end
			end
		end
	end
}
function t.isInVehicle(p1) --[[ Line: 71 | Upvalues: CharacterUtils (copy), t (copy) ]]
	return t.isHumanoidInVehicle((CharacterUtils.getHumanoid(p1.Character)))
end
function t.isHumanoidInVehicle(p1) --[[ Line: 75 ]]
	if p1 then
		return p1.Parent:GetAttribute("InVehicle") == true
	else
		return false
	end
end
return t
-- Reviewed by Claude
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
	init = function()
		v1 = require(ReplicatedStorage.Inventory.InventoryItemSystem)
	end,
	getLastVehicleSpawnedAt = function()
		local v1 = LocalPlayer:FindFirstChild(PlayerConsts.LAST_VEHICLE_SPAWNED_AT_VALUE_NAME)
		assert(v1)
		return v1.Value
	end,
	getHumanoid = function(p1)
		local Character = p1.Character
		if Character then
			return Character:FindFirstChild("Humanoid")
		end
	end,
	getRootPart = function(p1)
		local Character = p1.Character
		if Character then
			return Character.PrimaryPart
		end
	end,
	getTeam = function(p1)
		local TeamValue = p1:FindFirstChild("TeamValue")
		return TeamValue and TeamValue.Value
	end,
	getTeamId = function(p1)
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
	hasKey = function()
		if GameUtil.Team == Settings.EnumTeam.Police then
			return true
		else
			return v1.playerHasItem(LocalPlayer, "Key")
		end
	end,
	getPlayerFromDescendant = function(p1)
		if p1 then
			for i, v in ipairs(Players:GetPlayers()) do
				if v.Character and p1:IsDescendantOf(v.Character) then
					return v
				end
			end
		end
	end
}
function t.isInVehicle(p1)
	return t.isHumanoidInVehicle((CharacterUtils.getHumanoid(p1.Character)))
end
function t.isHumanoidInVehicle(p1)
	if p1 then
		return p1.Parent:GetAttribute("InVehicle") == true
	else
		return false
	end
end
return t

-- Reviewed by Claude
-- variables reassigned
game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CharacterUtils = require(ReplicatedStorage.Std.CharacterUtils)
require(ReplicatedStorage.Std.Region.RegionUtils)
local GameUtil = require(ReplicatedStorage.Game.GameUtil)
local Settings = require(ReplicatedStorage.Resource.Settings)
local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local LocalPlayer = Players.LocalPlayer
local InventoryItemSystem = nil
local PlayerConsts = require(script.Parent.PlayerConsts)
local t = {
	init = function()
		InventoryItemSystem = require(ReplicatedStorage.Inventory.InventoryItemSystem)
	end,
	getLastVehicleSpawnedAt = function()
		local child = LocalPlayer:FindFirstChild(PlayerConsts.LAST_VEHICLE_SPAWNED_AT_VALUE_NAME)
		assert(child)
		return child.Value
	end,
	getHumanoid = function(player)
		local Character = player.Character
		if Character then
			return Character:FindFirstChild("Humanoid")
		end
	end,
	getRootPart = function(player)
		local Character = player.Character
		if Character then
			return Character.PrimaryPart
		end
	end,
	getTeam = function(player)
		local TeamValue = player:FindFirstChild("TeamValue")
		return TeamValue and TeamValue.Value
	end,
	getTeamId = function(player)
		if player.Team == Teams:FindFirstChild("Prisoner") then
			return Settings.EnumTeam.Prisoner
		elseif player.Team == Teams:FindFirstChild("Criminal") then
			return Settings.EnumTeam.Criminal
		elseif player.Team == Teams:FindFirstChild("Police") then
			return Settings.EnumTeam.Police
		else
			return nil
		end
	end,
	hasKey = function()
		if GameUtil.Team == Settings.EnumTeam.Police then
			return true
		else
			return InventoryItemSystem.playerHasItem(LocalPlayer, "Key")
		end
	end,
	getPlayerFromDescendant = function(player)
		if player then
			for i, v in ipairs(Players:GetPlayers()) do
				if v.Character and player:IsDescendantOf(v.Character) then
					return v
				end
			end
		end
	end
}
function t.isInVehicle(player)
	return t.isHumanoidInVehicle((CharacterUtils.getHumanoid(player.Character)))
end
function t.isHumanoidInVehicle(player)
	if player then
		return player.Parent:GetAttribute("InVehicle") == true
	else
		return false
	end
end
return t

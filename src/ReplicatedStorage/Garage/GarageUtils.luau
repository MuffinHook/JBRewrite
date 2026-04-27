local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CharacterUtils = require(ReplicatedStorage.Std.CharacterUtils)
local RegionUtils = require(ReplicatedStorage.Std.Region.RegionUtils)
local GamepassSystem = require(ReplicatedStorage.Gamepass.GamepassSystem)
local GamepassUtils = require(ReplicatedStorage.Gamepass.GamepassUtils)
local GarageConsts = require(ReplicatedStorage.Game.Garage.GarageConsts)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local PrivateServerUtils = require(ReplicatedStorage.PrivateServer.PrivateServerUtils)
local t = {
	isPlayerInPhysicalGarage = function(player)
		local isInGarage = false
		local garageRegions = CollectionService:GetTagged("Garage")
		local characterRootPart = CharacterUtils.getRootPart(player.Character)
		if characterRootPart then
			local Position = characterRootPart.Position
			for i, garageRegionInstance in ipairs(garageRegions) do
				local Region = garageRegionInstance:FindFirstChild("Region")
				if Region and RegionUtils.CastPoint(RegionUtils.getPrism(Region.CFrame, Region.Size), Position) then
					isInGarage = true
				end
			end
			return isInGarage
		end
	end
}
function t.inPhysicalGarage()
	return t.isPlayerInPhysicalGarage(Players.LocalPlayer)
end
function t.inVehicle()
	return VehicleUtils.GetLocalVehiclePacket() ~= nil
end
function t.hasPremium()
	return GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass.PremiumGarage) or PrivateServerUtils.getIsBattleServer()
end
function t.isVehicleCustomizationLimited(vehicleConfig)
	return if vehicleConfig.Hidden == true or (vehicleConfig.HiddenAll == true or (vehicleConfig.Level ~= nil or vehicleConfig.Season ~= nil)) then true else not vehicleConfig.Price
end
function t.isVehicleLimited(vehicleConfig)
	return if vehicleConfig.Hidden == true or (vehicleConfig.Retired == true or vehicleConfig.Level ~= nil) then true else vehicleConfig.Season ~= nil
end
function t.getIsSaveSlotValid(saveSlotNum, isVIP)
	assert(typeof(saveSlotNum) == "number", "saveSlotNum must be a number")
	assert(typeof(isVIP) == "boolean", "isVIP must be a boolean")
	if saveSlotNum == saveSlotNum then
		if isVIP then
			return if saveSlotNum > 0 then saveSlotNum <= GarageConsts.NUM_SAVE_SLOTS else false
		else
			return if saveSlotNum > 0 then saveSlotNum <= GarageConsts.NUM_FREE_SAVE_SLOTS else false
		end
	else
		return false
	end
end
return t

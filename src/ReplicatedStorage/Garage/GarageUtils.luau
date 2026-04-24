-- Reviewed by Claude
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
	isPlayerInPhysicalGarage = function(p1)
		local v1 = false
		local v2 = CollectionService:GetTagged("Garage")
		local v3 = CharacterUtils.getRootPart(p1.Character)
		if v3 then
			local Position = v3.Position
			for i, v in ipairs(v2) do
				local Region = v:FindFirstChild("Region")
				if Region and RegionUtils.CastPoint(RegionUtils.getPrism(Region.CFrame, Region.Size), Position) then
					v1 = true
				end
			end
			return v1
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
function t.isVehicleCustomizationLimited(p1)
	return if p1.Hidden == true or (p1.HiddenAll == true or (p1.Level ~= nil or p1.Season ~= nil)) then true else not p1.Price
end
function t.isVehicleLimited(p1)
	return if p1.Hidden == true or (p1.Retired == true or p1.Level ~= nil) then true else p1.Season ~= nil
end
function t.getIsSaveSlotValid(p1, p2)
	assert(typeof(p1) == "number", "saveSlotNum must be a number")
	assert(typeof(p2) == "boolean", "isVIP must be a boolean")
	if p1 == p1 then
		if p2 then
			return if p1 > 0 then p1 <= GarageConsts.NUM_SAVE_SLOTS else false
		else
			return if p1 > 0 then p1 <= GarageConsts.NUM_FREE_SAVE_SLOTS else false
		end
	else
		return false
	end
end
return t

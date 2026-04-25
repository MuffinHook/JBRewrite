-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GamepassSystem = require(ReplicatedStorage.Gamepass.GamepassSystem)
local GamepassUtils = require(ReplicatedStorage.Gamepass.GamepassUtils)
local Rodux = require(ReplicatedStorage.Rodux)
local GarageConsts = require(ReplicatedStorage.Garage.GarageConsts)
local GarageUtils = require(ReplicatedStorage.Garage.GarageUtils)
return Rodux.createReducer({}, {
	setSaveSlot = function(p1, p2)
		assert(p2.name, "missing slot name")
		assert(p2.equipped, "missing slot equipped")
		local stateCopy = {}
		for k, v in pairs(p1) do
			stateCopy[k] = v
		end
		local name_2 = p2.name
		local equipped_2 = p2.equipped
		if GarageUtils.getIsSaveSlotValid(tonumber(name_2:match("%d+")), (GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass.VIP))) then
			stateCopy[name_2] = equipped_2
		end
		local slotSaveRemote = ReplicatedStorage:FindFirstChild(GarageConsts.SLOT_SAVE_REMOTE_NAME)
		if slotSaveRemote then
			slotSaveRemote:FireServer(name_2)
		end
		return stateCopy
	end,
	deleteSaveSlot = function(p1, p2)
		assert(p2.name, "missing slot name")
		local stateCopy = {}
		for k, v in pairs(p1) do
			stateCopy[k] = v
		end
		stateCopy[p2.name] = nil
		local slotDeleteRemote = ReplicatedStorage:FindFirstChild(GarageConsts.SLOT_DELETE_REMOTE_NAME)
		if slotDeleteRemote then
			slotDeleteRemote:FireServer(p2.name)
		end
		return stateCopy
	end,
	loadSaveSlot = function(p1, p2)
		assert(p2.name, "missing slot name")
		local slotLoadRemote = ReplicatedStorage:FindFirstChild(GarageConsts.SLOT_LOAD_REMOTE_NAME)
		if slotLoadRemote then
			slotLoadRemote:FireServer(p2.name)
		end
		return p1
	end,
	setSavesRaw = function(p1, p2)
		assert(p2.saves ~= nil, "missing saves table")
		return p2.saves
	end
})

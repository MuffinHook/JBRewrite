local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GamepassSystem = require(ReplicatedStorage.Gamepass.GamepassSystem)
local GamepassUtils = require(ReplicatedStorage.Gamepass.GamepassUtils)
local Rodux = require(ReplicatedStorage.Rodux)
local GarageConsts = require(ReplicatedStorage.Garage.GarageConsts)
local GarageUtils = require(ReplicatedStorage.Garage.GarageUtils)
return Rodux.createReducer({}, {
	setSaveSlot = function(currentState, action)
		assert(action.name, "missing slot name")
		assert(action.equipped, "missing slot equipped")
		local stateCopy = {}
		for slotKey, slotConfig in pairs(currentState) do
			stateCopy[slotKey] = slotConfig
		end
		local slotName = action.name
		local equippedConfig = action.equipped
		if GarageUtils.getIsSaveSlotValid(tonumber(slotName:match("%d+")), (GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass.VIP))) then
			stateCopy[slotName] = equippedConfig
		end
		local slotSaveRemote = ReplicatedStorage:FindFirstChild(GarageConsts.SLOT_SAVE_REMOTE_NAME)
		if slotSaveRemote then
			slotSaveRemote:FireServer(slotName)
		end
		return stateCopy
	end,
	deleteSaveSlot = function(currentState, action)
		assert(action.name, "missing slot name")
		local stateCopy = {}
		for slotKey, slotConfig in pairs(currentState) do
			stateCopy[slotKey] = slotConfig
		end
		stateCopy[action.name] = nil
		local slotDeleteRemote = ReplicatedStorage:FindFirstChild(GarageConsts.SLOT_DELETE_REMOTE_NAME)
		if slotDeleteRemote then
			slotDeleteRemote:FireServer(action.name)
		end
		return stateCopy
	end,
	loadSaveSlot = function(currentState, action)
		assert(action.name, "missing slot name")
		local slotLoadRemote = ReplicatedStorage:FindFirstChild(GarageConsts.SLOT_LOAD_REMOTE_NAME)
		if slotLoadRemote then
			slotLoadRemote:FireServer(action.name)
		end
		return currentState
	end,
	setSavesRaw = function(currentState, action)
		assert(action.saves ~= nil, "missing saves table")
		return action.saves
	end
})

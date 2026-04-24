-- Reviewed by Claude
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
		local t = {}
		for k, v in pairs(p1) do
			t[k] = v
		end
		local name_2 = p2.name
		local equipped_2 = p2.equipped
		if GarageUtils.getIsSaveSlotValid(tonumber(name_2:match("%d+")), (GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass.VIP))) then
			t[name_2] = equipped_2
		end
		local v3 = ReplicatedStorage:FindFirstChild(GarageConsts.SLOT_SAVE_REMOTE_NAME)
		if v3 then
			v3:FireServer(name_2)
		end
		return t
	end,
	deleteSaveSlot = function(p1, p2)
		assert(p2.name, "missing slot name")
		local t = {}
		for k, v in pairs(p1) do
			t[k] = v
		end
		t[p2.name] = nil
		local v1 = ReplicatedStorage:FindFirstChild(GarageConsts.SLOT_DELETE_REMOTE_NAME)
		if v1 then
			v1:FireServer(p2.name)
		end
		return t
	end,
	loadSaveSlot = function(p1, p2)
		assert(p2.name, "missing slot name")
		local v1 = ReplicatedStorage:FindFirstChild(GarageConsts.SLOT_LOAD_REMOTE_NAME)
		if v1 then
			v1:FireServer(p2.name)
		end
		return p1
	end,
	setSavesRaw = function(p1, p2)
		assert(p2.saves ~= nil, "missing saves table")
		return p2.saves
	end
})

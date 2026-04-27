local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)
require(ReplicatedStorage.Garage.GarageConsts)
local function setCategoryEquipped(state, action)
	assert(action.category ~= nil, "missing category")
	assert(action.name ~= nil, "missing name")
	local newState = {}
	for category, equippedItem in pairs(state) do
		newState[category] = equippedItem
	end
	newState[action.category] = action.name
	return newState
end
return Rodux.createReducer({}, {
	setCategoryEquipped = setCategoryEquipped,
	setCategoryItemOwned = setCategoryEquipped,
	setEquippedRaw = function(state, action)
		assert(action.equipped, "missing equipped")
		return action.equipped
	end
})

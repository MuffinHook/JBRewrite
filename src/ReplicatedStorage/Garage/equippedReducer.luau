-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)
require(ReplicatedStorage.Garage.GarageConsts)
local function setCategoryEquipped(p1, p2)
	assert(p2.category ~= nil, "missing category")
	assert(p2.name ~= nil, "missing name")
	local t = {}
	for k, v in pairs(p1) do
		t[k] = v
	end
	t[p2.category] = p2.name
	return t
end
return Rodux.createReducer({}, {
	setCategoryEquipped = setCategoryEquipped,
	setCategoryItemOwned = setCategoryEquipped,
	setEquippedRaw = function(p1, p2)
		assert(p2.equipped, "missing equipped")
		return p2.equipped
	end
})

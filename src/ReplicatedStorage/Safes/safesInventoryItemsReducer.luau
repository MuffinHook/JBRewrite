-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)
local SAFE_DATA = require(ReplicatedStorage.Safes.SafesConsts).SAFE_DATA
return Rodux.createReducer({}, {
	setSafesInventoryItems = function(p1, p2)
		assert(p2.itemsOwned ~= nil, "missing itemsOwned")
		local t = {}
		for v2, v3 in p2.itemsOwned do
			local v1
			assert(v3.Id, "missing Id")
			local TypeEnum = v3.TypeEnum
			local v4 = SAFE_DATA[TypeEnum]
			v1 = v4 ~= nil
			assert(v1, "missing safeTierData")
			table.insert(t, {
				name = ("%s_%s"):format(TypeEnum, v2),
				typeEnum = TypeEnum,
				imageId = v4.ImageId,
				itemOwnedId = v3.Id
			})
		end
		return t
	end
})

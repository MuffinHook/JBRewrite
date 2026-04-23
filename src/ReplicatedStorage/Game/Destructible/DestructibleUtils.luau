local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DestructibleConsts = require(ReplicatedStorage.Game.Destructible.DestructibleConsts)
return {
	getMaxDistToLoad = function() --[[ Name: getMaxDistToLoad | Line: 5 | Upvalues: ReplicatedStorage (copy), DestructibleConsts (copy) ]]
		return ReplicatedStorage:GetAttribute(DestructibleConsts.MAX_DIST_TO_LOAD_ATTR_NAME) or DestructibleConsts.MAX_DIST_TO_LOAD
	end,
	setMaxDistToLoad = function(p1) --[[ Name: setMaxDistToLoad | Line: 9 | Upvalues: ReplicatedStorage (copy), DestructibleConsts (copy) ]]
		ReplicatedStorage:SetAttribute(DestructibleConsts.MAX_DIST_TO_LOAD_ATTR_NAME, p1)
	end
}
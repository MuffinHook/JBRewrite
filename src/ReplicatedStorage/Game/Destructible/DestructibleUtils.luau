-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DestructibleConsts = require(ReplicatedStorage.Game.Destructible.DestructibleConsts)
return {
	getMaxDistToLoad = function()
		return ReplicatedStorage:GetAttribute(DestructibleConsts.MAX_DIST_TO_LOAD_ATTR_NAME) or DestructibleConsts.MAX_DIST_TO_LOAD
	end,
	setMaxDistToLoad = function(p1)
		ReplicatedStorage:SetAttribute(DestructibleConsts.MAX_DIST_TO_LOAD_ATTR_NAME, p1)
	end
}

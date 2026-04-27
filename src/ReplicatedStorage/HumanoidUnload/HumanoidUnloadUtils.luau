local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HumanoidUnloadConsts = require(ReplicatedStorage.HumanoidUnload.HumanoidUnloadConsts)
return {
	getMaxDistToLoad = function()
		return ReplicatedStorage:GetAttribute(HumanoidUnloadConsts.MAX_DIST_TO_LOAD_ATTR_NAME) or HumanoidUnloadConsts.MAX_DIST_TO_LOAD
	end,
	setMaxDistToLoad = function(maxDistance)
		ReplicatedStorage:SetAttribute(HumanoidUnloadConsts.MAX_DIST_TO_LOAD_ATTR_NAME, maxDistance)
	end
}

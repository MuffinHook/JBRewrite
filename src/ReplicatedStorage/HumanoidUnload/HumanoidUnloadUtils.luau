local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HumanoidUnloadConsts = require(ReplicatedStorage.HumanoidUnload.HumanoidUnloadConsts)
return {
	getMaxDistToLoad = function() --[[ Name: getMaxDistToLoad | Line: 6 | Upvalues: ReplicatedStorage (copy), HumanoidUnloadConsts (copy) ]]
		return ReplicatedStorage:GetAttribute(HumanoidUnloadConsts.MAX_DIST_TO_LOAD_ATTR_NAME) or HumanoidUnloadConsts.MAX_DIST_TO_LOAD
	end,
	setMaxDistToLoad = function(p1) --[[ Name: setMaxDistToLoad | Line: 11 | Upvalues: ReplicatedStorage (copy), HumanoidUnloadConsts (copy) ]]
		ReplicatedStorage:SetAttribute(HumanoidUnloadConsts.MAX_DIST_TO_LOAD_ATTR_NAME, p1)
	end
}
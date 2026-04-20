local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local HumanoidUnloadConsts_upvr = require(ReplicatedStorage_upvr.HumanoidUnload.HumanoidUnloadConsts)
return {
    getMaxDistToLoad = function() -- Line 6, Named "getMaxDistToLoad"
        local attribute = ReplicatedStorage_upvr:GetAttribute(HumanoidUnloadConsts_upvr.MAX_DIST_TO_LOAD_ATTR_NAME)
        if not attribute then
            attribute = HumanoidUnloadConsts_upvr
            attribute = attribute.MAX_DIST_TO_LOAD
        end
        return attribute
    end;
    setMaxDistToLoad = function(arg1) -- Line 11, Named "setMaxDistToLoad"
        ReplicatedStorage_upvr:SetAttribute(HumanoidUnloadConsts_upvr.MAX_DIST_TO_LOAD_ATTR_NAME, arg1)
    end;
}
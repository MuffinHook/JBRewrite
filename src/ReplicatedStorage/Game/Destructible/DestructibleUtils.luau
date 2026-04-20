local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local DestructibleConsts_upvr = require(ReplicatedStorage_upvr.Game.Destructible.DestructibleConsts)
return {
    getMaxDistToLoad = function() -- Line 5, Named "getMaxDistToLoad"
        local attribute = ReplicatedStorage_upvr:GetAttribute(DestructibleConsts_upvr.MAX_DIST_TO_LOAD_ATTR_NAME)
        if not attribute then
            attribute = DestructibleConsts_upvr
            attribute = attribute.MAX_DIST_TO_LOAD
        end
        return attribute
    end;
    setMaxDistToLoad = function(arg1) -- Line 9, Named "setMaxDistToLoad"
        ReplicatedStorage_upvr:SetAttribute(DestructibleConsts_upvr.MAX_DIST_TO_LOAD_ATTR_NAME, arg1)
    end;
}
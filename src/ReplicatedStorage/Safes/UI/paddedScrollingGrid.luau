local ReplicatedStorage = game:GetService("ReplicatedStorage")
local createElement_upvr = require(ReplicatedStorage.Roact).createElement
local ScrollingGrid_upvr = require(ReplicatedStorage.EzUi.ScrollingGrid)
local Dictionary_upvr = require(ReplicatedStorage.EzUi.Dictionary)
return function(arg1) -- Line 7
    arg1.verticalPaddingRatio = nil
    return createElement_upvr(ScrollingGrid_upvr, Dictionary_upvr.merge(arg1, {
        paddingRatio = arg1.verticalPaddingRatio * arg1.aspectRatio;
    }))
end
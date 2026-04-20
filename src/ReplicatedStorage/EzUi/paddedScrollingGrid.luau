local createElement_upvr = require(script:FindFirstAncestor("EzUi").Parent.Roact).createElement
local ScrollingGrid_upvr = require(script.Parent.ScrollingGrid)
local Dictionary_upvr = require(script.Parent.Dictionary)
return function(arg1) -- Line 8
    return createElement_upvr(ScrollingGrid_upvr, Dictionary_upvr.merge(arg1, {
        injectPaddedContainerProps = true;
    }))
end
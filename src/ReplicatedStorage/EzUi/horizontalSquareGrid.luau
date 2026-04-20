local EzUi = script:FindFirstAncestor("EzUi")
local Roact_upvr = require(EzUi.Parent.Roact)
local createElement_upvr = Roact_upvr.createElement
local Dictionary_upvr = require(EzUi.Dictionary)
return function(arg1) -- Line 9, Named "horizontalSquareGrid"
    local module = {}
    local numItems_2 = arg1.numItems
    if not numItems_2 then
        numItems_2 = #arg1.items
    end
    local aspectRatio = arg1.aspectRatio
    for i = 1, numItems_2 do
        local var19 = i - 1 - numItems_2 / 2
        local var20 = arg1.items[i]
        if not var20 then
            var20 = {}
        end
        local id = var20.id
        if not id then
            id = var20.name
            if not id then
                id = #module + 1
            end
        end
        module[id] = createElement_upvr(arg1.component, Dictionary_upvr.merge(arg1.items[i], {
            size = UDim2.fromScale(1 / aspectRatio, 1);
            position = UDim2.fromScale(0.5 + var19 / aspectRatio + (var19) * (1 / arg1.verticalPaddingRatio / aspectRatio), 0);
        }))
    end
    return Roact_upvr.createFragment(module)
end
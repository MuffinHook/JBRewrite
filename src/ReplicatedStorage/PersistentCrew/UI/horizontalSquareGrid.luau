local ReplicatedStorage = game:GetService("ReplicatedStorage")
local createElement_upvr = require(ReplicatedStorage.Roact).createElement
local PaddedContainer_upvr = require(ReplicatedStorage.EzUi.PaddedContainer)
local function horizontalSquareGridItem_upvr(arg1) -- Line 7, Named "horizontalSquareGridItem"
    local var4 = 1 / (1 / arg1.aspectRatio + 1 / arg1.verticalPaddingRatio / arg1.aspectRatio)
    return createElement_upvr(PaddedContainer_upvr, {
        component = arg1.component;
        props = arg1.props;
        aspectRatio = var4;
        verticalPaddingRatio = arg1.verticalPaddingRatio;
        size = UDim2.fromScale(1 / var4, 1);
        position = UDim2.fromScale(0.5 + (arg1.index - 1 - arg1.numItems / 2) / var4, 0);
        paddingTop = 0;
        paddingBottom = 0;
        paddingRight = 0.5;
        paddingLeft = 0.5;
    })
end
local Dictionary_upvr = require(ReplicatedStorage.Std.Dictionary)
return function(arg1) -- Line 23, Named "horizontalSquareGrid"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local module = {}
    local numItems = arg1.numItems
    if not numItems then
        numItems = #arg1.items
    end
    for i = 1, numItems do
        module[i] = createElement_upvr(horizontalSquareGridItem_upvr, {
            exposePaddedContainerProps = true;
            index = i;
            numItems = numItems;
            component = arg1.component;
            props = Dictionary_upvr.merge(arg1.items[i], arg1.itemMetadata);
        })
    end
    return createElement_upvr(PaddedContainer_upvr, {
        backgroundTransparency = 1;
        backgroundColor = Color3.new(0, 0, 0);
        aspectRatio = arg1.aspectRatio;
        verticalPaddingRatio = arg1.verticalPaddingRatio;
        size = UDim2.fromScale(1, 1);
        paddingLeft = 0;
        paddingRight = 0;
    }, module)
end
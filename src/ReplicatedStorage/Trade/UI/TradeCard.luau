local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local createElement_upvr = Roact_upvr.createElement
local function infoComponent_upvr(arg1) -- Line 11, Named "infoComponent"
    local valueColor = arg1.valueColor
    if not valueColor then
        valueColor = Color3.new(1, 1, 1)
    end
    local module = {}
    local tbl = {
        BackgroundTransparency = 1;
        Size = UDim2.new(0.9, 0, 0.3, 0);
        Position = UDim2.new(0.5, 0, 0, 0);
        AnchorPoint = Vector2.new(0.5, 0);
        Text = arg1.title;
        Font = Enum.Font.Bangers;
        TextXAlignment = Enum.TextXAlignment.Center;
        LineHeight = 1;
        TextScaled = true;
    }
    local titleColor = arg1.titleColor
    if not titleColor then
        titleColor = Color3.new(1, 1, 1)
    end
    tbl.TextColor3 = titleColor
    module.Title = createElement_upvr("TextLabel", tbl)
    module.Value = createElement_upvr("TextLabel", {
        BackgroundTransparency = 1;
        Size = UDim2.new(0.9, 0, 0.7, 0);
        Position = UDim2.new(0.5, 0, 0.3, 0);
        AnchorPoint = Vector2.new(0.5, 0);
        Text = arg1.value;
        Font = Enum.Font.Bangers;
        TextXAlignment = Enum.TextXAlignment.Center;
        LineHeight = 1;
        TextScaled = true;
        TextColor3 = valueColor;
    })
    return createElement_upvr("Frame", {
        BackgroundTransparency = 1;
        Size = arg1.size;
        Position = arg1.position;
    }, module)
end
local any_extend_result1 = Roact_upvr.PureComponent:extend("TradeCard")
any_extend_result1.defaultProps = {
    size = UDim2.new(1, 0, 1, 0);
    position = UDim2.new(0, 0, 0, 0);
    cornerPixel = 8;
    aspectRatio = 0.5;
    selected = false;
    number = nil;
    isOriginalOwner = false;
}
function any_extend_result1.init(arg1) -- Line 55
    arg1:setState({
        hover = false;
        hoverInfo = false;
        showInfo = false;
    })
    function arg1.setHoverTrue() -- Line 61
        arg1:setState({
            hover = true;
        })
    end
    function arg1.setHoverFalse() -- Line 66
        arg1:setState({
            hover = false;
        })
    end
    function arg1.setHoverInfoTrue() -- Line 71
        arg1:setState({
            hoverInfo = true;
        })
    end
    function arg1.setHoverInfoFalse() -- Line 76
        arg1:setState({
            hoverInfo = false;
        })
    end
end
local PlayerDataConsts_upvr = require(ReplicatedStorage.PlayerData.PlayerDataConsts)
local ColorUtils_upvr = require(ReplicatedStorage.Std.ColorUtils)
local ScrollingGrid_upvr = require(ReplicatedStorage.EzUi.ScrollingGrid)
local ViewportFrame_upvr = require(ReplicatedStorage.EzUi.ViewportFrame)
local Dictionary_upvr = require(ReplicatedStorage.EzUi.Dictionary)
function any_extend_result1.render(arg1) -- Line 82
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local var29 = not arg1.props.showPlus
    if var29 then
        var29 = not arg1.props.blank
        if var29 then
            var29 = not arg1.state.showInfo
        end
    end
    if not var29 then
    end
    local var30 = 10
    local var31 = 8
    if arg1.state.showInfo then
        var30 *= 2
        var31 *= 2
    end
    if arg1.props.showPlus then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    if arg1.props.itemType == PlayerDataConsts_upvr.VEHICLE_CUSTOMIZATION_ITEM_TYPE then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if arg1.props.itemType == PlayerDataConsts_upvr.VEHICLE_ITEM_TYPE then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
return any_extend_result1
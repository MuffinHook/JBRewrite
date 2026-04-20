local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("TradeCategory")
any_extend_result1.defaultProps = {
    size = UDim2.new(1, 0, 1, 0);
    position = UDim2.new(0, 0, 0, 0);
    cornerPixel = 8;
    selected = false;
}
function any_extend_result1.init(arg1) -- Line 15
    arg1:setState({
        hover = false;
    })
end
local PlayerDataConsts_upvr = require(ReplicatedStorage.PlayerData.PlayerDataConsts)
local ColorUtils_upvr = require(ReplicatedStorage.Std.ColorUtils)
local createElement_upvr = Roact_upvr.createElement
local Dictionary_upvr = require(ReplicatedStorage.EzUi.Dictionary)
function any_extend_result1.render(arg1) -- Line 20
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
return any_extend_result1
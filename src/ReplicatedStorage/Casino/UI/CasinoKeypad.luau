local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact.PureComponent:extend("CasinoKeypad")
any_extend_result1.defaultProps = {
    expireDistance = 16;
}
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function any_extend_result1.init(arg1) -- Line 16
    arg1.maid = Maid_upvr.new()
end
local createElement_upvr = Roact.createElement
local Keypad_upvr = require(ReplicatedStorage.App.UI.Keypad)
function any_extend_result1.render(arg1) -- Line 19
    if not arg1.props.keypadVisible then return end
    return createElement_upvr(Keypad_upvr, {
        title = "Search around the room...";
        size = UDim2.new(0.5, 0, 0.5, 0);
        onSubmit = function(...) -- Line 26, Named "onSubmit"
            arg1.props.keypadCallback(...)
            arg1.props.onClickClose()
        end;
        onClickClose = arg1.props.onClickClose;
    })
end
local CharacterUtils_upvr = require(ReplicatedStorage.Std.CharacterUtils)
local Players_upvr = game:GetService("Players")
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
function any_extend_result1.didUpdate(arg1, arg2) -- Line 33
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    arg1.maid.expireDistCheck = nil
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function any_extend_result1.willUnmount(arg1) -- Line 58
    arg1.maid:DoCleaning()
end
return require(ReplicatedStorage.RoactRodux).connect(function(arg1, arg2) -- Line 62
    return {
        keypadVisible = arg1.casinoKeypadVisible;
        keypadCallback = arg1.casinoKeypadCallback;
    }
end, function(arg1) -- Line 67
    return {
        onClickClose = function() -- Line 69, Named "onClickClose"
            arg1({
                type = "setCasinoKeypadVisible";
                visible = false;
            })
        end;
    }
end)(any_extend_result1)
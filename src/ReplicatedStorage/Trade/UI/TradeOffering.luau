local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("TradeOffering")
any_extend_result1.defaultProps = {
    size = UDim2.new(1, 0, 1, 0);
}
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function any_extend_result1.init(arg1) -- Line 21
    arg1.maid = Maid_upvr.new()
    local any_createBinding_result1, any_createBinding_result2 = Roact_upvr.createBinding(0)
    arg1.arrowSine = any_createBinding_result1
    arg1.updateArrowSine = any_createBinding_result2
end
local ColorUtils_upvr = require(ReplicatedStorage.Std.ColorUtils)
local TradeConsts_upvr = require(ReplicatedStorage.Trade.TradeConsts)
local Dictionary_upvr = require(ReplicatedStorage.EzUi.Dictionary)
local createElement_upvr = Roact_upvr.createElement
local PlayerTitle_upvr = require(script.Parent.PlayerTitle)
local Grid_upvr = require(ReplicatedStorage.EzUi.Grid)
local TradeCard_upvr = require(script.Parent.TradeCard)
local TradeButton_upvr = require(script.Parent.TradeButton)
local TradeChat_upvr = require(script.Parent.TradeChat)
function any_extend_result1.render(arg1) -- Line 25
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local var25
    if arg1.props.traderMe.ready then
        var25 = Color3.fromRGB(0, 153, 59)
    end
    if arg1.props.traderMe.accepted then
        var25 = ColorUtils_upvr.brightenBy(var25, -0.5)
    end
    if arg1.props.traderThem.ready then
    end
    if arg1.props.traderThem.accepted then
    end
    for i_upvr = 1, TradeConsts_upvr.MAX_OFFER_ITEMS do
        local len = #arg1.props.traderMe.offerItems
        if i_upvr <= len then
            table.insert({}, Dictionary_upvr.merge(arg1.props.traderMe.offerItems[i_upvr], {
                onClick = function() -- Line 69, Named "onClick"
                    arg1.props.removeTraderMeOfferItem(i_upvr)
                end;
            }))
        elseif i_upvr == len + 1 and not arg1.props.traderMe.ready then
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            table.insert({}, {
                showPlus = true;
                onClick = arg1.props.promptInventory;
                onCardFlipped = arg1.props.onCardFlipped;
            })
        else
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            table.insert({}, {
                blank = true;
            })
        end
    end
    for i_2 = 1, TradeConsts_upvr.MAX_OFFER_ITEMS do
        if not arg1.props.traderThem.offerItems[i_2] then
        end
        table.insert({}, {
            blank = true;
            onCardFlipped = arg1.props.onCardFlipped;
        })
    end
    if arg1.props.traderMe.accepted then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if arg1.props.traderMe.ready and arg1.props.traderThem.ready then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
function any_extend_result1.didUpdate(arg1, arg2, arg3) -- Line 304
    if arg2.traderMe.ready ~= arg1.props.traderMe.ready or arg2.traderThem.ready ~= arg1.props.traderThem.ready then
        local os_clock_result1_upvr = os.clock()
        local function update_upvr(arg1_2) -- Line 310, Named "update"
            local var33 = (arg1_2) - (os.clock() - os_clock_result1_upvr)
            if var33 < 0 then
                arg1:setState({
                    primaryButtonCountdown = Roact_upvr.None;
                })
                arg1.maid.countdown = nil
            else
                arg1:setState({
                    primaryButtonCountdown = math.ceil(var33);
                })
            end
        end
        if arg1.props.traderMe.ready and arg1.props.traderThem.ready then
            update_upvr(5)
            arg1.maid.countdown = Interval_upvr.every(1):Connect(function() -- Line 328
                update_upvr(5)
            end)
            return
        end
        if arg2.traderMe.ready and not arg1.props.traderMe.ready then
            update_upvr(1)
            arg1.maid.countdown = Interval_upvr.every(1):Connect(function() -- Line 334
                update_upvr(1)
            end)
            return
        end
        arg1:setState({
            primaryButtonCountdown = Roact_upvr.None;
        })
        arg1.maid.countdown = nil
    end
end
local RunService_upvr = game:GetService("RunService")
function any_extend_result1.didMount(arg1) -- Line 345
    arg1.maid:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 346
        arg1.updateArrowSine(math.sin(os.clock() * 3) * 0.5 + 0.5)
    end))
end
function any_extend_result1.willUnmount(arg1) -- Line 351
    arg1.maid:DoCleaning()
end
return any_extend_result1
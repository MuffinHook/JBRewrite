local Players_upvr = game:GetService("Players")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
local Roact = require(ReplicatedStorage_upvr.Roact)
local function _() -- Line 13, Named "playTick"
    if Players_upvr.LocalPlayer.PlayerGui then
        Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 6105461542, {
            Volume = 0.15;
        })
    end
end
local any_extend_result1 = Roact.PureComponent:extend("TradeInitiations")
any_extend_result1.defaultProps = {
    size = UDim2.new(1, 0, 1, 0);
    position = UDim2.new(0, 0, 0, 0);
    aspectRatio = 1.25;
    maximumItemsDisplayed = 4;
}
local TradeService_upvr = require(ReplicatedStorage_upvr.Trade.TradeService)
local TradeConsts_upvr = require(ReplicatedStorage_upvr.Trade.TradeConsts)
function any_extend_result1.init(arg1) -- Line 26
    function arg1.onAccept(arg1_2) -- Line 27
        TradeService_upvr.acceptInitiation(arg1.props.tradeInitiations[arg1_2].userId)
        arg1.props.removeByIndex(arg1_2)
        if Players_upvr.LocalPlayer.PlayerGui then
            Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 6105461542, {
                Volume = 0.15;
            })
        end
    end
    function arg1.onDecline(arg1_3) -- Line 33
        ReplicatedStorage_upvr:FindFirstChild(TradeConsts_upvr.DECLINE_TRADE_INITIATION_REMOTE_NAME):FireServer(arg1.props.tradeInitiations[arg1_3].userId)
        arg1.props.removeByIndex(arg1_3)
        if Players_upvr.LocalPlayer.PlayerGui then
            Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 6105461542, {
                Volume = 0.15;
            })
        end
    end
end
local createElement_upvr = Roact.createElement
local TradeInitiation_upvr = require(script.Parent.TradeInitiation)
local Dictionary_upvr = require(ReplicatedStorage_upvr.EzUi.Dictionary)
function any_extend_result1.render(arg1) -- Line 41
    local var19 = 1 / (1 / arg1.props.maximumItemsDisplayed - (1) / (256 / arg1.props.maximumItemsDisplayed)) * arg1.props.aspectRatio
    local var20 = arg1.props.maximumItemsDisplayed * arg1.props.aspectRatio
    local module = {}
    local len = #arg1.props.tradeInitiations
    for i = 1, math.min(len, arg1.props.maximumItemsDisplayed) do
        local var23 = len - i + 1
        local var24 = arg1.props.tradeInitiations[var23]
        module[i] = createElement_upvr(TradeInitiation_upvr, {
            aspectRatio = var19;
            position = UDim2.new(0, 0, 1 + (i - len - 1) / var20 * arg1.props.aspectRatio, 0);
            displayName = var24.name;
            isTradingVIP = var24.isTradingVIP;
            obj = var24.obj;
            index = var23;
            onAccept = arg1.onAccept;
            onDecline = arg1.onDecline;
        })
    end
    return createElement_upvr("Frame", {
        BackgroundTransparency = 1;
        Size = arg1.props.size;
        Position = arg1.props.position;
        AnchorPoint = arg1.props.anchorPoint;
        ZIndex = 2;
    }, Dictionary_upvr.merge({
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = arg1.props.aspectRatio;
        });
    }, module))
end
return require(ReplicatedStorage_upvr.RoactRodux).connect(function(arg1, arg2) -- Line 86
    return {
        tradeInitiations = arg1.tradeInitiations;
    }
end, function(arg1) -- Line 90
    return {
        removeByIndex = function(arg1_4) -- Line 92, Named "removeByIndex"
            local tbl = {
                type = "tradeInitiationsRemoveByIndex";
            }
            tbl.index = arg1_4
            arg1(tbl)
        end;
    }
end)(any_extend_result1)
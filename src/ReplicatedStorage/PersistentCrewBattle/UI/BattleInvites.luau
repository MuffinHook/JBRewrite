local Players_upvr = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local Roact = require(ReplicatedStorage.Roact)
local function _() -- Line 11, Named "playTick"
    if Players_upvr.LocalPlayer and Players_upvr.LocalPlayer.PlayerGui then
        Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 6105461542, {
            Volume = 0.15;
        })
    end
end
local any_extend_result1 = Roact.PureComponent:extend("BattleInvites")
any_extend_result1.defaultProps = {
    size = UDim2.new(1, 0, 1, 0);
    position = UDim2.new(0, 0, 0, 0);
    aspectRatio = 1.25;
    maximumItemsDisplayed = 4;
}
function any_extend_result1.init(arg1) -- Line 24
    function arg1.onAccept(arg1_2) -- Line 25
        arg1.props.removeByIndex(arg1_2)
        if Players_upvr.LocalPlayer and Players_upvr.LocalPlayer.PlayerGui then
            Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 6105461542, {
                Volume = 0.15;
            })
        end
        if arg1.props.onAccept then
            arg1.props.onAccept(arg1.props.battleInvites[arg1_2])
        end
    end
    function arg1.onDecline(arg1_3) -- Line 33
        arg1.props.removeByIndex(arg1_3)
        if Players_upvr.LocalPlayer and Players_upvr.LocalPlayer.PlayerGui then
            Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 6105461542, {
                Volume = 0.15;
            })
        end
        if arg1.props.onDecline then
            arg1.props.onDecline(arg1.props.battleInvites[arg1_3])
        end
    end
end
local createElement_upvr = Roact.createElement
local BattleInvite_upvr = require(script.Parent.BattleInvite)
local Dictionary_upvr = require(ReplicatedStorage.EzUi.Dictionary)
function any_extend_result1.render(arg1) -- Line 42
    local var17 = 1 / (1 / arg1.props.maximumItemsDisplayed - (1) / (256 / arg1.props.maximumItemsDisplayed)) * arg1.props.aspectRatio
    local var18 = arg1.props.maximumItemsDisplayed * arg1.props.aspectRatio
    local module = {}
    local len = #arg1.props.battleInvites
    for i = 1, math.min(len, arg1.props.maximumItemsDisplayed) do
        local var21 = len - i + 1
        module[i] = createElement_upvr(BattleInvite_upvr, Dictionary_upvr.merge({
            aspectRatio = var17;
            position = UDim2.new(0, 0, 1 + (i - len - 1) / var18 * arg1.props.aspectRatio, 0);
            index = var21;
            onAccept = arg1.onAccept;
            onDecline = arg1.onDecline;
        }, arg1.props.battleInvites[var21]))
    end
    return createElement_upvr("Frame", {
        BackgroundTransparency = 1;
        Size = arg1.props.size;
        Position = arg1.props.position;
        AnchorPoint = arg1.props.anchorPoint;
    }, Dictionary_upvr.merge({
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = arg1.props.aspectRatio;
        });
    }, module))
end
return require(ReplicatedStorage.RoactRodux).connect(function(arg1, arg2) -- Line 86
    return {
        battleInvites = arg1.battleInvites;
    }
end, function(arg1) -- Line 90
    return {
        removeByIndex = function(arg1_4) -- Line 92, Named "removeByIndex"
            local tbl = {
                type = "battleInvitesRemoveByIndex";
            }
            tbl.index = arg1_4
            arg1(tbl)
        end;
    }
end)(any_extend_result1)
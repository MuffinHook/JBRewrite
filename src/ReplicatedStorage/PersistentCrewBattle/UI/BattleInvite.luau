local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local PersistentCrewBattleConsts_upvr = require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleConsts)
local any_extend_result1 = Roact_upvr.PureComponent:extend("BattleInvite")
any_extend_result1.defaultProps = {
    size = UDim2.new(1, 0, 1, 0);
    position = UDim2.new(0, 0, 0, 0);
    aspectRatio = 6;
}
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function any_extend_result1.init(arg1) -- Line 16
    arg1:setState({
        remaining = 0;
        createdAt = workspace:GetServerTimeNow();
    })
    function arg1.onAccept() -- Line 21
        arg1.props.onAccept(arg1.props.index)
    end
    function arg1.onDecline() -- Line 24
        arg1.props.onDecline(arg1.props.index)
    end
    arg1.maid = Maid_upvr.new()
end
local createElement_upvr = Roact_upvr.createElement
local TradeButton_upvr = require(ReplicatedStorage.Trade.UI.TradeButton)
function any_extend_result1.render(arg1) -- Line 29
    local aspectRatio = arg1.props.aspectRatio
    local var13
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var13 = Color3.fromRGB(255, 215, 0)
        return var13
    end
    if not arg1.props.ranked or not decompInlinedCondition() then
        var13 = Color3.new(1, 1, 1)
    end
    local var14
    if arg1.props.ranked then
        var14 = string.format("Enter ranked %d player crew battle?", arg1.props.battleNumPlayersPerTeam)
    else
        var14 = string.format("Enter %d player crew battle against %s's %s (%s)?", arg1.props.battleNumPlayersPerTeam, arg1.props.opposingClanOwnerName, arg1.props.clanName, arg1.props.clanDisplayRating or "N/A")
    end
    return createElement_upvr("Frame", {
        BorderSizePixel = 0;
        BackgroundColor3 = Color3.new(0, 0, 0);
        BackgroundTransparency = 0.5;
        Size = arg1.props.size;
        Position = arg1.props.position;
        AnchorPoint = arg1.props.anchorPoint;
    }, {
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = arg1.props.aspectRatio;
        });
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 4);
        });
        Title = createElement_upvr("Frame", {
            BackgroundTransparency = 1;
            BackgroundColor3 = Color3.new(1, 0, 0);
            Size = UDim2.new(0.96875, 0, 0.5 - 0.03125 * aspectRatio, 0);
            Position = UDim2.new(0.015625, 0, 0.015625 * aspectRatio, 0);
        }, {
            Text = createElement_upvr("TextLabel", {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 1, 0);
                Position = UDim2.new(0.5, 0, 0.5, 0);
                AnchorPoint = Vector2.new(0.5, 0.5);
                TextColor3 = var13;
                Text = var14;
                TextXAlignment = Enum.TextXAlignment.Left;
                Font = Enum.Font.FredokaOne;
                LineHeight = 1;
                TextScaled = true;
            });
        });
        Time = createElement_upvr("Frame", {
            BorderSizePixel = 0;
            BackgroundTransparency = 1;
            BackgroundColor3 = Color3.new(1, 0, 0);
            Size = UDim2.new(0.3177083333333333, 0, 0.5 - 0.03125 * aspectRatio, 0);
            Position = UDim2.new(0.015625, 0, 0.5 + 0.015625 * aspectRatio, 0);
        }, {
            Text = createElement_upvr("TextLabel", {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 1, 0);
                Position = UDim2.new(0.5, 0, 0.5, 0);
                AnchorPoint = Vector2.new(0.5, 0.5);
                TextColor3 = Color3.new(1, 0, 0);
                Text = tostring(arg1.state.remaining)..'s';
                TextXAlignment = Enum.TextXAlignment.Left;
                TextYAlignment = Enum.TextYAlignment.Bottom;
                Font = Enum.Font.FredokaOne;
                LineHeight = 1;
                TextScaled = true;
            });
        });
        Accept = createElement_upvr(TradeButton_upvr, {
            backgroundColor = Color3.fromRGB(42, 170, 255);
            size = UDim2.new(0.25, 0, 0.5 - 0.015625 * aspectRatio, 0);
            position = UDim2.new(0.734375, 0, 0.5, 0);
            aspectRatio = Roact_upvr.None;
            text = "Accept";
            onClick = arg1.onAccept;
            cornerPixel = 0;
            cornerScale = 1;
        });
        Decline = createElement_upvr(TradeButton_upvr, {
            backgroundColor = Color3.fromRGB(255, 58, 43);
            size = UDim2.new(0.25, 0, 0.5 - 0.015625 * aspectRatio, 0);
            position = UDim2.new(0.46875, 0, 0.5, 0);
            aspectRatio = Roact_upvr.None;
            text = "Decline";
            onClick = arg1.onDecline;
            cornerPixel = 0;
            cornerScale = 1;
        });
    })
end
function any_extend_result1._hookObj(arg1) -- Line 124
    arg1:setState({
        createdAt = arg1.props.obj:GetAttribute(PersistentCrewBattleConsts_upvr.INVITE_CREATED_AT_ATTR_NAME);
    })
    arg1.maid.listenForInviteCreatedAtChanged = arg1.props.obj:GetAttributeChangedSignal(PersistentCrewBattleConsts_upvr.INVITE_CREATED_AT_ATTR_NAME):Connect(function() -- Line 130
        arg1:setState({
            createdAt = arg1.props.obj:GetAttribute(PersistentCrewBattleConsts_upvr.INVITE_CREATED_AT_ATTR_NAME);
        })
    end)
end
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
function any_extend_result1.didMount(arg1) -- Line 136
    if arg1.props.obj then
        arg1:_hookObj()
    end
    local function update() -- Line 140
        arg1:setState({
            remaining = math.floor(math.max(0, (PersistentCrewBattleConsts_upvr.INVITE_TIMEOUT_DURATION) - (workspace:GetServerTimeNow() - arg1.state.createdAt)));
        })
    end
    update()
    arg1.maid:GiveTask(Interval_upvr.every(1):Connect(update))
end
function any_extend_result1.didUpdate(arg1, arg2, arg3) -- Line 151
    if arg1.props.obj ~= arg2.obj and arg1.props.obj then
        arg1:_hookObj()
    end
end
function any_extend_result1.willUnmount(arg1) -- Line 158
    arg1.maid:DoCleaning()
end
return any_extend_result1
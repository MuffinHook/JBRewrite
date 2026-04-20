local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local TradeConsts_upvr = require(ReplicatedStorage.Trade.TradeConsts)
local any_extend_result1 = Roact_upvr.PureComponent:extend("TradeInitiation")
any_extend_result1.defaultProps = {
    size = UDim2.new(1, 0, 1, 0);
    position = UDim2.new(0, 0, 0, 0);
    aspectRatio = 6;
    displayName = "TWENTYMOREMINUTES";
}
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function any_extend_result1.init(arg1) -- Line 17
    arg1:setState({
        remaining = 0;
        createdAt = workspace:GetServerTimeNow();
    })
    function arg1.onAccept() -- Line 22
        arg1.props.onAccept(arg1.props.index)
    end
    function arg1.onDecline() -- Line 25
        arg1.props.onDecline(arg1.props.index)
    end
    arg1.maid = Maid_upvr.new()
end
local createElement_upvr = Roact_upvr.createElement
local TradeButton_upvr = require(script.Parent.TradeButton)
function any_extend_result1.render(arg1) -- Line 30
    local aspectRatio = arg1.props.aspectRatio
    local isTradingVIP = arg1.props.isTradingVIP
    local var14
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var14 = var14.VIP_INITIATION_COLOR
        var14 = TradeConsts_upvr
        return var14
    end
    if not isTradingVIP or not decompInlinedCondition() then
        var14 = Color3.new(1, 1, 1)
    end
    local module = {
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
                TextColor3 = var14;
                Text = arg1.props.displayName.." wants to trade!";
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
            text = "Trade";
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
    }
    if isTradingVIP then
        module.UIStroke = createElement_upvr("UIStroke", {
            Transparency = 0.5;
            Thickness = 3;
            Color = TradeConsts_upvr.VIP_INITIATION_COLOR;
        })
    end
    return createElement_upvr("Frame", {
        BorderSizePixel = 0;
        BackgroundColor3 = Color3.new(0, 0, 0);
        BackgroundTransparency = 0.5;
        Size = arg1.props.size;
        Position = arg1.props.position;
        AnchorPoint = arg1.props.anchorPoint;
    }, module)
end
function any_extend_result1._hookObj(arg1) -- Line 123
    arg1:setState({
        createdAt = arg1.props.obj:GetAttribute(TradeConsts_upvr.INITIATION_CREATED_AT_ATTR_NAME);
    })
    arg1.maid:GiveTask(arg1.props.obj:GetAttributeChangedSignal(TradeConsts_upvr.INITIATION_CREATED_AT_ATTR_NAME):Connect(function() -- Line 128
        arg1:setState({
            createdAt = arg1.props.obj:GetAttribute(TradeConsts_upvr.INITIATION_CREATED_AT_ATTR_NAME);
        })
    end))
end
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
function any_extend_result1.didMount(arg1) -- Line 135
    if arg1.props.obj then
        arg1:_hookObj()
    end
    local function update() -- Line 139
        local var32
        local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var32 = var32.VIP_INITIATION_TIMEOUT
            var32 = TradeConsts_upvr
            return var32
        end
        if not arg1.props.isTradingVIP or not decompInlinedCondition_2() then
            var32 = TradeConsts_upvr
            var32 = var32.INITIATION_TIMEOUT
        end
        arg1:setState({
            remaining = math.floor(math.max(0, (var32) - (workspace:GetServerTimeNow() - arg1.state.createdAt)));
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
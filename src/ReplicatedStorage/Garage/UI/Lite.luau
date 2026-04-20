local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact.PureComponent:extend("Lite")
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function any_extend_result1.init(arg1) -- Line 12
    arg1.maid = Maid_upvr.new()
    arg1:setState({
        remaining = 0;
    })
end
local createElement_upvr = Roact.createElement
local RoundButton_upvr = require(script.Parent.RoundButton)
function any_extend_result1.render(arg1) -- Line 18
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local mainRatio = arg1.props.mainRatio
    local paddingRatio = arg1.props.paddingRatio
    local cornerPixel = arg1.props.cornerPixel
    local var11
    if not arg1.props.upgraded then
        local var12 = not arg1.props.inPhysical
    end
    local maximum = math.max(arg1.state.remaining, 0)
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var11 = "%d:%02d COOLDOWN":format(math.floor(maximum / 60), maximum % 60)
        return var11
    end
    if 1 > maximum or not decompInlinedCondition() then
        var11 = "READY"
    end
    local module = {
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = mainRatio;
        });
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, cornerPixel);
        });
        UIStroke = createElement_upvr("UIStroke", {
            Color = Color3.new(1, 1, 1);
            Thickness = 1;
            Enabled = arg1.props.active;
        });
        Cooldown = createElement_upvr("Frame", {
            BackgroundTransparency = 0;
            BorderSizePixel = 0;
            BackgroundColor3 = Color3.fromRGB(32, 55, 158);
            Size = UDim2.new(1 - 2 / paddingRatio, 0, 0.15, 0);
            Position = UDim2.new(1 / paddingRatio, 0, mainRatio / paddingRatio, 0);
        }, {
            UICorner = createElement_upvr("UICorner", {
                CornerRadius = UDim.new(0, cornerPixel);
            });
            Title = createElement_upvr("TextLabel", {
                BackgroundTransparency = 1;
                Size = UDim2.new(0.9, 0, 1, 0);
                Position = UDim2.new(0.05, 0, 0, 0);
                AnchorPoint = Vector2.new(0, 0);
                Text = var11;
                Font = Enum.Font.Bangers;
                LineHeight = 0.95;
                TextScaled = true;
                TextColor3 = Color3.new(1, 1, 1);
                TextXAlignment = Enum.TextXAlignment.Center;
                TextYAlignment = Enum.TextYAlignment.Center;
            });
        });
    }
    local var23 = var12
    if var23 then
        var23 = createElement_upvr
        var23 = var23("TextLabel", {
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            TextColor3 = Color3.new(1, 1, 1);
            Size = UDim2.new(1 - 2 / paddingRatio, 0, 0.8 - 2 * mainRatio / paddingRatio - 0.15 - 2 * mainRatio / paddingRatio - mainRatio / paddingRatio, 0);
            Position = UDim2.new(1 / paddingRatio, 0, 0.15 + 2 * mainRatio / paddingRatio, 0);
            Text = "Upgrade to the Pro Garage to spawn and customize anything on the go!";
            TextScaled = true;
            Font = Enum.Font.LuckiestGuy;
        })
    end
    module.Message = var23
    var23 = var12
    local var25 = var23
    if var25 then
        var25 = createElement_upvr
        var25 = var25("ImageLabel", {
            BorderSizePixel = 0;
            BackgroundTransparency = 1;
            Size = UDim2.new(0.1 / mainRatio, 0, 0.1, 0);
            AnchorPoint = Vector2.new(0.5, 0);
            Position = UDim2.new(0.5, 0, 0.8 - 2 * mainRatio / paddingRatio, 0);
            Image = "rbxassetid://8715708824";
        })
    end
    module.Lock = var25
    var25 = var12
    local var27 = var25
    if var27 then
        var27 = createElement_upvr
        var27 = var27(RoundButton_upvr, {
            color = Color3.fromRGB(21, 33, 99);
            layoutOrder = 1;
            title = "UPGRADE";
            size = UDim2.new(1 - 2 / paddingRatio, 0, 0.1, 0);
            position = UDim2.new(1 / paddingRatio, 0, 0.9 - mainRatio / paddingRatio, 0);
            onClick = arg1.props.onRequestPremiumUpgrade;
        })
    end
    module.Upgrade = var27
    return createElement_upvr("Frame", {
        BorderSizePixel = 0;
        BackgroundTransparency = 0;
        BackgroundColor3 = Color3.fromRGB(55, 83, 255);
        Size = UDim2.new(1, 0, 1, 0);
        LayoutOrder = arg1.props.layoutOrder;
    }, module)
end
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
function any_extend_result1.didMount(arg1) -- Line 117
    arg1:setState({
        remaining = arg1.props.getRemainingDebounce();
    })
    arg1.maid:GiveTask(Interval_upvr.every(1):Connect(function() -- Line 121
        arg1:setState({
            remaining = arg1.props.getRemainingDebounce();
        })
    end))
end
function any_extend_result1.willUnmount(arg1) -- Line 127
    arg1.maid:DoCleaning()
end
return any_extend_result1
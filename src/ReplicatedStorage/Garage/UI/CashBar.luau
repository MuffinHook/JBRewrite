local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("CashBar")
any_extend_result1.defaultProps = {
    cash = 0;
}
local createElement_upvr = Roact_upvr.createElement
local String_upvr = require(ReplicatedStorage.Std.String)
function any_extend_result1.render(arg1) -- Line 11
    local mainRatio = arg1.props.mainRatio
    if not mainRatio then
        mainRatio = arg1.props
        mainRatio = mainRatio.aspectRatio
    end
    return createElement_upvr("Frame", {
        BackgroundTransparency = 1;
        Size = UDim2.new(1, 0, 1, 0);
    }, {
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = mainRatio * 5 / 9;
        });
        Left = createElement_upvr("Frame", {
            BackgroundTransparency = 0;
            BorderSizePixel = 0;
            BackgroundColor3 = Color3.fromRGB(134, 195, 81);
            Position = UDim2.new(0, 0, 0, 0);
            Size = UDim2.new(0.75, 0, 1, 0);
        }, {
            UICorner = createElement_upvr("UICorner", {
                CornerRadius = UDim.new(0.2, 0);
            });
        });
        Right = createElement_upvr("Frame", {
            BackgroundTransparency = 0;
            BorderSizePixel = 0;
            BackgroundColor3 = Color3.fromRGB(134, 195, 81);
            Position = UDim2.new(0.25, 0, 0, 0);
            Size = UDim2.new(0.75, 0, 1, 0);
        }, {
            UICorner = createElement_upvr("UICorner", {
                CornerRadius = UDim.new(1, 0);
            });
        });
        Title = createElement_upvr("TextLabel", {
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            Size = UDim2.new(0.7, 0, 0.5, 0);
            Position = UDim2.new((0.25) / (mainRatio * 5 / 7), 0, 0.5, 0);
            AnchorPoint = Vector2.new(0, 0.5);
            Text = string.format("YOUR CASH: $%s", String_upvr.comma(arg1.props.cash));
            Font = Enum.Font.LuckiestGuy;
            LineHeight = 0.7;
            TextScaled = true;
            TextXAlignment = Enum.TextXAlignment.Left;
            TextColor3 = Color3.new(0, 0, 0);
            ZIndex = 4;
        });
        BuyCash = createElement_upvr("TextButton", {
            Text = "";
            BackgroundColor3 = Color3.new(0.1, 0.1, 0.1);
            Size = UDim2.new(1, 0, 0.8, 0);
            AnchorPoint = Vector2.new(1, 0.5);
            Position = UDim2.new(1 - (0.12499999999999997) / (mainRatio * 5 / 7), 0, 0.5, 0);
            ZIndex = 5;
            [Roact_upvr.Event.Activated] = arg1.props.promptCashPurchase;
        }, {
            AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
                AspectRatio = 5.5;
            });
            UICorner = createElement_upvr("UICorner", {
                CornerRadius = UDim.new(1, 0);
            });
            Title = createElement_upvr("TextLabel", {
                BackgroundTransparency = 1;
                Size = UDim2.new(0.8, 0, 0.8, 0);
                Position = UDim2.new(0.5, 0, 0.5, 0);
                AnchorPoint = Vector2.new(0.5, 0.5);
                Text = "BUY CASH?";
                Font = Enum.Font.LuckiestGuy;
                LineHeight = 0.7;
                TextScaled = true;
                TextColor3 = Color3.new(1, 1, 1);
                ZIndex = 4;
            });
        });
    })
end
return any_extend_result1
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local createElement_upvr = Roact_upvr.createElement
local String_upvr = require(ReplicatedStorage.Std.String)
return function(arg1) -- Line 6
    local module = {}
    local var7
    if arg1.policyCashAvailable then
        var7 = createElement_upvr
        var7 = var7("Frame", {
            Size = UDim2.new(0.2, 0, 1, 0);
            AnchorPoint = Vector2.new(1, 0);
            Position = UDim2.new(0.7 - 2 / arg1.verticalPaddingRatio / arg1.aspectRatio, 0, 0, 0);
            BackgroundColor3 = Color3.fromRGB(134, 195, 81);
        }, {
            UICorner = createElement_upvr("UICorner", {
                CornerRadius = UDim.new(0, 4);
            });
            Text = createElement_upvr("TextLabel", {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 0.9, 0);
                Position = UDim2.new(0.5, 0, 0.5, 0);
                AnchorPoint = Vector2.new(0.5, 0.5);
                Text = string.format("$%s", String_upvr.comma(arg1.policyCashAvailable));
                TextXAlignment = Enum.TextXAlignment.Center;
                Font = Enum.Font.Bangers;
                LineHeight = 1;
                TextScaled = true;
                TextColor3 = Color3.new(0, 0, 0);
            });
        })
    else
        var7 = nil
    end
    module.PolicyCashAvailableBar = var7
    var7 = createElement_upvr
    var7 = var7("TextButton", {
        Size = UDim2.new(0.2, 0, 1, 0);
        AnchorPoint = Vector2.new(1, 0);
        Position = UDim2.new(0.9 - 1 / arg1.verticalPaddingRatio / arg1.aspectRatio, 0, 0, 0);
        BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        Text = "";
        [Roact_upvr.Event.Activated] = arg1.onSelectToggle;
    }, {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 4);
        });
        Text = createElement_upvr("TextLabel", {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, 0, 0.9, 0);
            Position = UDim2.new(0.5, 0, 0.5, 0);
            AnchorPoint = Vector2.new(0.5, 0.5);
            Text = arg1.nextPageTitle;
            TextXAlignment = Enum.TextXAlignment.Center;
            Font = Enum.Font.Bangers;
            LineHeight = 1;
            TextScaled = true;
            TextColor3 = Color3.new(0, 0, 0);
        });
    })
    module.ToggleButton = var7
    var7 = createElement_upvr
    var7 = var7("TextButton", {
        Size = UDim2.new(0.1, 0, 1, 0);
        AnchorPoint = Vector2.new(1, 0);
        Position = UDim2.new(1, 0, 0, 0);
        BackgroundColor3 = Color3.fromRGB(255, 38, 0);
        Text = "";
        [Roact_upvr.Event.Activated] = arg1.onSelectExit;
    }, {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 4);
        });
        Text = createElement_upvr("TextLabel", {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, 0, 0.9, 0);
            Position = UDim2.new(0.5, 0, 0.5, 0);
            AnchorPoint = Vector2.new(0.5, 0.5);
            Text = "EXIT";
            TextXAlignment = Enum.TextXAlignment.Center;
            Font = Enum.Font.Bangers;
            LineHeight = 1;
            TextScaled = true;
            TextColor3 = Color3.new(1, 1, 1);
        });
    })
    module.ExitButton = var7
    return Roact_upvr.createFragment(module)
end
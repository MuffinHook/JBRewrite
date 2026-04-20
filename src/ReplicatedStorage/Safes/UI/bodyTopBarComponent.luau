local createElement_upvr = require(game:GetService("ReplicatedStorage").Roact).createElement
return function(arg1) -- Line 5
    return createElement_upvr("Frame", {
        Size = UDim2.new(1, 0, 0.1, 0);
        BackgroundTransparency = 1;
        ZIndex = 3;
    }, {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 4);
        });
        Title = createElement_upvr("Frame", {
            BorderSizePixel = 0;
            BackgroundTransparency = 1;
            BackgroundColor3 = Color3.new(1, 0, 0);
            Size = UDim2.new(1 - 2 / arg1.verticalPaddingRatio / arg1.aspectRatio, 0, 0.8 - 2 / arg1.verticalPaddingRatio / 0.1, 0);
            Position = UDim2.new(1 / arg1.verticalPaddingRatio / arg1.aspectRatio, 0, 0.1 + 1 / arg1.verticalPaddingRatio / 0.1, 0);
        }, {
            Text = createElement_upvr("TextLabel", {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 1.25, 0);
                Position = UDim2.new(0.5, 0, 0.5, 0);
                AnchorPoint = Vector2.new(0.5, 0.5);
                Text = "Win one of these items:";
                TextXAlignment = Enum.TextXAlignment.Left;
                Font = Enum.Font.Bangers;
                LineHeight = 1;
                TextScaled = true;
                TextColor3 = Color3.new(1, 1, 1);
            });
        });
        Line = createElement_upvr("Frame", {
            Size = UDim2.new(1, 0, 0, 1);
            Position = UDim2.new(0, 0, 1, -1);
            BackgroundColor3 = Color3.new(0.1, 0.1, 0.1);
            BorderSizePixel = 0;
        });
    })
end
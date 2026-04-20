local Roact = require(game:GetService("ReplicatedStorage").Roact)
local any_extend_result1 = Roact.PureComponent:extend("BoardEntry")
local createElement_upvr = Roact.createElement
function any_extend_result1.render(arg1) -- Line 6
    return createElement_upvr("Frame", {
        BackgroundTransparency = 1;
        Size = UDim2.new(1, 0, 1, 0);
        LayoutOrder = arg1.props.rank;
    }, {
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 8;
        });
        Background = createElement_upvr("Frame", {
            BackgroundTransparency = 0;
            Size = UDim2.new(1, 0, 1, 0);
            BackgroundColor3 = Color3.fromRGB(2, 227, 248);
            BorderColor3 = Color3.new(1, 1, 1);
            BorderMode = Enum.BorderMode.Inset;
            BorderSizePixel = 4;
        });
        Content = createElement_upvr("Frame", {
            Size = UDim2.new(1, 0, 1, 0);
            BackgroundTransparency = 1;
            ZIndex = 2;
        }, {
            ListLayout = createElement_upvr("UIListLayout", {
                HorizontalAlignment = Enum.HorizontalAlignment.Left;
                VerticalAlignment = Enum.VerticalAlignment.Center;
                SortOrder = Enum.SortOrder.LayoutOrder;
                FillDirection = Enum.FillDirection.Horizontal;
            });
            Number = createElement_upvr("Frame", {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 1, 0);
                LayoutOrder = 1;
            }, {
                Label = createElement_upvr("TextLabel", {
                    BackgroundTransparency = 1;
                    Size = UDim2.new(0.8, 0, 0.8, 0);
                    AnchorPoint = Vector2.new(0.5, 0.5);
                    Position = UDim2.new(0.5, 0, 0.65, 0);
                    Text = "#%d":format(arg1.props.rank);
                    TextColor3 = Color3.new(1, 1, 1);
                    Font = Enum.Font.LuckiestGuy;
                    TextScaled = true;
                });
                AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
                    AspectRatio = 1;
                });
            });
            Icon = createElement_upvr("Frame", {
                LayoutOrder = 2;
                Size = UDim2.new(1, 0, 1, 0);
                BackgroundTransparency = 1;
            }, {
                AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
                    AspectRatio = 1;
                });
                Image = createElement_upvr("ImageLabel", {
                    BackgroundTransparency = 1;
                    AnchorPoint = Vector2.new(0.5, 0.5);
                    Position = UDim2.new(0.5, 0, 0.5, 0);
                    Size = UDim2.new(0.8, 0, 0.8, 0);
                    Image = "rbxthumb://type=AvatarHeadShot&w=150&h=150&id=%d":format(arg1.props.userId);
                });
            });
            Stats = createElement_upvr("Frame", {
                LayoutOrder = 3;
                Size = UDim2.new(1, 0, 1, 0);
                BackgroundTransparency = 1;
            }, {
                AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
                    AspectRatio = 6;
                });
                Title = createElement_upvr("TextLabel", {
                    BackgroundTransparency = 1;
                    Size = UDim2.new(1, 0, 0.5, 0);
                    Position = UDim2.new(0, 0, 0.1, 0);
                    Text = arg1.props.name;
                    TextColor3 = Color3.new(0.15, 0.15, 0.15);
                    Font = Enum.Font.LuckiestGuy;
                    TextScaled = true;
                });
                Message = createElement_upvr("TextLabel", {
                    BackgroundTransparency = 1;
                    Size = UDim2.new(1, 0, 0.4, 0);
                    Position = UDim2.new(0, 0, 0.6, 0);
                    Text = arg1.props.message;
                    TextColor3 = Color3.new(1, 1, 1);
                    Font = Enum.Font.LuckiestGuy;
                    TextScaled = true;
                });
            });
        });
    })
end
return any_extend_result1
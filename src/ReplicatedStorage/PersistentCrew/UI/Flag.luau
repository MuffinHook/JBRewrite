local Roact = require(game:GetService("ReplicatedStorage").Roact)
local any_extend_result1 = Roact.PureComponent:extend("Flag")
any_extend_result1.defaultProps = {
    flagColor = Color3.new(1, 1, 1);
    userId = 1;
    size = UDim2.fromScale(1, 1);
    position = UDim2.fromScale(0.5, 0.5);
    anchorPoint = Vector2.new(0.5, 0.5);
}
local createElement_upvr = Roact.createElement
function any_extend_result1.render(arg1) -- Line 13
    return createElement_upvr("Frame", {
        BorderSizePixel = 0;
        BackgroundColor3 = arg1.props.flagColor;
        Size = arg1.props.size;
        AnchorPoint = arg1.props.anchorPoint;
        Position = arg1.props.position;
    }, {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 4);
        });
        FlagBg = createElement_upvr("ImageLabel", {
            BackgroundTransparency = 1;
            Image = "rbxassetid://12385250525";
            Size = UDim2.fromScale(1, 1);
            ImageColor3 = arg1.props.flagColor;
        }, {
            UICorner = createElement_upvr("UICorner", {
                CornerRadius = UDim.new(0, 4);
            });
        });
        Avatar = createElement_upvr("ImageLabel", {
            BackgroundTransparency = 1;
            Image = "rbxthumb://type=AvatarHeadShot&w=150&h=150&id="..(arg1.props.userId or 1);
            Size = UDim2.fromScale(1, 0.9);
            Position = UDim2.fromScale(0, 0);
            AnchorPoint = Vector2.new(0, 0);
            ZIndex = 3;
        }, {
            UIAspectRatioConstraint = createElement_upvr("UIAspectRatioConstraint", {
                AspectRatio = 1;
                AspectType = Enum.AspectType.FitWithinMaxSize;
                DominantAxis = Enum.DominantAxis.Height;
            });
            UICorner = createElement_upvr("UICorner", {
                CornerRadius = UDim.new(1, 0);
            });
        });
    })
end
return any_extend_result1
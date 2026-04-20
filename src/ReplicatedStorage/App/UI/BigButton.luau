local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("BigButton")
any_extend_result1.defaultProps = {
    color = Color3.new(1, 0, 0);
    size = UDim2.new(1, 0, 1, 0);
    imageScale = 1;
}
local createElement_upvr = Roact_upvr.createElement
function any_extend_result1.render(arg1) -- Line 11
    local module = {
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 1;
        });
    }
    if arg1.props.imageId then
        module.Icon = createElement_upvr("ImageLabel", {
            BackgroundTransparency = 1;
            Size = UDim2.new(1 * arg1.props.imageScale, 0, 1 * arg1.props.imageScale, 0);
            Image = string.format("rbxassetid://%d", arg1.props.imageId);
            AnchorPoint = Vector2.new(0.5, 0.5);
            Position = UDim2.new(0.5, 0, 0.5, 0);
        })
    end
    if arg1.props.count then
        module.ContainerCount = createElement_upvr("ImageLabel", {
            BackgroundTransparency = 1;
            Image = "rbxassetid://4915102010";
            Position = UDim2.new(0.125, 0, 0, 0);
            Size = UDim2.new(0.75, 0, 1, 0);
        }, {
            AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
                AspectRatio = 3;
            });
            Label = createElement_upvr("TextLabel", {
                BackgroundTransparency = 1;
                Font = Enum.Font.SourceSansBold;
                Text = arg1.props.count;
                Size = UDim2.new(1, 0, 1, 0);
                TextScaled = true;
                TextColor3 = Color3.new(1, 1, 1);
            });
        })
    end
    return createElement_upvr("ImageButton", {
        Size = arg1.props.size;
        AnchorPoint = Vector2.new(0.5, 0.5);
        Position = UDim2.new(0.5, 0, 0.5, 0);
        BackgroundTransparency = 1;
        Image = "rbxassetid://4876179727";
        ImageColor3 = arg1.props.color;
        Visible = arg1.props.enabled;
        LayoutOrder = arg1.props.displayOrder;
        [Roact_upvr.Ref] = arg1.props.ref;
        [Roact_upvr.Event.MouseButton1Down] = arg1.props.onClick;
    }, module)
end
return any_extend_result1

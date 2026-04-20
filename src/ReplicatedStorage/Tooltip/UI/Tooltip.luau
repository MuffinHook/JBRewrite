local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact.PureComponent:extend("Tooltip")
any_extend_result1.defaultProps = {
    size = UDim2.fromScale(0.75, 0.05);
    anchorPoint = Vector2.new(0.5, 0);
    position = UDim2.fromScale(0.5, 0);
}
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function any_extend_result1.init(arg1) -- Line 13
    arg1.maid = Maid_upvr.new()
end
local createElement_upvr = Roact.createElement
function any_extend_result1.render(arg1) -- Line 16
    if not arg1.props.visible then return end
    return createElement_upvr("Frame", {
        BackgroundColor3 = Color3.new(0, 0, 0);
        BackgroundTransparency = 1;
        Size = arg1.props.size;
        AnchorPoint = arg1.props.anchorPoint;
        Position = arg1.props.position;
    }, {
        Text = createElement_upvr("TextLabel", {
            BackgroundTransparency = 1;
            Size = UDim2.fromScale(1, 1);
            Position = UDim2.fromScale(0.5, 0.5);
            AnchorPoint = Vector2.new(0.5, 0.5);
            Font = Enum.Font.FredokaOne;
            Text = arg1.props.text;
            TextColor3 = Color3.new(0.95, 0.95, 0.95);
            TextScaled = true;
        }, {
            Stroke = createElement_upvr("UIStroke", {
                Thickness = 1;
                Color = Color3.new(0.4, 0.4, 0.4);
                Transparency = 0.2;
            });
        });
    })
end
function any_extend_result1.willUnmount(arg1) -- Line 45
    arg1.maid:DoCleaning()
end
return any_extend_result1
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact.PureComponent:extend("Bounty")
any_extend_result1.defaultProps = {
    size = UDim2.new(1, 0, 1, 0);
}
local createElement_upvr = Roact.createElement
local Format_upvr = require(ReplicatedStorage.Module.Format)
function any_extend_result1.render(arg1) -- Line 11
    return createElement_upvr("Frame", {
        BackgroundTransparency = 1;
        Size = arg1.props.size;
        LayoutOrder = arg1.props.displayOrder;
        Visible = arg1.props.enabled;
    }, {
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 8;
        });
        Label = createElement_upvr("TextLabel", {
            BackgroundTransparency = 1;
            Font = Enum.Font.LuckiestGuy;
            Text = "Bounty: %s":format(Format_upvr.Currency(arg1.props.amount));
            TextColor3 = Color3.new(0.8, 0, 0);
            TextStrokeColor3 = Color3.new(0.3, 0, 0);
            TextStrokeTransparency = 0.5;
            Size = UDim2.new(1, 0, 1, 0);
            Position = UDim2.new(0, 0, 0.15, 0);
            TextScaled = true;
        });
    })
end
return any_extend_result1
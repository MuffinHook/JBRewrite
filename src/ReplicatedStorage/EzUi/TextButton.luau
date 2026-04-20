local Roact_upvr = require(script:FindFirstAncestor("EzUi").Parent.Roact)
local any_extend_result1 = Roact_upvr.Component:extend("TextButton")
any_extend_result1.defaultProps = {
    backgroundColor = Color3.new(1, 1, 1);
    textColor = Color3.new(0, 0, 0);
    borderSize = 0;
    borderColor = Color3.new(0, 0, 0);
}
local createElement_upvr = Roact_upvr.createElement
function any_extend_result1.render(arg1) -- Line 15
    return createElement_upvr("TextButton", {
        AnchorPoint = arg1.props.anchorPoint;
        BorderSizePixel = arg1.props.borderSize;
        BorderColor3 = arg1.props.borderColor;
        BackgroundColor3 = arg1.props.backgroundColor;
        Text = arg1.props.text;
        TextColor3 = arg1.props.textColor;
        Size = arg1.props.size;
        Font = Enum.Font.SourceSansBold;
        TextScaled = true;
        Position = arg1.props.position;
        LayoutOrder = arg1.props.layoutOrder;
        Visible = arg1.props.visible;
        [Roact_upvr.Event.Activated] = arg1.props.onClick;
    }, arg1.props[Roact_upvr.Children])
end
return any_extend_result1
local Roact_upvr = require(script:FindFirstAncestor("EzUi").Parent.Roact)
local any_extend_result1 = Roact_upvr.Component:extend("TextBox")
any_extend_result1.defaultProps = {
    backgroundColor = Color3.new(1, 1, 1);
    textColor = Color3.new(0, 0, 0);
    borderSize = 0;
    borderColor = Color3.new(0, 0, 0);
    backgroundTransparency = 0;
}
local createElement_upvr = Roact_upvr.createElement
function any_extend_result1.render(arg1) -- Line 16
    return createElement_upvr("TextBox", {
        BorderSizePixel = arg1.props.borderSize;
        BorderColor3 = arg1.props.borderColor;
        BackgroundTransparency = arg1.props.backgroundTransparency;
        BackgroundColor3 = arg1.props.backgroundColor;
        Text = arg1.props.text;
        TextColor3 = arg1.props.textColor;
        Size = arg1.props.size;
        Position = arg1.props.position;
        LayoutOrder = arg1.props.layoutOrder;
        [Roact_upvr.Event.FocusLost] = arg1.props.onFocusLost;
    })
end
return any_extend_result1
local Roact_upvr = require(script:FindFirstAncestor("EzUi").Parent.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("TabPage")
function any_extend_result1.init(arg1) -- Line 8
end
local createElement_upvr = Roact_upvr.createElement
function any_extend_result1.render(arg1) -- Line 9
    return createElement_upvr("Frame", {
        Size = UDim2.new(1, 0, 1, 0);
        BorderSizePixel = 0;
        BackgroundTransparency = arg1.props.backgroundTransparency;
        BackgroundColor3 = arg1.props.backgroundColor;
        LayoutOrder = arg1.props.layoutOrder;
        [Roact_upvr.Ref] = arg1.props[Roact_upvr.Ref];
    }, arg1.props[Roact_upvr.Children])
end
return any_extend_result1
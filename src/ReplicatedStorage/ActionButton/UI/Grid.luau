local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement_upvr = Roact.createElement
local any_extend_result1 = Roact.PureComponent:extend("Grid")
any_extend_result1.defaultProps = {
    color = Color3.new(1, 0, 0);
}
local makeButton_upvr = require(script.Parent.makeButton)
function any_extend_result1._makeButton(arg1, arg2, arg3, arg4) -- Line 14
    local module = {
        BackgroundTransparency = 1;
        Size = UDim2.new(1, 0, 1, 0);
    }
    module.LayoutOrder = arg4
    return createElement_upvr("Frame", module, {
        Button = makeButton_upvr(arg1.props, arg2, arg3, 1, UDim2.new(0.9, 0, 0.9, 0), UDim2.new(0.5, 0, 0.5, 0));
    })
end
local Dictionary_upvr = require(ReplicatedStorage.EzUi.Dictionary)
function any_extend_result1.render(arg1) -- Line 27
    local module_2 = {}
    for i = 1, arg1.props.countInner do
        module_2[string.format("%s_%d", "inner", i)] = arg1:_makeButton("inner", i, i)
    end
    for i_2 = 1, arg1.props.countOuter do
        module_2[string.format("%s_%d", "outer", i_2)] = arg1:_makeButton("outer", i_2, i_2 + arg1.props.countInner)
    end
    return createElement_upvr("Frame", {
        Visible = arg1.props.enabled;
        BackgroundTransparency = 1;
        Size = arg1.props.size;
        Position = arg1.props.position;
        AnchorPoint = arg1.props.anchorPoint;
    }, Dictionary_upvr.merge({
        GridLayout = createElement_upvr("UIGridLayout", {
            CellSize = UDim2.new(0.5, 0, 1, 0);
            CellPadding = UDim2.new(0, 0, 0, 0);
            HorizontalAlignment = Enum.HorizontalAlignment.Right;
            VerticalAlignment = Enum.VerticalAlignment.Bottom;
            StartCorner = Enum.StartCorner.BottomRight;
            SortOrder = Enum.SortOrder.LayoutOrder;
        });
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 2;
        });
    }, module_2))
end
return any_extend_result1

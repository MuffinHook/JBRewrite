local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("TextButton")
any_extend_result1.defaultProps = {
    font = Enum.Font.FredokaOne;
    backgroundColor = Color3.new(1, 1, 1);
    borderSize = 0;
    borderColor = Color3.new(0, 0, 0);
    disabled = false;
    text = "";
    cornerRadius = 4;
}
local createElement_upvr = Roact_upvr.createElement
local ColorUtils_upvr = require(ReplicatedStorage.Std.ColorUtils)
function any_extend_result1.render(arg1) -- Line 18
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var7
    if not var7 then
        var7 = {}
    end
    if arg1.props.aspectRatio then
        var7.AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = arg1.props.aspectRatio;
        })
    end
    if arg1.props.disabled then
        local any_brightenBy_result1 = ColorUtils_upvr.brightenBy(arg1.props.backgroundColor, -0.5)
    else
    end
    if arg1.props.text then
        var7.Text = createElement_upvr("TextLabel", {
            BackgroundTransparency = 1;
            Size = UDim2.new(0.9, 0, 0.9, 0);
            Position = UDim2.new(0.5, 0, 0.5, 0);
            AnchorPoint = Vector2.new(0.5, 0.5);
            Text = arg1.props.text;
            LineHeight = 1;
            TextScaled = true;
            TextColor3 = arg1.props.textColor or ColorUtils_upvr.brightenBy(arg1.props.backgroundColor, -0.65);
            Font = arg1.props.font;
        })
    end
    if arg1.props.cornerRadius then
        var7.CornerRadius = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, arg1.props.cornerRadius);
        })
    end
    local module = {
        AnchorPoint = arg1.props.anchorPoint;
        BorderSizePixel = arg1.props.borderSize;
        BorderColor3 = arg1.props.borderColor;
    }
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    module.BackgroundColor3 = arg1.props.backgroundColor
    module.Text = ""
    module.Size = arg1.props.size
    module.TextScaled = true
    module.Position = arg1.props.position
    module.LayoutOrder = arg1.props.layoutOrder
    module.Visible = arg1.props.visible
    local disabled = arg1.props.disabled
    module.AutoButtonColor = not disabled
    if not arg1.props.disabled then
        disabled = arg1.props
        disabled = disabled.onClick
    else
        disabled = nil
    end
    module[Roact_upvr.Event.Activated] = disabled
    return createElement_upvr("TextButton", module, var7)
end
return any_extend_result1
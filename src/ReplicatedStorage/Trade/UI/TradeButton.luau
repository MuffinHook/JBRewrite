local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("TradeButton")
any_extend_result1.defaultProps = {
    layoutOrder = 1;
    backgroundColor = Color3.new(0.1, 0.1, 0.1);
    text = "Button";
    disabled = false;
    aspectRatio = 4;
    size = UDim2.new(1, 0, 1, 0);
    position = UDim2.new(0, 0, 0, 0);
    cornerPixel = 4;
    cornerScale = 0;
}
function any_extend_result1.init(arg1) -- Line 18
    function arg1.onActivated() -- Line 19
        if not arg1.props.disabled and arg1.props.onClick then
            arg1.props.onClick()
        end
    end
    function arg1.onMouseEnter() -- Line 26
        arg1:setState({
            hover = true;
        })
    end
    function arg1.onMouseLeave() -- Line 31
        arg1:setState({
            hover = false;
        })
    end
    function arg1.onMouseDown() -- Line 36
        arg1:setState({
            pressed = true;
        })
    end
    function arg1.onMouseUp() -- Line 41
        arg1:setState({
            pressed = false;
        })
    end
end
local ColorUtils_upvr = require(ReplicatedStorage.Std.ColorUtils)
local createElement_upvr = Roact_upvr.createElement
function any_extend_result1.render(arg1) -- Line 47
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local var16
    if arg1.props.disabled then
        var16 = ColorUtils_upvr.brightenBy(arg1.props.backgroundColor, -0.5)
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if arg1.state.pressed then
        var16 = ColorUtils_upvr.brightenBy(arg1.props.backgroundColor, -0.2)
    elseif arg1.state.hover then
        var16 = ColorUtils_upvr.brightenBy(arg1.props.backgroundColor, -0.15)
    end
    local module = {}
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        tbl.AspectRatio = arg1.props.aspectRatio
        local tbl = {}
        return createElement_upvr("UIAspectRatioConstraint", tbl)
    end
    if not arg1.props.aspectRatio or not decompInlinedCondition() then
    end
    module.AspectRatio = nil
    module.UICorner = createElement_upvr("UICorner", {
        CornerRadius = UDim.new(arg1.props.cornerScale, arg1.props.cornerPixel);
    })
    module.Title = createElement_upvr("Frame", {
        BackgroundTransparency = 1;
        BackgroundColor3 = Color3.new(1, 0, 0);
        Size = UDim2.new(1, 0, 1, 0);
        Position = UDim2.new(0, 0, 0, 0);
    }, {
        Text = createElement_upvr("TextLabel", {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, 0, 1, 0);
            Position = UDim2.new(0.5, 0, 0.5, 0);
            AnchorPoint = Vector2.new(0.5, 0.5);
            TextColor3 = Color3.new(1, 1, 1);
            Text = arg1.props.text;
            TextXAlignment = Enum.TextXAlignment.Center;
            Font = Enum.Font.Bangers;
            LineHeight = 1;
            TextScaled = true;
        });
    })
    do
        return createElement_upvr("TextButton", {
            AutoButtonColor = false;
            LayoutOrder = arg1.props.layoutOrder;
            BackgroundColor3 = var16;
            Size = arg1.props.size;
            Position = arg1.props.position;
            Text = "";
            BorderSizePixel = 0;
            [Roact_upvr.Event.Activated] = arg1.onActivated;
            [Roact_upvr.Event.MouseEnter] = arg1.onMouseEnter;
            [Roact_upvr.Event.MouseLeave] = arg1.onMouseLeave;
            [Roact_upvr.Event.SelectionGained] = arg1.onMouseEnter;
            [Roact_upvr.Event.SelectionLost] = arg1.onMouseLeave;
            [Roact_upvr.Event.MouseButton1Down] = arg1.onMouseDown;
            [Roact_upvr.Event.MouseButton1Up] = arg1.onMouseUp;
        }, module)
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
return any_extend_result1
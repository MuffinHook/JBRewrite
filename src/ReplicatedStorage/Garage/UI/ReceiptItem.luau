local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("ReceiptItem")
function any_extend_result1.init(arg1) -- Line 7
    arg1:setState({
        hover = false;
    })
end
local createElement_upvr = Roact_upvr.createElement
local String_upvr = require(ReplicatedStorage.Std.String)
function any_extend_result1.render(arg1) -- Line 12
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local mainRatio = arg1.props.mainRatio
    local var8
    if arg1.state.hover then
        var8 = 0.3
    else
        var8 = 0.25
    end
    local tbl = {}
    if arg1.state.hover then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    tbl.BackgroundTransparency = 1
    tbl.AutoButtonColor = false
    tbl.Text = ""
    tbl.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    tbl.BorderSizePixel = 0
    tbl.Size = UDim2.new(1, 0, 1, 0)
    tbl.LayoutOrder = arg1.props.layoutOrder
    tbl.Selectable = true
    tbl[Roact_upvr.Event.MouseEnter] = function() -- Line 30
        arg1:setState({
            hover = true;
        })
    end
    tbl[Roact_upvr.Event.MouseLeave] = function() -- Line 35
        arg1:setState({
            hover = false;
        })
    end
    tbl[Roact_upvr.Event.SelectionGained] = function() -- Line 40
        arg1:setState({
            hover = true;
        })
    end
    tbl[Roact_upvr.Event.SelectionLost] = function() -- Line 45
        arg1:setState({
            hover = false;
        })
    end
    tbl[Roact_upvr.Event.Activated] = arg1.props.onRequestRemove
    ;({}).AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
        AspectRatio = mainRatio;
    })
    local tbl_2 = {
        Size = UDim2.new(var8 / mainRatio, 0, var8, 0);
        AnchorPoint = Vector2.new(1, 0.5);
        Position = UDim2.new(1 - 1 / arg1.props.paddingRatio, 0, 0.5, 0);
    }
    if arg1.state.hover then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
return any_extend_result1
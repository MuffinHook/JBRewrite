local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("CategoryItem")
function any_extend_result1.init(arg1) -- Line 6
    arg1:setState({
        hover = false;
    })
end
local createElement_upvr = Roact_upvr.createElement
function any_extend_result1.render(arg1) -- Line 11
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local mainRatio = arg1.props.mainRatio
    local module = {}
    local var7
    if arg1.state.hover or arg1.props.selected then
        var7 = 0
    else
        var7 = 1
    end
    module.BackgroundTransparency = var7
    var7 = false
    module.AutoButtonColor = var7
    var7 = ""
    module.Text = var7
    if arg1.props.selected then
        var7 = Color3.fromRGB(98, 222, 253)
    else
        var7 = Color3.new(0.2, 0.2, 0.2)
    end
    module.BackgroundColor3 = var7
    var7 = 0
    module.BorderSizePixel = var7
    var7 = UDim2.new(1, 0, 1, 0)
    module.Size = var7
    var7 = arg1.props
    var7 = var7.layoutOrder
    module.LayoutOrder = var7
    var7 = true
    module.Selectable = var7
    var7 = Roact_upvr
    var7 = var7.Event
    var7 = var7.MouseEnter
    module[var7] = function() -- Line 26
        arg1:setState({
            hover = true;
        })
    end
    var7 = Roact_upvr
    var7 = var7.Event
    var7 = var7.MouseLeave
    module[var7] = function() -- Line 31
        arg1:setState({
            hover = false;
        })
    end
    var7 = Roact_upvr
    var7 = var7.Event
    var7 = var7.SelectionGained
    module[var7] = function() -- Line 36
        arg1:setState({
            hover = true;
        })
    end
    var7 = Roact_upvr
    var7 = var7.Event
    var7 = var7.SelectionLost
    module[var7] = function() -- Line 41
        arg1:setState({
            hover = false;
        })
    end
    var7 = Roact_upvr
    var7 = var7.Event
    var7 = var7.Activated
    module[var7] = arg1.props.onSelect
    var7 = {}
    var7.AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
        AspectRatio = mainRatio;
    })
    var7.UICorner = createElement_upvr("UICorner", {
        CornerRadius = UDim.new(0, arg1.props.cornerPixel);
    })
    local tbl = {
        BackgroundTransparency = 1;
        Size = UDim2.new(1 - 0.6 / mainRatio, 0, 0.4, 0);
        Position = UDim2.new(1 - 0.3 / mainRatio, 0, 0.3, 0);
        AnchorPoint = Vector2.new(1, 0);
        Text = arg1.props.title;
        Font = Enum.Font.LuckiestGuy;
        LineHeight = 0.7;
        TextScaled = true;
    }
    if not arg1.props.selected or not Color3.new(0, 0, 0) then
    end
    tbl.TextColor3 = Color3.new(1, 1, 1)
    tbl.TextXAlignment = Enum.TextXAlignment.Right
    tbl.TextYAlignment = Enum.TextYAlignment.Center
    var7.Title = createElement_upvr("TextLabel", tbl)
    return createElement_upvr("TextButton", module, var7)
end
return any_extend_result1
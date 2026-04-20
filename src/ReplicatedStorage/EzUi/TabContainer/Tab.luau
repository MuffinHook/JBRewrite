local EzUi = script:FindFirstAncestor("EzUi")
local Roact_upvr = require(EzUi.Parent.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("Tab")
function any_extend_result1.init(arg1) -- Line 9
    arg1:setState({
        hover = false;
    })
end
local ColorUtils_upvr = require(EzUi.Parent.Std.ColorUtils)
local createElement_upvr = Roact_upvr.createElement
function any_extend_result1.render(arg1) -- Line 14
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var7
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var7 = var7.backgroundColor
        var7 = arg1.props
        return var7
    end
    local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var7 = var7.brightenTo(arg1.props.backgroundColor, 0.4)
        var7 = ColorUtils_upvr
        return var7
    end
    if not arg1.props.active or not decompInlinedCondition() or not arg1.state.hover or not decompInlinedCondition_2() then
        var7 = ColorUtils_upvr
        var7 = var7.brightenTo(arg1.props.backgroundColor, 0.2)
    end
    local module = {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 6);
        });
    }
    local tbl = {
        BackgroundTransparency = 1;
        Size = UDim2.new(0.6, 0, 0.6, 0);
        Position = UDim2.new(0.2, 0, 0.2, 0);
        Text = arg1.props.title;
        Font = Enum.Font.LuckiestGuy;
        LineHeight = 0.7;
        TextScaled = true;
    }
    if not arg1.props.active or not Color3.new(1, 1, 1) then
    end
    tbl.TextColor3 = ColorUtils_upvr.saturateTo(ColorUtils_upvr.brightenBy(var7, 2), 0)
    module.Title = createElement_upvr("TextLabel", tbl)
    return createElement_upvr("TextButton", {
        Size = arg1.props.scaleXBinding:map(function(arg1_2) -- Line 20
            return UDim2.new(arg1_2, -arg1.props.paddingX, 1, 0)
        end);
        BorderSizePixel = 0;
        BackgroundTransparency = 0;
        BackgroundColor3 = var7;
        LayoutOrder = arg1.props.layoutOrder;
        Text = "";
        AutoButtonColor = false;
        [Roact_upvr.Event.MouseButton1Down] = arg1.props.onClick;
        [Roact_upvr.Event.MouseEnter] = function() -- Line 33
            arg1:setState({
                hover = true;
            })
        end;
        [Roact_upvr.Event.MouseLeave] = function() -- Line 38
            arg1:setState({
                hover = false;
            })
        end;
    }, module)
end
return any_extend_result1
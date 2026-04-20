local Roact_upvr = require(script:FindFirstAncestor("EzUi").Parent.Roact)
local any_extend_result1 = Roact_upvr.Component:extend("Checkbox")
any_extend_result1.defaultProps = {
    size = UDim2.new(0.5, 0, 0.5, 0);
    backgroundColor = Color3.new(0.8, 0.8, 0.8);
    checkColor = Color3.new(0, 0, 0);
    disabled = false;
}
local createElement_upvr = Roact_upvr.createElement
local Dictionary_upvr = require(script.Parent.Dictionary)
function any_extend_result1.render(arg1) -- Line 16
    local module = {
        Size = arg1.props.size;
        Position = arg1.props.position;
        LayoutOrder = arg1.props.layoutOrder;
    }
    local var7
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var7 = Color3.new(0, 0, 0)
        return var7
    end
    if not arg1.props.value or not decompInlinedCondition() then
        var7 = Color3.new(0.1, 0.1, 0.1)
    end
    module.BackgroundColor3 = var7
    var7 = {}
    local cornerRadius = arg1.props.cornerRadius
    if cornerRadius then
        cornerRadius = createElement_upvr
        cornerRadius = cornerRadius("UICorner", {
            CornerRadius = arg1.props.cornerRadius;
        })
    end
    var7.Corner = cornerRadius
    var7.AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
        AspectRatio = 1;
        DominantAxis = Enum.DominantAxis.Height;
    })
    local tbl = {
        AutoButtonColor = not arg1.props.disabled;
        Size = UDim2.fromScale(0.92, 0.92);
        AnchorPoint = Vector2.new(0.5, 0.5);
    }
    local var13 = 0.5
    tbl.Position = UDim2.fromScale(var13, 0.5)
    tbl.LayoutOrder = arg1.props.layoutOrder
    tbl.BackgroundColor3 = arg1.props.backgroundColor
    tbl.Selectable = true
    tbl.Text = ""
    if not arg1.props.disabled then
        function var13() -- Line 42
            if arg1.props.onChecked then
                arg1.props.onChecked(not arg1.props.value)
            end
        end
    else
        var13 = nil
    end
    tbl[Roact_upvr.Event.Activated] = var13
    local tbl_2 = {
        Check = createElement_upvr("ImageLabel", {
            Size = UDim2.new(1, 0, 1, 0);
            AnchorPoint = Vector2.new(0.5, 0.5);
            Position = UDim2.new(0.5, 0, 0.5, 0);
            BorderSizePixel = 0;
            BackgroundTransparency = 1;
            Image = "rbxassetid://8724615287";
            ImageColor3 = arg1.props.checkColor;
            Visible = arg1.props.value;
        });
    }
    local cornerRadius_2 = arg1.props.cornerRadius
    if cornerRadius_2 then
        cornerRadius_2 = createElement_upvr
        cornerRadius_2 = cornerRadius_2("UICorner", {
            CornerRadius = arg1.props.cornerRadius;
        })
    end
    tbl_2.Corner = cornerRadius_2
    var7.Checkbox = createElement_upvr("TextButton", tbl, Dictionary_upvr.merge(arg1.props[Roact_upvr.Children], tbl_2))
    return createElement_upvr("Frame", module, var7)
end
return any_extend_result1
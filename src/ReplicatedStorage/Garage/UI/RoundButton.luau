local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("RoundButton")
any_extend_result1.defaultProps = {
    size = UDim2.new(1, 0, 1, 0);
    disabled = false;
}
local createElement_upvr = Roact_upvr.createElement
local ColorUtils_upvr = require(ReplicatedStorage.Std.ColorUtils)
function any_extend_result1.render(arg1) -- Line 12
    local aspectRatio = arg1.props.aspectRatio
    local module = {
        AutoButtonColor = not arg1.props.disabled;
        Text = "";
        BackgroundTransparency = 0;
        BorderSizePixel = 0;
    }
    local var9
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var9 = var9.brightenTo(arg1.props.color, 0.1)
        var9 = ColorUtils_upvr
        return var9
    end
    if not arg1.props.disabled or not decompInlinedCondition() then
        var9 = arg1.props
        var9 = var9.color
    end
    module.BackgroundColor3 = var9
    var9 = arg1.props
    var9 = var9.position
    module.Position = var9
    var9 = arg1.props
    var9 = var9.anchorPoint
    module.AnchorPoint = var9
    var9 = arg1.props
    var9 = var9.size
    module.Size = var9
    var9 = arg1.props
    var9 = var9.layoutOrder
    module.LayoutOrder = var9
    var9 = Roact_upvr
    var9 = var9.Event
    var9 = var9.Activated
    module[var9] = arg1.props.onClick
    var9 = {}
    local var10 = false
    if arg1.props.aspectRatio ~= nil then
        var10 = createElement_upvr
        var10 = var10("UIAspectRatioConstraint", {
            AspectRatio = arg1.props.aspectRatio;
        })
    end
    var9.AspectRatio = var10
    var9.UICorner = createElement_upvr("UICorner", {
        CornerRadius = UDim.new(1, 0);
    })
    var9.Title = createElement_upvr("TextLabel", {
        BackgroundTransparency = 1;
        Size = UDim2.new(0.7, 0, 0.7, 0);
        Position = UDim2.new(0.5, 0, 0.5, 0);
        AnchorPoint = Vector2.new(0.5, 0.5);
        Text = arg1.props.title;
        Font = Enum.Font.Bangers;
        LineHeight = 0.9;
        TextScaled = true;
        TextColor3 = Color3.new(1, 1, 1);
    }, {
        UIStroke = createElement_upvr("UIStroke", {
            Color = Color3.new(0, 0, 0);
            Thickness = 1;
        });
    })
    local var16 = false
    if arg1.props.locked ~= nil then
        var16 = createElement_upvr
        local tbl = {
            BorderSizePixel = 0;
            BackgroundTransparency = 1;
            Size = UDim2.new(0.6 / aspectRatio, 0, 0.6, 0);
        }
        local udim2 = UDim2.new(0.2 / aspectRatio, 0, 0.2, 0)
        tbl.Position = udim2
        if arg1.props.locked then
            udim2 = "rbxassetid://8715708455"
        else
            udim2 = "rbxassetid://8715708824"
        end
        tbl.Image = udim2
        var16 = var16("ImageLabel", tbl)
    end
    var9.Lock = var16
    return createElement_upvr("TextButton", module, var9)
end
return any_extend_result1
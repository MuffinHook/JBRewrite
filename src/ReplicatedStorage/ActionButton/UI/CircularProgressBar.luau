local Roact = require(game:GetService("ReplicatedStorage").Roact)
local createElement_upvr = Roact.createElement
local function makeGradient_upvr(arg1, arg2, arg3) -- Line 5, Named "makeGradient"
    local module = {
        BackgroundTransparency = 1;
    }
    local var4 = 0.5
    module.Size = UDim2.fromScale(var4, 1)
    local var5
    if arg2 then
        var4 = 0
    else
        var4 = 0.5
    end
    module.Position = UDim2.fromScale(var4, 0)
    module.ClipsDescendants = true
    local module_2 = {}
    local tbl_2 = {
        BackgroundTransparency = 1;
        ImageTransparency = arg1.transparency;
        ImageColor3 = arg1.color;
    }
    var5 = 2
    tbl_2.Size = UDim2.fromScale(var5, 1)
    tbl_2.Image = "rbxasset://textures/ui/Controls/RadialFill.png"
    if arg2 then
        var5 = 0
    else
        var5 = -1
    end
    tbl_2.Position = UDim2.fromScale(var5, 0)
    local tbl = {}
    var5 = createElement_upvr
    var5 = var5("UIGradient", {
        Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.4999, 0), NumberSequenceKeypoint.new(0.5, 1), NumberSequenceKeypoint.new(1, 1)});
        Rotation = arg3:map(function(arg1_2) -- Line 28
            local var12 = 360
            local var13
            if var13 then
                var12 = 180
            else
                var12 = 0
            end
            if arg2 then
                var13 = 360
            else
                var13 = 180
            end
            return math.clamp(math.clamp(arg1_2 * 360, 0, var12), var12, var13)
        end);
    })
    tbl.Gradient = var5
    module_2.Image = createElement_upvr("ImageLabel", tbl_2, tbl)
    return createElement_upvr("Frame", module, module_2)
end
local any_extend_result1 = Roact.PureComponent:extend("CircularProgressBar")
any_extend_result1.defaultProps = {
    size = UDim2.fromScale(1, 1);
    position = UDim2.fromScale(0.5, 0.5);
    anchorPoint = Vector2.new(0.5, 0.5);
    transparency = 0;
    color = Color3.new(1, 1, 1);
    zIndex = 1;
}
function any_extend_result1.init(arg1) -- Line 46
end
function any_extend_result1.render(arg1) -- Line 47
    return createElement_upvr("Frame", {
        BackgroundTransparency = 1;
        Size = arg1.props.size;
        Position = arg1.props.position;
        AnchorPoint = arg1.props.anchorPoint;
        ZIndex = arg1.props.zIndex;
        Visible = arg1.props.visible;
    }, {
        UIAspectRatioConstraint = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 1;
        });
        Gradient1 = makeGradient_upvr(arg1.props, true, arg1.props.progressBinding);
        Gradient2 = makeGradient_upvr(arg1.props, false, arg1.props.progressBinding);
    })
end
return any_extend_result1
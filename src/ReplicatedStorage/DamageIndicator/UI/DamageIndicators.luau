local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local DamageIndicatorService_upvr = require(ReplicatedStorage.DamageIndicator.DamageIndicatorService)
local any_extend_result1 = Roact.PureComponent:extend("DamageIndicator")
any_extend_result1.defaultProps = {
    innerRadius = 0.5;
    size = UDim2.new(0.2, 0, 0.2, 0);
    anchorPoint = Vector2.new(0.5, 0.5);
    position = UDim2.new(0.5, 0, 0.5, 0);
}
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function any_extend_result1.init(arg1) -- Line 16
    arg1.maid = Maid_upvr.new()
end
local createElement_upvr = Roact.createElement
local Dictionary_upvr = require(ReplicatedStorage.Std.Dictionary)
function any_extend_result1.render(arg1) -- Line 19
    local module = {}
    for i = 1, #DamageIndicatorService_upvr.list do
        local var12 = DamageIndicatorService_upvr.list[i]
        module[i] = createElement_upvr("ImageLabel", {
            BackgroundTransparency = 1;
            Image = "rbxassetid://9482691774";
            Size = UDim2.new(0.7, 0, 0.2936241610738255, 0);
            ImageColor3 = var12.color;
            AnchorPoint = Vector2.new(0.5, 0.5);
            Position = var12.angle:map(function(arg1_2) -- Line 32
                return UDim2.new(0.5 + arg1.props.innerRadius * math.cos(arg1_2), 0, 0.5 + arg1.props.innerRadius * math.sin(arg1_2), 0)
            end);
            Rotation = var12.angle:map(function(arg1_3) -- Line 36
                return 180 * arg1_3 / math.pi + 90
            end);
            ImageTransparency = var12.transparency;
            ZIndex = i;
        })
    end
    return createElement_upvr("Frame", {
        BackgroundTransparency = 1;
        Size = arg1.props.size;
        AnchorPoint = arg1.props.anchorPoint;
        Position = arg1.props.position;
    }, Dictionary_upvr.merge({
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 1;
        });
    }, module))
end
function any_extend_result1.didMount(arg1) -- Line 58
    arg1.maid:GiveTask(DamageIndicatorService_upvr.onForceUpdate:Connect(function() -- Line 59
        arg1:setState({
            _c = math.random();
        })
    end))
end
return any_extend_result1
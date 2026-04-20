local Roact = require(game:GetService("ReplicatedStorage").Roact)
local any_extend_result1 = Roact.PureComponent:extend("CenterMessage")
function any_extend_result1.init(arg1) -- Line 6
end
local createElement_upvr = Roact.createElement
function any_extend_result1.render(arg1) -- Line 7
    return createElement_upvr("Frame", {
        BackgroundTransparency = 1;
        Size = UDim2.new(0.2, 0, 1, 0);
        Position = UDim2.new(0.5, 0, 0.4, 0);
        AnchorPoint = Vector2.new(0.5, 0.5);
        Visible = arg1.props.text:map(function(arg1_2) -- Line 13
            local var6
            if 0 >= #arg1_2 then
                var6 = false
            else
                var6 = true
            end
            return var6
        end);
    }, {
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 2;
        });
        Time = createElement_upvr("TextLabel", {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, 0, 1, 0);
            Position = UDim2.new(0, 0, -0.1, 0);
            Font = Enum.Font.LuckiestGuy;
            TextScaled = true;
            TextColor3 = Color3.fromRGB(252, 40, 47);
            TextStrokeColor3 = Color3.fromRGB(202, 0, 0);
            TextStrokeTransparency = 0.5;
            Text = arg1.props.text;
        });
    })
end
function any_extend_result1.willUnmount(arg1) -- Line 33
end
return any_extend_result1
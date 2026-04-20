local Roact = require(game:GetService("ReplicatedStorage").Roact)
local any_extend_result1 = Roact.PureComponent:extend("Avatar")
function any_extend_result1.init(arg1) -- Line 6
end
local createElement_upvr = Roact.createElement
function any_extend_result1.render(arg1) -- Line 7
    local module = {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(1, 0);
        });
    }
    local isFriend = arg1.props.isFriend
    if isFriend then
        isFriend = createElement_upvr
        isFriend = isFriend("UIStroke", {
            Thickness = 1;
            Color = Color3.fromHex("5cc76d");
        })
    end
    module.UIStroke = isFriend
    module.UIAspectRatio = createElement_upvr("UIAspectRatioConstraint", {
        AspectRatio = 1;
    })
    return createElement_upvr("ImageLabel", {
        Position = arg1.props.position;
        BorderSizePixel = 0;
        BackgroundColor3 = Color3.new(0.7, 0.7, 0.7);
        BackgroundTransparency = 0;
        Image = "rbxthumb://type=AvatarHeadShot&w=150&h=150&id="..tostring(arg1.props.userId);
        Size = arg1.props.size;
    }, module)
end
return any_extend_result1
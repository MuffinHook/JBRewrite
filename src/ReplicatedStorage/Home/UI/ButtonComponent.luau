local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local createElement_upvr = Roact_upvr.createElement
local ColorUtils_upvr = require(ReplicatedStorage.Std.ColorUtils)
return function(arg1) -- Line 6, Named "buttonComponent"
    local cornerRadius = arg1.cornerRadius
    local module = {}
    local var8 = cornerRadius
    if var8 then
        var8 = createElement_upvr
        var8 = var8("UICorner", {
            CornerRadius = cornerRadius;
        })
    end
    module.Corner = var8
    module.Title = createElement_upvr("TextLabel", {
        BackgroundTransparency = 1;
        Size = UDim2.fromScale(1, 1);
        Text = arg1.title;
        Font = Enum.Font.Bangers;
        LineHeight = 1;
        TextScaled = true;
        TextXAlignment = Enum.TextXAlignment.Center;
        TextYAlignment = Enum.TextYAlignment.Center;
        TextColor3 = ColorUtils_upvr.saturateBy(arg1.backgroundColor, -0.7);
    }, {
        Stroke = createElement_upvr("UIStroke", {
            Color = Color3.new(0, 0, 0);
            Thickness = 1;
        });
    })
    return createElement_upvr("TextButton", {
        BackgroundColor3 = arg1.backgroundColor;
        Size = arg1.size;
        Position = arg1.position;
        AnchorPoint = arg1.anchorPoint;
        Text = "";
        Selectable = true;
        [Roact_upvr.Event.Activated] = arg1.onClick;
    }, module)
end
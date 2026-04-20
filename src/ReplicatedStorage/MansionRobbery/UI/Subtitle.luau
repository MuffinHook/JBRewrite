local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("Subtitle")
any_extend_result1.defaultProps = {
    charPerSecond = 25;
    fontFace = Font.fromName("Merriweather", Enum.FontWeight.Heavy, Enum.FontStyle.Normal);
}
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function any_extend_result1.init(arg1) -- Line 12
    arg1.maid = Maid_upvr.new()
    arg1.labelRef = Roact_upvr.createRef()
end
local createElement_upvr = Roact_upvr.createElement
function any_extend_result1.render(arg1) -- Line 16
    return createElement_upvr("Frame", {
        Size = UDim2.new(1, 0, 1, 0);
        BackgroundTransparency = 1;
    }, {
        Label = createElement_upvr("TextLabel", {
            BackgroundTransparency = 1;
            Size = UDim2.new(0.8, 0, 0.1, 0);
            AnchorPoint = Vector2.new(0.5, 1);
            Position = UDim2.new(0.5, 0, 0.8, 0);
            Text = "";
            TextStrokeTransparency = 0.8;
            TextStrokeColor3 = Color3.new(0, 0, 0);
            FontFace = arg1.props.fontFace;
            TextSize = 20;
            TextColor3 = Color3.new(1, 1, 1);
            TextWrapped = true;
            [Roact_upvr.Ref] = arg1.labelRef;
        });
    })
end
local TypeWriteLabel_upvr = require(ReplicatedStorage.Game.TypeWriteLabel)
function any_extend_result1._write(arg1) -- Line 37
    arg1.maid.typewrite = TypeWriteLabel_upvr(arg1.props.text, arg1.labelRef:getValue(), arg1.props.charPerSecond, arg1.props.maxVisibleGraphemeCallback)
end
function any_extend_result1.didMount(arg1) -- Line 45
    arg1:_write()
end
function any_extend_result1.didUpdate(arg1, arg2, arg3) -- Line 48
    if arg1.props.text ~= arg2.text then
        arg1:_write()
    end
end
function any_extend_result1.willUnmount(arg1) -- Line 53
    arg1.maid:DoCleaning()
end
return any_extend_result1
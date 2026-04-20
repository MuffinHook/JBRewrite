local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact.PureComponent:extend("Countdown")
any_extend_result1.defaultProps = {
    aspectRatio = 1;
    verticalPaddingRatio = 64;
    backgroundTransparency = 1;
    backgroundColor = Color3.new(0.1, 0.1, 0.1);
    size = UDim2.fromScale(1, 1);
    position = UDim2.fromScale(0.5, 0.5);
    anchorPoint = Vector2.new(0.5, 0.5);
    textColor = Color3.new(1, 1, 1);
    timeFormatFunc = function(arg1) -- Line 19, Named "timeFormatFunc"
        return arg1
    end;
    fontFace = Font.fromEnum(Enum.Font.GothamBold);
    prefix = "";
    suffix = "";
    zIndex = nil;
    strokeThickness = 0;
    strokeColor = Color3.new(0, 0, 0);
}
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function any_extend_result1.init(arg1) -- Line 30
    arg1.maid = Maid_upvr.new()
end
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
function any_extend_result1.didMount(arg1) -- Line 33
    arg1.maid:GiveTask(Interval_upvr.every(0.1):Connect(function() -- Line 34
        arg1:setState({
            _c = math.random();
        })
    end))
end
local createElement_upvr = Roact.createElement
local PaddedContainer_upvr = require(ReplicatedStorage.EzUi.PaddedContainer)
function any_extend_result1.render(arg1) -- Line 40
    local var11 = arg1.props.endTime - workspace:GetServerTimeNow()
    if var11 < 0 then
        var11 = 0
    end
    local module = {}
    local tbl = {}
    local var16 = false
    if 0 < arg1.props.strokeThickness then
        var16 = createElement_upvr
        var16 = var16("UIStroke", {
            Thickness = arg1.props.strokeThickness;
            Color = arg1.props.strokeColor;
        })
    end
    tbl.Stroke = var16
    module.Title = createElement_upvr("TextLabel", {
        BackgroundTransparency = 1;
        Size = UDim2.fromScale(1, 1.5);
        Text = arg1.props.prefix..tostring(arg1.props.timeFormatFunc(math.round(var11)))..arg1.props.suffix;
        TextColor3 = arg1.props.textColor;
        TextScaled = true;
        Position = UDim2.fromScale(0.5, 0.5);
        AnchorPoint = Vector2.new(0.5, 0.45);
        FontFace = arg1.props.fontFace;
        TextXAlignment = arg1.props.textXAlignment;
        TextYAlignment = arg1.props.textYAlignment;
    }, tbl)
    return createElement_upvr(PaddedContainer_upvr, {
        backgroundTransparency = arg1.props.backgroundTransparency;
        size = arg1.props.size;
        position = arg1.props.position;
        anchorPoint = arg1.props.anchorPoint;
        verticalPaddingRatio = arg1.props.verticalPaddingRatio;
        aspectRatio = arg1.props.aspectRatio;
        paddingRight = arg1.props.paddingRight;
        paddingLeft = arg1.props.paddingLeft;
        paddingTop = arg1.props.paddingTop;
        paddingBottom = arg1.props.paddingBottom;
        paddingNone = arg1.props.paddingNone;
        zIndex = arg1.props.zIndex;
    }, module)
end
function any_extend_result1.willUnmount(arg1) -- Line 81
    arg1.maid:Destroy()
end
return any_extend_result1
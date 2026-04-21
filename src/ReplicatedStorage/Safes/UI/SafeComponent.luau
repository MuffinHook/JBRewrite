local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("SafeComponent")
any_extend_result1.defaultProps = {
    static = false;
    selected = false;
    count = nil;
}
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local AccelTween_upvr = require(ReplicatedStorage.Std.AccelTween)
function any_extend_result1.init(arg1) -- Line 17
    arg1:setState({
        hover = false;
    })
    arg1.maid = Maid_upvr.new()
    local any_createBinding_result1, any_createBinding_result2 = Roact_upvr.createBinding(1)
    arg1.iconScale = any_createBinding_result1
    arg1.updateIconScale = any_createBinding_result2
    arg1.iconScaleAccelTween = AccelTween_upvr.new(1000)
    arg1.iconScaleAccelTween.p = arg1.iconScale:getValue()
end
local ColorUtils_upvr = require(ReplicatedStorage.Std.ColorUtils)
local createElement_upvr = Roact_upvr.createElement
local Dictionary_upvr = require(ReplicatedStorage.EzUi.Dictionary)
function any_extend_result1.render(arg1) -- Line 26
    local Color3_new_result1_2 = Color3.new(0.3, 0.3, 0.3)
    if not arg1.props.static and (arg1.state.hover or arg1.props.selected) then
        Color3_new_result1_2 = ColorUtils_upvr.brightenBy(Color3_new_result1_2, 0.5)
    end
    local module_2 = {
        Bubble = createElement_upvr("Frame", {
            BackgroundColor3 = Color3_new_result1_2;
            Size = UDim2.new(1 / arg1.props.aspectRatio, 0, 1, 0);
            AnchorPoint = Vector2.new(0.5, 0.5);
            Position = UDim2.new(0.5, 0, 0.5, 0);
        }, {
            UICorner = createElement_upvr("UICorner", {
                CornerRadius = UDim.new(1, 0);
            });
        });
    }
    local tbl_10 = {
        BorderSizePixel = 0;
        BackgroundTransparency = 1;
        Size = arg1.iconScale:map(function(arg1_3) -- Line 80
            return UDim2.new(0.8 * arg1_3 / arg1.props.aspectRatio, 0, 0.8 * arg1_3, 0)
        end);
        AnchorPoint = Vector2.new(0.5, 0.5);
    }
    local udim2_2 = UDim2.new(0.5, 0, 0.5, 0)
    tbl_10.Position = udim2_2
    if arg1.props.imageId then
        udim2_2 = string.format("rbxassetid://%d", arg1.props.imageId);
    else
        udim2_2 = nil
    end
    tbl_10.Image = udim2_2
    tbl_10.ZIndex = 3
    local tbl_16 = {}
    local count = arg1.props.count
    if count then
        count = false
        if 0 < arg1.props.count then
            count = createElement_upvr
            count = count("Frame", {
                BorderSizePixel = 0;
                BackgroundTransparency = 0;
                BackgroundColor3 = Color3.new(0.1, 0.1, 0.1);
                Size = UDim2.new(0.3, 0, 0.3, 0);
                Position = UDim2.new(0.85, 0, 0.15, 0);
                AnchorPoint = Vector2.new(0.5, 0.5);
                ZIndex = 4;
            }, {
                UICorner = createElement_upvr("UICorner", {
                    CornerRadius = UDim.new(1, 0);
                });
                Title = createElement_upvr("Frame", {
                    BackgroundTransparency = 1;
                    BackgroundColor3 = Color3.new(1, 0, 0);
                    Size = UDim2.new(1, 0, 1, 0);
                    Position = UDim2.new(0, 0, 0, 0);
                }, {
                    Text = createElement_upvr("TextLabel", {
                        BackgroundTransparency = 1;
                        Size = UDim2.new(1, 0, 0.6, 0);
                        Position = UDim2.new(0.5, 0, 0.5, 0);
                        AnchorPoint = Vector2.new(0.5, 0.5);
                        Text = arg1.props.count;
                        Font = Enum.Font.LuckiestGuy;
                        LineHeight = 0.7;
                        TextScaled = true;
                        TextColor3 = Color3.new(1, 1, 1);
                    });
                });
            })
        end
    end
    tbl_16.Count = count
    module_2.Icon = createElement_upvr("ImageLabel", tbl_10, tbl_16)
    return createElement_upvr("TextButton", {
        AutoButtonColor = false;
        Text = "";
        BackgroundTransparency = 1;
        BorderSizePixel = 0;
        Size = arg1.props.size;
        Position = arg1.props.position;
        LayoutOrder = arg1.props.layoutOrder;
        [Roact_upvr.Event.MouseEnter] = function() -- Line 44
            arg1:setState({
                hover = true;
            })
        end;
        [Roact_upvr.Event.MouseLeave] = function() -- Line 49
            arg1:setState({
                hover = false;
            })
        end;
        [Roact_upvr.Event.SelectionGained] = function() -- Line 54
            arg1:setState({
                hover = true;
            })
        end;
        [Roact_upvr.Event.SelectionLost] = function() -- Line 59
            arg1:setState({
                hover = false;
            })
        end;
        [Roact_upvr.Event.Activated] = arg1.props.onSelect;
    }, Dictionary_upvr.merge(arg1.props[Roact_upvr.Children], module_2))
end
local RunService_upvr = game:GetService("RunService")
function any_extend_result1._launchIconScaleUpdater(arg1) -- Line 123
    if arg1.props.static then
        arg1.updateIconScale(arg1.iconScaleAccelTween.t)
    else
        arg1.maid.iconScaleSpringUpdater = RunService_upvr.Heartbeat:Connect(function() -- Line 127
            arg1.updateIconScale(arg1.iconScaleAccelTween.p)
            if arg1.iconScaleAccelTween.rtime < 0.001 then
                arg1.maid.iconScaleSpringUpdater = nil
            end
        end)
    end
end
function any_extend_result1._recalculateIconScale(arg1) -- Line 136
    local var65
    if arg1.state.hover or arg1.props.selected then
        var65 = 1.2
    else
        var65 = 1
    end
    if arg1.iconScaleAccelTween.t ~= var65 then
        arg1.iconScaleAccelTween.t = var65
        arg1.updateIconScale(arg1.iconScaleAccelTween.p)
        arg1:_launchIconScaleUpdater()
    end
end
function any_extend_result1.didMount(arg1) -- Line 144
    arg1:_recalculateIconScale()
end
function any_extend_result1.didUpdate(arg1, arg2, arg3) -- Line 147
    if arg1.state.hover ~= arg3.hover or arg1.props.selected ~= arg2.selected then
        arg1:_recalculateIconScale()
    end
end
function any_extend_result1.willUnmount(arg1) -- Line 152
    arg1.maid:DoCleaning()
end
return any_extend_result1
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("ChooseSpawn")
any_extend_result1.defaultProps = {
    visible = false;
    mapScale = 1;
    bornAt = workspace:GetServerTimeNow();
    duration = 5;
    position = UDim2.new(0.5, 0, 0.5, 0);
    size = UDim2.new(0.25, 0, 0.25, 0);
}
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function any_extend_result1.init(arg1) -- Line 17
    arg1.maid = Maid_upvr.new()
    arg1:setState({
        remaining = arg1.props.duration;
    })
    function arg1.onSelect() -- Line 22
        arg1.props.onSelect()
        arg1.props.hide()
    end
end
local createElement_upvr = Roact_upvr.createElement
function any_extend_result1.render(arg1) -- Line 27
    if not arg1.props.visible then return end
    return createElement_upvr("Frame", {
        BorderSizePixel = 0;
        BackgroundTransparency = 1;
        Size = arg1.props.size;
        Position = arg1.props.position;
        AnchorPoint = Vector2.new(0.5, 0.5);
    }, {
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 6;
        });
        Left = createElement_upvr("Frame", {
            BorderSizePixel = 0;
            BackgroundTransparency = 1;
            Size = UDim2.new(0.16666666666666666, 0, 1, 0);
        }, {
            Inner = createElement_upvr("Frame", {
                Size = UDim2.new(0.9, 0, 0.9, 0);
                Position = UDim2.new(0.5, 0, 0.5, 0);
                AnchorPoint = Vector2.new(0.5, 0.5);
                BackgroundTransparency = 0;
                BackgroundColor3 = Color3.new(0.1, 0.1, 0.1);
            }, {
                UICorner = createElement_upvr("UICorner", {
                    CornerRadius = UDim.new(1, 0);
                });
                UIStroke = createElement_upvr("UIStroke", {
                    Color = Color3.new(0.2, 0.2, 0.2);
                    Thickness = 1;
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                });
                Text = createElement_upvr("TextLabel", {
                    BackgroundTransparency = 1;
                    Size = UDim2.new(0.9, 0, 0.9, 0);
                    Position = UDim2.new(0.5, 0, 0.5, 0);
                    AnchorPoint = Vector2.new(0.5, 0.5);
                    Text = tostring(arg1.state.remaining);
                    Font = Enum.Font.Bangers;
                    LineHeight = 1;
                    TextScaled = true;
                    TextColor3 = Color3.new(1, 1, 1);
                });
            });
        });
        Right = createElement_upvr("Frame", {
            BorderSizePixel = 0;
            BackgroundTransparency = 1;
            Position = UDim2.new(0.16666666666666666, 0, 0, 0);
            Size = UDim2.new(0.8333333333333334, 0, 1, 0);
        }, {
            Inner = createElement_upvr("TextButton", {
                Text = "";
                Size = UDim2.new(0.98, 0, 0.9, 0);
                Position = UDim2.new(0.5, 0, 0.5, 0);
                AnchorPoint = Vector2.new(0.5, 0.5);
                BackgroundTransparency = 0;
                BackgroundColor3 = Color3.new(0.1, 0.1, 0.1);
                Selectable = true;
                [Roact_upvr.Event.Activated] = arg1.onSelect;
            }, {
                UICorner = createElement_upvr("UICorner", {
                    CornerRadius = UDim.new(0.25, 0);
                });
                UIStroke = createElement_upvr("UIStroke", {
                    Color = Color3.new(1, 1, 1);
                    Thickness = 1;
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                });
                Title = createElement_upvr("Frame", {
                    BackgroundTransparency = 1;
                    BackgroundColor3 = Color3.new(1, 0, 0);
                    Size = UDim2.new(1, 0, 1, 0);
                    Position = UDim2.new(0, 0, 0, 0);
                }, {
                    Text = createElement_upvr("TextLabel", {
                        BackgroundTransparency = 1;
                        Size = UDim2.new(0.9, 0, 0.9, 0);
                        Position = UDim2.new(0.5, 0, 0.5, 0);
                        AnchorPoint = Vector2.new(0.5, 0.5);
                        Text = "Choose Spawn";
                        Font = Enum.Font.Bangers;
                        LineHeight = 1;
                        TextScaled = true;
                        TextColor3 = Color3.new(1, 1, 1);
                    });
                });
            });
        });
    })
end
function any_extend_result1.didUpdate(arg1, arg2, arg3) -- Line 121
    if arg2.duration ~= arg1.props.duration or arg2.bornAt ~= arg1.props.bornAt then
        arg1:_startTimer()
    end
end
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
function any_extend_result1._startTimer(arg1) -- Line 126
    local function update() -- Line 127
        local var29 = workspace:GetServerTimeNow() - arg1.props.bornAt
        local var30 = false
        if arg1.props.duration <= var29 then
            var30 = true
            arg1.maid.countdown = nil
        end
        arg1:setState({
            remaining = math.max(0, math.ceil(arg1.props.duration - var29));
        })
        if var30 then
            arg1.props.hide()
        end
    end
    update()
    arg1.maid.countdown = Interval_upvr.every(1):Connect(update)
end
function any_extend_result1.didMount(arg1) -- Line 145
    if arg1.props.visible then
        arg1:_startTimer()
    end
end
function any_extend_result1.willUnmount(arg1) -- Line 150
    arg1.maid:DoCleaning()
end
return require(ReplicatedStorage.RoactRodux).connect(function(arg1, arg2) -- Line 154
    return {
        bornAt = arg1.lastDiedAt;
        visible = arg1.spawnSelectionOfferVisible;
    }
end, function(arg1) -- Line 159
    return {
        hide = function() -- Line 161, Named "hide"
            arg1({
                type = "setSpawnSelectionOfferVisible";
                visible = false;
            })
        end;
    }
end)(any_extend_result1)
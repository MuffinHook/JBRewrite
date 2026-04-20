local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("LikePrompt")
any_extend_result1.defaultProps = {
    size = UDim2.fromScale(0.75, 0.05);
    anchorPoint = Vector2.new(0.5, 0);
    position = UDim2.fromScale(0.5, 0);
}
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function any_extend_result1.init(arg1) -- Line 14
    arg1.maid = Maid_upvr.new()
    arg1:setState({
        remaining = 0;
    })
end
local createElement_upvr = Roact_upvr.createElement
local PaddedContainer_upvr = require(ReplicatedStorage.EzUi.PaddedContainer)
function any_extend_result1.render(arg1) -- Line 20
    if not arg1.props.visible then return end
    return createElement_upvr("Frame", {
        BackgroundColor3 = Color3.new(0, 0, 0);
        BackgroundTransparency = 0;
        Size = arg1.props.size;
        AnchorPoint = arg1.props.anchorPoint;
        Position = arg1.props.position;
    }, {
        Corner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(1, 0);
        });
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 18;
        });
        Inner = createElement_upvr(PaddedContainer_upvr, {
            aspectRatio = 18;
            verticalPaddingRatio = 7.111111111111111;
            backgroundTransparency = 1;
        }, {
            TitleContainer = createElement_upvr(PaddedContainer_upvr, {
                backgroundTransparency = 1;
                size = UDim2.fromScale(0.7944444444444444, 1);
                paddingTop = 0;
                paddingBottom = 0;
                paddingLeft = 1;
                paddingRight = 0.5;
            }, {
                Text = createElement_upvr("TextLabel", {
                    BackgroundTransparency = 1;
                    Size = UDim2.fromScale(1, 0.9);
                    Position = UDim2.fromScale(0.5, 0.5);
                    AnchorPoint = Vector2.new(0.5, 0.5);
                    Font = Enum.Font.FredokaOne;
                    Text = "Enjoying Jailbreak? Please thumbs up our game!";
                    TextColor3 = Color3.new(1, 1, 1);
                    TextScaled = true;
                });
            });
            ButtonContainer = createElement_upvr(PaddedContainer_upvr, {
                backgroundTransparency = 1;
                size = UDim2.fromScale(0.15, 1);
                position = UDim2.fromScale(0.7944444444444444, 0);
                paddingTop = 0;
                paddingBottom = 0;
                paddingLeft = 0.5;
                paddingRight = 0;
            }, {
                Button = createElement_upvr("TextButton", {
                    BackgroundTransparency = 0;
                    Size = UDim2.fromScale(1, 1);
                    Text = "";
                    BackgroundColor3 = Color3.fromRGB(1, 255, 171);
                    Selectable = true;
                    [Roact_upvr.Event.Activated] = arg1.props.onClickDone;
                }, {
                    Corner = createElement_upvr("UICorner", {
                        CornerRadius = UDim.new(1, 0);
                    });
                    TitleContainer = createElement_upvr("Frame", {
                        BackgroundTransparency = 1;
                        Size = UDim2.fromScale(1, 1);
                    }, {
                        Text = createElement_upvr("TextLabel", {
                            BackgroundTransparency = 1;
                            Size = UDim2.fromScale(1, 1);
                            Position = UDim2.fromScale(0.5, 0.5);
                            AnchorPoint = Vector2.new(0.5, 0.5);
                            Font = Enum.Font.FredokaOne;
                            Text = "OK!";
                            TextColor3 = Color3.new(0, 0, 0);
                            TextScaled = true;
                        });
                    });
                });
            });
            CountdownContainer = createElement_upvr("Frame", {
                BackgroundTransparency = 1;
                Size = UDim2.fromScale(0.05555555555555555, 1);
                Position = UDim2.fromScale(0.9444444444444444, 0);
            }, {
                Text = createElement_upvr("TextLabel", {
                    BackgroundTransparency = 1;
                    Size = UDim2.fromScale(1, 0.8);
                    Position = UDim2.fromScale(0.5, 0.5);
                    AnchorPoint = Vector2.new(0.5, 0.5);
                    Font = Enum.Font.FredokaOne;
                    Text = tostring(math.max(0, math.floor(arg1.state.remaining)));
                    TextColor3 = Color3.new(0.3, 0.3, 0.3);
                    TextScaled = true;
                });
            });
        });
        Stroke = createElement_upvr("UIStroke", {
            Thickness = 1;
            Color = Color3.new(0.7, 0.7, 0.7);
        });
    })
end
function any_extend_result1._update(arg1) -- Line 125
    if not arg1.props.visible then
    else
        local var30 = arg1.props.countdownTil - workspace:GetServerTimeNow()
        arg1:setState({
            remaining = var30;
        })
        if 0 < arg1.state.remaining and var30 <= 0 and arg1.props.onExpired then
            arg1.props.onExpired()
        end
    end
end
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
function any_extend_result1.didMount(arg1) -- Line 140
    arg1:_update()
    arg1.maid:GiveTask(Interval_upvr.every(1):Connect(function() -- Line 142
        arg1:_update()
    end))
end
function any_extend_result1.willUnmount(arg1) -- Line 146
    arg1.maid:DoCleaning()
end
return any_extend_result1
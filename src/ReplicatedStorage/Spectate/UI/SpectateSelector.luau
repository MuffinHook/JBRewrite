local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("SpectateSelector")
any_extend_result1.defaultProps = {
    size = UDim2.fromScale(1, 1);
    position = UDim2.fromScale(0.5, 0.5);
    title = "N/A";
}
local createElement_upvr = Roact_upvr.createElement
local PaddedContainer_upvr = require(ReplicatedStorage.EzUi.PaddedContainer)
function any_extend_result1.render(arg1) -- Line 12
    return createElement_upvr("Frame", {
        BackgroundTransparency = 0.8;
        BackgroundColor3 = Color3.new(0, 0, 0);
        Size = arg1.props.size;
        AnchorPoint = Vector2.new(0.5, 0.5);
        Position = arg1.props.position;
    }, {
        Corner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 4);
        });
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 8;
        });
        PaddedContainer = createElement_upvr(PaddedContainer_upvr, {
            backgroundTransparency = 1;
            aspectRatio = 8;
            verticalPaddingRatio = 16;
            paddingNone = true;
        }, {
            Left = createElement_upvr(PaddedContainer_upvr, {
                backgroundTransparency = 1;
                size = UDim2.fromScale(0.125, 1);
                position = UDim2.fromScale(0, 0);
                paddingRight = 0.5;
            }, {
                Button = createElement_upvr("TextButton", {
                    BorderSizePixel = 0;
                    BackgroundColor3 = Color3.fromRGB(192, 122, 255);
                    Size = UDim2.fromScale(1, 1);
                    Font = Enum.Font.FredokaOne;
                    TextScaled = true;
                    Text = '<';
                    Selectable = true;
                    [Roact_upvr.Event.Activated] = arg1.props.onClickPrev;
                }, {
                    Corner = createElement_upvr("UICorner", {
                        CornerRadius = UDim.new(0, 4);
                    });
                });
            });
            Name = createElement_upvr(PaddedContainer_upvr, {
                backgroundTransparency = 0;
                backgroundColor = Color3.new(0.2, 0.2, 0.2);
                size = UDim2.fromScale(0.75, 1);
                position = UDim2.fromScale(0.125, 0);
                paddingLeft = 0.5;
                paddingRight = 0.5;
            }, {
                Corner = createElement_upvr("UICorner", {
                    CornerRadius = UDim.new(0, 4);
                });
                Title = createElement_upvr("TextLabel", {
                    BackgroundTransparency = 1;
                    Size = UDim2.new(1, 0, 1.25, 0);
                    Position = UDim2.new(0.5, 0, 0.5, 0);
                    AnchorPoint = Vector2.new(0.5, 0.5);
                    Text = arg1.props.title;
                    Font = Enum.Font.FredokaOne;
                    TextColor3 = Color3.new(1, 1, 1);
                    TextScaled = true;
                });
            });
            Right = createElement_upvr(PaddedContainer_upvr, {
                backgroundTransparency = 1;
                size = UDim2.fromScale(0.125, 1);
                position = UDim2.fromScale(0.875, 0);
                paddingLeft = 0.5;
            }, {
                Button = createElement_upvr("TextButton", {
                    BorderSizePixel = 0;
                    BackgroundColor3 = Color3.fromRGB(192, 122, 255);
                    Size = UDim2.fromScale(1, 1);
                    Font = Enum.Font.FredokaOne;
                    TextScaled = true;
                    Text = '>';
                    Selectable = true;
                    [Roact_upvr.Event.Activated] = arg1.props.onClickNext;
                }, {
                    Corner = createElement_upvr("UICorner", {
                        CornerRadius = UDim.new(0, 4);
                    });
                });
            });
        });
    })
end
return any_extend_result1
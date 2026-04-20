local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("ProgressBar")
any_extend_result1.defaultProps = {
    aspectRatio = 19;
    verticalPaddingRatio = 4.266666666666667;
    text = "";
    size = UDim2.fromScale(1, 0.3);
    position = UDim2.fromScale(0, 0);
    textStrokeThickness = 1;
    barStrokeThickness = 3;
    barStrokeColor = Color3.new(0, 0, 0);
    progress = 0.4;
    unfilledColor = Color3.new(0, 0, 0);
    filledColor = Color3.new(0.47451, 0.760784, 0.309804);
}
local createElement_upvr = Roact_upvr.createElement
local PaddedContainer_upvr = require(ReplicatedStorage.EzUi.PaddedContainer)
function any_extend_result1.render(arg1) -- Line 22
    local progress = arg1.props.progress
    if 1 < progress then
        warn("Passed larger progress than max:", progress)
        progress = 1
    elseif progress < 0 then
        warn("Passed negative progress:", progress)
        progress = 0
    end
    return createElement_upvr("Frame", {
        Size = arg1.props.size;
        Position = arg1.props.position;
        BackgroundTransparency = 1;
    }, {
        TotalCurrency = createElement_upvr(PaddedContainer_upvr, {
            backgroundTransparency = 0;
            backgroundColor = arg1.props.unfilledColor;
            aspectRatio = arg1.props.aspectRatio;
            verticalPaddingRatio = arg1.props.verticalPaddingRatio;
            size = UDim2.fromScale(1, 1);
            position = UDim2.fromScale(0, 0);
            anchorPoint = arg1.props.anchorPoint;
            paddingNone = true;
        }, {
            Stroke = createElement_upvr("UIStroke", {
                Thickness = arg1.props.barStrokeThickness;
                Color = arg1.props.barStrokeColor;
            });
            Corner = createElement_upvr("UICorner", {
                CornerRadius = UDim.new(1, 0);
            });
            CurrCurrency = createElement_upvr(PaddedContainer_upvr, {
                size = UDim2.fromScale(progress, 1);
                position = UDim2.fromScale(0, 0);
                paddingNone = true;
                backgroundColor = arg1.props.filledColor;
                [Roact_upvr.Ref] = arg1.props.currCurrencyRef;
            }, {
                Corner = createElement_upvr("UICorner", {
                    CornerRadius = UDim.new(1, 0);
                });
            });
            ReasonText = createElement_upvr("TextLabel", {
                BackgroundTransparency = 1;
                Size = UDim2.fromScale(1, 1);
                AnchorPoint = Vector2.new(0.5, 0.5);
                Position = UDim2.fromScale(0.5, 0.5);
                Font = Enum.Font.GothamBlack;
                TextXAlignment = Enum.TextXAlignment.Center;
                Text = arg1.props.text;
                LineHeight = 1;
                TextScaled = true;
                TextColor3 = Color3.new(1, 1, 1);
                ZIndex = 3;
            }, {
                Stroke = createElement_upvr("UIStroke", {
                    Thickness = arg1.props.textStrokeThickness;
                    Color = Color3.new(0, 0, 0);
                });
            });
        });
    })
end
return any_extend_result1
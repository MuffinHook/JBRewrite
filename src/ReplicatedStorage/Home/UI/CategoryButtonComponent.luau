local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local ColorUtils_upvr = require(ReplicatedStorage.Std.ColorUtils)
local createElement_upvr = Roact_upvr.createElement
local PaddedContainer_upvr = require(ReplicatedStorage.EzUi.PaddedContainer)
return function(arg1) -- Line 7, Named "categoryButtonComponent"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var6
    if arg1.selected then
        var6 = arg1.selectedBgColor
    else
        var6 = Color3.new(0, 0, 0)
    end
    if arg1.selected then
        local any_brightenBy_result1 = ColorUtils_upvr.brightenBy(var6, -0.8)
    else
    end
    return createElement_upvr("TextButton", {
        BackgroundTransparency = 0;
        BorderSizePixel = 0;
        BackgroundColor3 = var6;
        Size = arg1.size;
        Position = arg1.position;
        Text = "";
        Selectable = true;
        [Roact_upvr.Event.Activated] = function() -- Line 18
            if arg1.onClick then
                arg1.onClick(arg1.index)
            end
        end;
    }, {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 4);
        });
        Inner = createElement_upvr(PaddedContainer_upvr, {
            backgroundTransparency = 1;
            aspectRatio = arg1.aspectRatio;
            verticalPaddingRatio = 1 / arg1.paddingRatio;
            paddingTop = 0;
            paddingBottom = 0;
            paddingLeft = 0;
            paddingRight = 0;
        }, {
            TitleContainer = createElement_upvr(PaddedContainer_upvr, {
                backgroundTransparency = 1;
                size = UDim2.fromScale(1, 1);
                paddingTop = 1;
                paddingBottom = 1;
            }, {
                Title = createElement_upvr("TextLabel", {
                    BackgroundTransparency = 1;
                    Size = UDim2.fromScale(1, 1);
                    Position = UDim2.fromScale(1, 0.5);
                    AnchorPoint = Vector2.new(1, 0.5);
                    Text = arg1.title;
                    Font = Enum.Font.FredokaOne;
                    LineHeight = 1;
                    TextScaled = true;
                    TextXAlignment = Enum.TextXAlignment.Right;
                    TextYAlignment = Enum.TextYAlignment.Center;
                    TextColor3 = Color3.new(1, 1, 1);
                });
            });
        });
    })
end
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local RewardSpinnerConsts_upvr = require(ReplicatedStorage.RewardSpinner.RewardSpinnerConsts)
local createElement_upvr = Roact_upvr.createElement
local SafeComponent_upvr = require(script.Parent.SafeComponent)
return function(arg1) -- Line 8
    local aspectRatio = arg1.aspectRatio
    local verticalPaddingRatio = arg1.verticalPaddingRatio
    local tbl = {}
    local len = #RewardSpinnerConsts_upvr.RARITIES
    tbl.ListLayout = createElement_upvr("UIListLayout", {
        HorizontalAlignment = Enum.HorizontalAlignment.Center;
        VerticalAlignment = Enum.VerticalAlignment.Center;
        SortOrder = Enum.SortOrder.LayoutOrder;
        FillDirection = Enum.FillDirection.Vertical;
    })
    for i = 1, len do
        local var13 = RewardSpinnerConsts_upvr.RARITIES[i]
        local var14 = 1.6 / len
        local var15 = arg1.RarityProbabilities[var13.id]
        if var15 then
            local var16 = 0 + 1
            tbl[var16] = createElement_upvr("Frame", {
                BackgroundTransparency = 1;
                BorderSizePixel = 0;
                Size = UDim2.new(1, 0, 1 / len, 0);
                Position = UDim2.new(0, 0, (var16 - 1) / len, 0);
                LayoutOrder = var16;
            }, {
                Number = createElement_upvr("TextLabel", {
                    BackgroundTransparency = 1;
                    Size = UDim2.new(var14, 0, 1, 0);
                    Position = UDim2.new(0, 0, 0, 0);
                    Text = tostring(var15)..'%';
                    TextXAlignment = Enum.TextXAlignment.Right;
                    Font = Enum.Font.Bangers;
                    LineHeight = 1;
                    TextScaled = true;
                    TextColor3 = var13.color;
                });
                Text = createElement_upvr("TextLabel", {
                    BackgroundTransparency = 1;
                    Size = UDim2.new(1 - var14, 0, 1, 0);
                    Position = UDim2.new(var14 + 1 / verticalPaddingRatio / aspectRatio, 0, 0, 0);
                    Text = var13.name;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    Font = Enum.Font.Bangers;
                    LineHeight = 1;
                    TextScaled = true;
                    TextColor3 = var13.color;
                });
            })
        end
    end
    return Roact_upvr.createFragment({
        Title = createElement_upvr("Frame", {
            BorderSizePixel = 0;
            BackgroundTransparency = 1;
            BackgroundColor3 = Color3.new(1, 0, 0);
            Size = UDim2.new(1, 0, 0.1, 0);
            Position = UDim2.new(0, 0, 0, 0);
        }, {
            Text = createElement_upvr("TextLabel", {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 1, 0);
                Position = UDim2.new(0.5, 0, 0.5, 0);
                AnchorPoint = Vector2.new(0.5, 0.5);
                Text = arg1.Title.." SAFE";
                TextXAlignment = Enum.TextXAlignment.Center;
                Font = Enum.Font.Bangers;
                LineHeight = 1;
                TextScaled = true;
                TextColor3 = Color3.new(1, 1, 1);
            });
        });
        Safe = createElement_upvr(SafeComponent_upvr, {
            static = true;
            selected = true;
            size = UDim2.new(aspectRatio / aspectRatio, 0, aspectRatio, 0);
            position = UDim2.new(0, 0, 0.1 + 1 / verticalPaddingRatio, 0);
            aspectRatio = 1;
            layoutOrder = 2;
            imageId = arg1.ImageId;
        });
        Numbers = createElement_upvr("Frame", {
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            Size = UDim2.new(1, 0, 0.9 - aspectRatio - 2 / verticalPaddingRatio, 0);
            Position = UDim2.new(0, 0, 0.1 + aspectRatio + 2 / verticalPaddingRatio, 0);
            LayoutOrder = 4;
        }, tbl);
    })
end
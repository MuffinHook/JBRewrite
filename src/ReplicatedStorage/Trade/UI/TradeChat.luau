local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact.PureComponent:extend("TradeChat")
any_extend_result1.defaultProps = {
    size = UDim2.new(1, 0, 1, 0);
    position = UDim2.new(0, 0, 0, 0);
    aspectRatio = 1;
    verticalPaddingRatio = 128;
}
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function any_extend_result1.init(arg1) -- Line 15
    arg1.maid = Maid_upvr.new()
end
local createElement_upvr = Roact.createElement
local PaddedContainer_upvr = require(ReplicatedStorage.EzUi.PaddedContainer)
function any_extend_result1.render(arg1) -- Line 18
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local aspectRatio = arg1.props.aspectRatio
    local verticalPaddingRatio = arg1.props.verticalPaddingRatio
    local tbl = {
        ListLayout = createElement_upvr("UIListLayout", {
            HorizontalAlignment = Enum.HorizontalAlignment.Center;
            VerticalAlignment = Enum.VerticalAlignment.Top;
            SortOrder = Enum.SortOrder.LayoutOrder;
            FillDirection = Enum.FillDirection.Vertical;
            Padding = UDim.new(1 / verticalPaddingRatio, 0);
        });
    }
    if arg1.props.messages then
        for i, v in arg1.props.messages do
            local var20
            if not v.color then
                local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                    var20 = Color3.new(0.75, 0.75, 0.75)
                    return var20
                end
                if v.me or not decompInlinedCondition() then
                    var20 = Color3.new(1, 1, 1)
                end
            end
            tbl[v] = createElement_upvr("TextLabel", {
                BackgroundTransparency = 1;
                BorderSizePixel = 0;
                Size = UDim2.new(1, 0, 0, 0);
                AutomaticSize = Enum.AutomaticSize.Y;
                RichText = true;
                Text = v.displayName..": "..v.text;
                LayoutOrder = i;
                Font = Enum.Font.SourceSansBold;
                TextXAlignment = Enum.TextXAlignment.Left;
                TextColor3 = var20;
                TextSize = 15;
                TextWrapped = true;
            })
        end
    end
    return createElement_upvr("Frame", {
        BackgroundTransparency = 0.8;
        BackgroundColor3 = Color3.new(0, 0, 0);
        Size = arg1.props.size;
        Position = arg1.props.position;
    }, {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 4);
        });
        Title = createElement_upvr(PaddedContainer_upvr, {
            size = UDim2.new(1, 0, 0.1, 0);
            backgroundColor = Color3.new(0.2, 0.2, 0.2);
            backgroundTransparency = 0;
            aspectRatio = aspectRatio;
            verticalPaddingRatio = verticalPaddingRatio;
            paddingBottom = 0.5;
        }, {
            UICorner = createElement_upvr("UICorner", {
                CornerRadius = UDim.new(0, 4);
            });
            Text = createElement_upvr("TextLabel", {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 1, 0);
                Position = UDim2.new(0.5, 0, 0.5, 0);
                AnchorPoint = Vector2.new(0.5, 0.5);
                Text = "TRADE CHAT";
                TextXAlignment = Enum.TextXAlignment.Center;
                Font = Enum.Font.Bangers;
                LineHeight = 1;
                TextScaled = true;
                TextColor3 = Color3.new(1, 1, 1);
            });
        });
        Inner = createElement_upvr(PaddedContainer_upvr, {
            size = UDim2.new(1, 0, 0.9, 0);
            position = UDim2.new(0, 0, 0.1, 0);
            backgroundColor = Color3.new(0.2, 0.2, 0.2);
            backgroundTransparency = 0;
            aspectRatio = aspectRatio;
            verticalPaddingRatio = verticalPaddingRatio;
            paddingTop = 0.5;
        }, {
            UICorner = createElement_upvr("UICorner", {
                CornerRadius = UDim.new(0, 4);
            });
            Messages = createElement_upvr(PaddedContainer_upvr, {
                backgroundTransparency = 1;
            }, {
                ScrollingFrame = createElement_upvr("ScrollingFrame", {
                    BackgroundTransparency = 1;
                    BackgroundColor3 = Color3.new(1, 1, 1);
                    BorderSizePixel = 0;
                    ScrollBarThickness = 4;
                    ScrollBarImageColor3 = Color3.new(1, 1, 1);
                    Size = UDim2.new(1, 0, 1, 0);
                    CanvasSize = UDim2.new(0, 0, 0, 0);
                    AutomaticCanvasSize = Enum.AutomaticSize.Y;
                    ElasticBehavior = Enum.ElasticBehavior.Always;
                    VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right;
                    VerticalScrollBarInset = Enum.ScrollBarInset.None;
                }, tbl);
            });
        });
    })
end
return any_extend_result1
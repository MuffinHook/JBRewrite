local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact.PureComponent:extend("Receipt")
any_extend_result1.defaultProps = {
    showTotal = true;
}
function any_extend_result1.init(arg1) -- Line 14
end
local createElement_upvr = Roact.createElement
local ReceiptItem_upvr = require(script.Parent.ReceiptItem)
local Dictionary_upvr = require(ReplicatedStorage.EzUi.Dictionary)
local String_upvr = require(ReplicatedStorage.Std.String)
function any_extend_result1.render(arg1) -- Line 15
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local mainRatio = arg1.props.mainRatio
    local paddingRatio = arg1.props.paddingRatio
    local var15 = arg1.props.paddingRatio * 2
    local var16
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var16 = 1 / (1 / mainRatio - 0.2222222222222222)
        return var16
    end
    if not arg1.props.showTotal or not decompInlinedCondition() then
        var16 = mainRatio
    end
    local tbl_2 = {}
    for i = 1, #arg1.props.receipt do
        local var18_upvr = arg1.props.receipt[i]
        local var19
        if arg1.props.owned[var18_upvr.category] and arg1.props.owned[var18_upvr.category][var18_upvr.name] then
            var19 = false
        end
        if var18_upvr.limited then
            var19 = false
        end
        if var19 then
            local var20 = 0 + (var18_upvr.price or 0)
            local tbl_5 = {
                layoutOrder = i * 2;
                mainRatio = 1 / ((1) / (var16 * 6) - 1 / var15 + 1 / var15 / 6);
                paddingRatio = paddingRatio;
                cornerPixel = arg1.props.cornerPixel;
            }
            local function onRequestRemove() -- Line 54
                arg1.props.onRequestRemove(var18_upvr)
            end
            tbl_5.onRequestRemove = onRequestRemove
            table.insert(tbl_2, createElement_upvr(ReceiptItem_upvr, Dictionary_upvr.merge(tbl_5, var18_upvr)))
            table.insert(tbl_2, createElement_upvr("Frame", {
                BorderSizePixel = 0;
                BackgroundTransparency = 0;
                BackgroundColor3 = Color3.new(0, 0, 0);
                Size = UDim2.new(1, 0, 1, 0);
                LayoutOrder = i * 2 + 1;
            }, {
                AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
                    AspectRatio = var15;
                });
            }))
        end
    end
    local module = {}
    var18_upvr = 0
    module.BackgroundTransparency = var18_upvr
    var18_upvr = 0
    module.BorderSizePixel = var18_upvr
    var18_upvr = Color3.new(0.1, 0.1, 0.1)
    module.BackgroundColor3 = var18_upvr
    var18_upvr = UDim2.new(1, 0, 1, 0)
    module.Size = var18_upvr
    var18_upvr = arg1.props
    var18_upvr = var18_upvr.layoutOrder
    module.LayoutOrder = var18_upvr
    var18_upvr = {}
    local var26 = var18_upvr
    var26.AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
        AspectRatio = mainRatio;
    })
    local tbl_6 = {}
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    tbl_6.CornerRadius = UDim.new(0, arg1.props.cornerPixel)
    var26.UICorner = createElement_upvr("UICorner", tbl_6)
    var26.ScrollingFrame = createElement_upvr("ScrollingFrame", {
        BackgroundTransparency = 1;
        BackgroundColor3 = Color3.new(1, 1, 1);
        BorderSizePixel = 0;
        ScrollBarThickness = 4;
        ScrollBarImageColor3 = Color3.new(1, 1, 1);
        CanvasSize = UDim2.new(0, 0, ((1 + mainRatio / var15) * (0 + 1) / 6 - mainRatio / var15) * mainRatio / var16, 0);
        Size = UDim2.new(1, 0, mainRatio / var16, 0);
        ElasticBehavior = Enum.ElasticBehavior.Always;
        VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left;
        VerticalScrollBarInset = Enum.ScrollBarInset.None;
    }, Dictionary_upvr.merge({
        ListLayout = createElement_upvr("UIListLayout", {
            HorizontalAlignment = Enum.HorizontalAlignment.Center;
            VerticalAlignment = Enum.VerticalAlignment.Top;
            SortOrder = Enum.SortOrder.LayoutOrder;
            FillDirection = Enum.FillDirection.Vertical;
        });
    }, tbl_2))
    local tbl = {
        Line = createElement_upvr("Frame", {
            Size = UDim2.new(1, 0, 0, 1);
            Position = UDim2.new(0, 0, 0, 0);
            BackgroundColor3 = Color3.new(0, 0, 0);
            BorderSizePixel = 0;
        });
        Total = createElement_upvr("Frame", {
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            Size = UDim2.new(0.5 - 0.5 / paddingRatio - 1 / paddingRatio, 0, 0.6, 0);
            Position = UDim2.new(1 / paddingRatio, 0, 0.2, 0);
        }, {
            Title = createElement_upvr("TextLabel", {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 1, 0);
                Position = UDim2.new(0, 0, 0, 0);
                AnchorPoint = Vector2.new(0, 0);
                Text = "TOTAL:";
                Font = Enum.Font.Bangers;
                LineHeight = 0.95;
                TextScaled = true;
                TextColor3 = Color3.new(1, 1, 1);
                TextXAlignment = Enum.TextXAlignment.Right;
                TextYAlignment = Enum.TextYAlignment.Center;
            });
        });
    }
    local tbl_4 = {}
    local tbl_3 = {
        BackgroundTransparency = 1;
        Size = UDim2.new(1, 0, 1, 0);
        Position = UDim2.new(0, 0, 0, 0);
        AnchorPoint = Vector2.new(0, 0);
    }
    if 0 < var20 then
    else
    end
    tbl_3.Text = ""..'$'..String_upvr.comma(var20)
    tbl_3.Font = Enum.Font.Bangers
    tbl_3.LineHeight = 0.95
    tbl_3.TextScaled = true
    if 0 >= var20 or not Color3.new(1, 0, 0) then
    end
    tbl_3.TextColor3 = Color3.fromRGB(134, 195, 81)
    tbl_3.TextXAlignment = Enum.TextXAlignment.Left
    tbl_3.TextYAlignment = Enum.TextYAlignment.Center
    tbl_4.Title = createElement_upvr("TextLabel", tbl_3)
    tbl.Price = createElement_upvr("Frame", {
        BackgroundTransparency = 1;
        BorderSizePixel = 0;
        Size = UDim2.new(0.5 - 0.5 / paddingRatio - 1 / paddingRatio, 0, 0.6, 0);
        Position = UDim2.new(0.5 + 0.5 / paddingRatio, 0, 0.2, 0);
    }, tbl_4)
    var26.Bottom = createElement_upvr("Frame", {
        BackgroundTransparency = 0.6;
        BackgroundColor3 = Color3.new(0, 0, 0);
        BorderSizePixel = 0;
        Size = UDim2.new(1, 0, mainRatio / 4.5, 0);
        Position = UDim2.new(0, 0, 1 - mainRatio / 4.5, 0);
        Visible = arg1.props.showTotal;
    }, tbl)
    return createElement_upvr("Frame", module, var26)
end
return require(ReplicatedStorage.RoactRodux).connect(function(arg1, arg2) -- Line 177
end, function(arg1) -- Line 177
    return {
        onRequestRemove = function(arg1_2) -- Line 179, Named "onRequestRemove"
            arg1({
                type = "removeReceiptItem";
                name = arg1_2.name;
                category = arg1_2.category;
            })
        end;
    }
end)(any_extend_result1)
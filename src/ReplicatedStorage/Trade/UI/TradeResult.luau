local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact.PureComponent:extend("TradeResult")
any_extend_result1.defaultProps = {
    size = UDim2.new(1, 0, 1, 0);
    position = UDim2.new(0, 0, 0, 0);
    anchorPoint = Vector2.new();
}
function any_extend_result1.init(arg1) -- Line 12
end
local createElement_upvr = Roact.createElement
function any_extend_result1.render(arg1) -- Line 13
    local tradeResult = arg1.props.tradeResult
    local var7
    if not tradeResult then return end
    local module = {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 8);
        });
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 3;
        });
    }
    local tbl_6 = {
        BackgroundTransparency = 1;
        BackgroundColor3 = Color3.new(1, 0, 0);
    }
    var7 = 0
    tbl_6.Size = UDim2.new(1, 0, 0.5, var7)
    var7 = 0
    tbl_6.Position = UDim2.new(0, 0, 0, var7)
    local tbl = {}
    local tbl_3 = {}
    var7 = 1
    tbl_3.BackgroundTransparency = var7
    var7 = UDim2.new(1, 0, 1, 0)
    tbl_3.Size = var7
    var7 = UDim2.new(0.5, 0, 0.5, 0)
    tbl_3.Position = var7
    var7 = Vector2.new(0.5, 0.5)
    tbl_3.AnchorPoint = var7
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var7 = Color3.fromRGB(53, 171, 84)
        return var7
    end
    if not tradeResult.success or not decompInlinedCondition() then
        var7 = Color3.fromRGB(237, 66, 69)
    end
    tbl_3.TextColor3 = var7
    tbl_3.Text = tradeResult.title
    var7 = Enum.TextXAlignment.Center
    tbl_3.TextXAlignment = var7
    var7 = Enum.Font.Bangers
    tbl_3.Font = var7
    var7 = 1
    tbl_3.LineHeight = var7
    var7 = true
    tbl_3.TextScaled = var7
    tbl.Text = createElement_upvr("TextLabel", tbl_3)
    module.Title = createElement_upvr("Frame", tbl_6, tbl)
    local tbl_4 = {
        BackgroundTransparency = 1;
        BackgroundColor3 = Color3.new(1, 0, 0);
    }
    var7 = 0
    tbl_4.Size = UDim2.new(1, 0, 0.5, var7)
    var7 = 0
    tbl_4.Position = UDim2.new(0, 0, 0.5, var7)
    local tbl_2 = {}
    local tbl_5 = {}
    var7 = 1
    tbl_5.BackgroundTransparency = var7
    var7 = UDim2.new(0.8, 0, 0.8, 0)
    tbl_5.Size = var7
    var7 = UDim2.new(0.5, 0, 0.5, 0)
    tbl_5.Position = var7
    var7 = Vector2.new(0.5, 0.5)
    tbl_5.AnchorPoint = var7
    var7 = Color3.new(0.1, 0.1, 0.1)
    tbl_5.TextColor3 = var7
    tbl_5.Text = tradeResult.body
    var7 = Enum.TextXAlignment.Center
    tbl_5.TextXAlignment = var7
    var7 = Enum.Font.Bangers
    tbl_5.Font = var7
    var7 = 1
    tbl_5.LineHeight = var7
    var7 = true
    tbl_5.TextScaled = var7
    tbl_2.Text = createElement_upvr("TextLabel", tbl_5)
    module.Desc = createElement_upvr("Frame", tbl_4, tbl_2)
    return createElement_upvr("Frame", {
        Size = arg1.props.size;
        Position = arg1.props.position;
        AnchorPoint = arg1.props.anchorPoint;
        BackgroundColor3 = Color3.new(1, 1, 1);
        BackgroundTransparency = 0;
    }, module)
end
function any_extend_result1.willUnmount(arg1) -- Line 74
end
return require(ReplicatedStorage.RoactRodux).connect(function(arg1, arg2) -- Line 75
    return {
        tradeResult = arg1.tradeResult;
    }
end)(any_extend_result1)
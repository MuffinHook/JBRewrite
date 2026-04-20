local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact.PureComponent:extend("BattleRobberyStatus")
local createElement_upvr = Roact.createElement
local ColorUtils_upvr = require(ReplicatedStorage.Std.ColorUtils)
local Color3_fromRGB_result1_upvr = Color3.fromRGB(127, 249, 82)
local RobberyConsts_upvr = require(ReplicatedStorage.Robbery.RobberyConsts)
function any_extend_result1.render(arg1) -- Line 10
    local rowIndex = arg1.props.rowIndex
    local module_2 = {}
    local var10 = 0
    module_2.BorderSizePixel = var10
    if arg1.props.robberyCompleted then
        var10 = ColorUtils_upvr
        var10 = var10.brightenBy(Color3_fromRGB_result1_upvr, -0.1)
    else
        var10 = arg1.props
        var10 = var10.backgroundColor
    end
    module_2.BackgroundColor3 = var10
    module_2.Size = UDim2.new(1, 0, 0.6666666666666666, 0)
    module_2.AnchorPoint = Vector2.new(0, 0)
    module_2.Position = UDim2.new(0, 0, 0.6666666666666666 * (rowIndex - 1) + 1, 2.6666666666666665 * rowIndex)
    local module = {
        UICorners = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 4);
        });
        TitleContainer = createElement_upvr("Frame", {
            BackgroundTransparency = 1;
            Size = UDim2.new(0.8, 0, 1, 0);
        }, {
            Text = createElement_upvr("TextLabel", {
                BackgroundTransparency = 1;
                Size = UDim2.new(0.95, 0, 0.9, 0);
                Position = UDim2.new(1, 0, 0.5, 0);
                AnchorPoint = Vector2.new(1, 0.5);
                Font = Enum.Font.FredokaOne;
                TextXAlignment = Enum.TextXAlignment.Left;
                Text = RobberyConsts_upvr.PRETTY_NAME[arg1.props.robberyType];
                LineHeight = 1;
                TextScaled = true;
                TextColor3 = ColorUtils_upvr.brightenBy(arg1.props.backgroundColor, -0.75);
            });
        });
    }
    local tbl_2 = {
        BackgroundTransparency = 1;
        Size = UDim2.new(0.2, 0, 1, 0);
        AnchorPoint = Vector2.new(1, 0);
    }
    local var17 = 0
    tbl_2.Position = UDim2.new(1, 0, 0, var17)
    local tbl_3 = {}
    local tbl = {}
    if arg1.props.robberyCompleted then
        var17 = Color3_fromRGB_result1_upvr
    else
        var17 = ColorUtils_upvr
        var17 = var17.brightenBy(arg1.props.backgroundColor, -0.8)
    end
    tbl.BackgroundColor3 = var17
    tbl.BackgroundTransparency = 0
    tbl.Size = UDim2.fromScale(0.75, 0.75)
    tbl.AnchorPoint = Vector2.new(0.5, 0.5)
    tbl.Position = UDim2.fromScale(0.5, 0.5)
    tbl_3.Status = createElement_upvr("Frame", tbl, {
        UICorners = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(1, 0);
        });
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 3;
        });
    })
    module.StatusContainer = createElement_upvr("Frame", tbl_2, tbl_3)
    return createElement_upvr("Frame", module_2, module)
end
return any_extend_result1
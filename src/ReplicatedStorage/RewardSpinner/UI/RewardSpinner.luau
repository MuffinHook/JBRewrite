local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("RewardSpinner")
any_extend_result1.defaultProps = {
    size = UDim2.new(1, 0, 1, 0);
    position = UDim2.new(0.5, 0, 0.5, 0);
    anchorPoint = Vector2.new(0.5, 0.5);
    aspectRatio = 2.75;
    cornerPixel = 4;
    colsPerRow = 5.5;
    primaryColor = Color3.fromRGB(215, 131, 255);
}
local Maid_upvr = require(ReplicatedStorage_upvr.Std.Maid)
local RewardSpinnerConsts_upvr = require(ReplicatedStorage_upvr.RewardSpinner.RewardSpinnerConsts)
local Players_upvr = game:GetService("Players")
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
function any_extend_result1.init(arg1) -- Line 31
    arg1.maid = Maid_upvr.new()
    arg1.openMaid = Maid_upvr.new()
    local any_createBinding_result1_2, any_createBinding_result2 = Roact_upvr.createBinding(math.ceil(arg1.props.colsPerRow * 0.5 + 0.5))
    arg1.index = any_createBinding_result1_2
    arg1.updateIndex = any_createBinding_result2
    local any_createBinding_result1, any_createBinding_result2_2 = Roact_upvr.createBinding(false)
    arg1.ticked = any_createBinding_result1
    arg1.updateTicked = any_createBinding_result2_2
    function arg1.onFinished() -- Line 39
        local SOME = ReplicatedStorage_upvr:FindFirstChild(RewardSpinnerConsts_upvr.COLLECT_REWARD_REMOTE_NAME)
        if SOME then
            SOME:FireServer(arg1.props.config.topic)
        end
        arg1.openMaid:GiveTask(task.delay(1, function() -- Line 45
            arg1.props.close()
        end))
    end
    function arg1.playTick() -- Line 50
        if Players_upvr.LocalPlayer then
            Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 156286438)
        end
    end
end
local rewardCardComponent_upvr = require(script.Parent.rewardCardComponent)
local createElement_upvr = Roact_upvr.createElement
local GridUtils_upvr = require(ReplicatedStorage_upvr.EzUi.GridUtils)
local Grid_upvr = require(ReplicatedStorage_upvr.EzUi.Grid)
function any_extend_result1.render(arg1) -- Line 56
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var21
    if not arg1.props.config then return end
    local primaryColor = arg1.props.config.primaryColor
    if not primaryColor then
        primaryColor = arg1.props
        primaryColor = primaryColor.primaryColor
    end
    local aspectRatio = arg1.props.aspectRatio
    local var24 = 1 - 0.03125 / aspectRatio
    local var25 = var24 / 0.1515625 * aspectRatio
    local var26 = 1 - 1 / var25 - 0.10309278350515465 / var25
    local var27 = var26 / 1 * var25
    local var28 = 1 - 0.03125 / aspectRatio
    local var29 = var28 / 0.8015625 * aspectRatio
    local var30 = 1 - 0.038986354775828465 / var29
    local var31 = (1.138568129330254) * (var30 / 0.9610136452241715 * var29)
    local colsPerRow_upvr = arg1.props.colsPerRow
    local var33_upvr = 64 * var31 * 0.8015625 * 0.9610136452241715 * 0.8782961460446247
    local tbl_5_upvr = {
        aspectRatio = var31;
        items = arg1.props.config.items;
        component = rewardCardComponent_upvr;
        verticalPaddingRatio = var33_upvr / var31;
        rowsPerPage = 1;
        colsPerRow = colsPerRow_upvr;
        infHorizontal = true;
    }
    local module = {
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = arg1.props.aspectRatio;
        });
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, arg1.props.cornerPixel);
        });
    }
    local tbl_19 = {}
    local tbl_18 = {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, arg1.props.cornerPixel);
        });
    }
    local tbl_15 = {}
    var21 = 0
    tbl_15.Size = UDim2.new(0.9, 0, 0.9, var21)
    tbl_15.Position = UDim2.fromScale(0.5, 0.5)
    tbl_15.AnchorPoint = Vector2.new(0.5, 0.5)
    tbl_15.BackgroundColor3 = primaryColor
    local tbl_16 = {}
    local tbl_12 = {}
    var21 = UDim.new(1, 0)
    tbl_12.CornerRadius = var21
    tbl_16.UICorner = createElement_upvr("UICorner", tbl_12)
    local tbl_26 = {}
    var21 = 1
    tbl_26.BackgroundTransparency = var21
    var21 = UDim2.new(1, 0, 1, 0)
    tbl_26.Size = var21
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var21 = "rbxassetid://"..tostring(arg1.props.config.iconImageId)
        return var21
    end
    if not arg1.props.config.iconImageId or not decompInlinedCondition() then
        var21 = nil
    end
    tbl_26.Image = var21
    tbl_16.Image = createElement_upvr("ImageLabel", tbl_26)
    tbl_18.Circle = createElement_upvr("Frame", tbl_15, tbl_16)
    tbl_19.Icon = createElement_upvr("Frame", {
        BackgroundColor3 = Color3.new(0, 0, 0);
        BorderSizePixel = 0;
        Size = UDim2.new(1 / var25, 0, 1, 0);
    }, tbl_18)
    local tbl_3 = {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, arg1.props.cornerPixel);
        });
    }
    local tbl_7 = {
        BorderSizePixel = 0;
        BackgroundTransparency = 1;
        BackgroundColor3 = Color3.new(1, 1, 1);
    }
    var21 = 0
    tbl_7.Size = UDim2.new(0.5 - 0.10309278350515465 / var27, 0, 1, var21)
    var21 = 0
    tbl_7.Position = UDim2.new(0.10309278350515465 / var27, 0, 0, var21)
    local tbl_21 = {}
    local tbl_13 = {}
    var21 = 1
    tbl_13.BackgroundTransparency = var21
    var21 = UDim2.new(1, 0, 1, 0)
    tbl_13.Size = var21
    var21 = UDim2.new(0.5, 0, 0.5, 0)
    tbl_13.Position = var21
    var21 = Vector2.new(0.5, 0.5)
    tbl_13.AnchorPoint = var21
    var21 = arg1.props
    var21 = var21.config
    var21 = var21.title
    tbl_13.Text = var21
    var21 = Enum.TextXAlignment.Left
    tbl_13.TextXAlignment = var21
    var21 = Enum.Font.Bangers
    tbl_13.Font = var21
    var21 = 1
    tbl_13.LineHeight = var21
    var21 = true
    tbl_13.TextScaled = var21
    tbl_13.TextColor3 = primaryColor
    tbl_21.Text = createElement_upvr("TextLabel", tbl_13)
    tbl_3.Container = createElement_upvr("Frame", tbl_7, tbl_21)
    tbl_19.Title = createElement_upvr("Frame", {
        BorderSizePixel = 0;
        BackgroundColor3 = Color3.new(0, 0, 0);
        Size = UDim2.new(var26, 0, 1, 0);
        Position = UDim2.new(1 / var25 + 0.10309278350515465 / var25, 0, 0, 0);
    }, tbl_3)
    module.Top = createElement_upvr("Frame", {
        BorderSizePixel = 0;
        BackgroundTransparency = 1;
        Position = UDim2.new(0.015625 / aspectRatio, 0, 0.015625, 0);
        Size = UDim2.new(var24, 0, 0.1515625, 0);
    }, tbl_19)
    local tbl_27 = {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, arg1.props.cornerPixel);
        });
    }
    local tbl_2 = {}
    local tbl_9 = {
        BackgroundColor3 = Color3.new(0.4, 0.4, 0.4);
        BackgroundTransparency = 0;
        BorderSizePixel = 0;
        ClipsDescendants = true;
    }
    var21 = 0
    tbl_9.Size = UDim2.new(1, 0, 1, var21)
    local tbl_6 = {}
    local tbl_25 = {}
    var21 = UDim.new(0, arg1.props.cornerPixel)
    tbl_25.CornerRadius = var21
    tbl_6.UICorner = createElement_upvr("UICorner", tbl_25)
    local tbl = {}
    var21 = 0
    tbl.BorderSizePixel = var21
    var21 = 1
    tbl.BackgroundTransparency = var21
    var21 = Color3.new(1, 0, 0)
    tbl.BackgroundColor3 = var21
    var21 = UDim2.new(1, 0, 0.8782961460446247, 0)
    tbl.Size = var21
    var21 = Vector2.new(0, 0.5)
    tbl.AnchorPoint = var21
    var21 = arg1.index
    var21 = var21:map(function(arg1_2) -- Line 253
        return UDim2.new(-(arg1_2 - colsPerRow_upvr * 0.5 - 0.5) * GridUtils_upvr.getScaleX(tbl_5_upvr) - (arg1_2 - colsPerRow_upvr * 0.5 - 0.5) / var33_upvr, 0, 0.5, 0)
    end)
    tbl.Position = var21
    var21 = {}
    var21.Grid = createElement_upvr(Grid_upvr, tbl_5_upvr)
    tbl_6.Slider = createElement_upvr("Frame", tbl, var21)
    tbl_2.Container = createElement_upvr("Frame", tbl_9, tbl_6)
    tbl_27.InnerBody = createElement_upvr("Frame", {
        BackgroundTransparency = 1;
        BorderSizePixel = 0;
        Position = UDim2.new(0.019493177387914232 / var29, 0, 0.019493177387914232, 0);
        Size = UDim2.new(var30, 0, 0.9610136452241715, 0);
        ZIndex = 0;
    }, tbl_2)
    local tbl_8 = {}
    local tbl_17 = {
        BackgroundTransparency = 1;
        Image = "rbxassetid://10065704207";
        ImageColor3 = Color3.new(0, 0, 0);
    }
    var21 = 0
    tbl_17.Size = UDim2.new(1, 0, 1, var21)
    var21 = 0
    tbl_17.Position = UDim2.new(0, 0, 0.5, var21)
    tbl_17.Rotation = 180
    tbl_8.Icon = createElement_upvr("ImageLabel", tbl_17)
    tbl_27.ArrowTop = createElement_upvr("Frame", {
        BackgroundTransparency = 1;
        Size = UDim2.new(0.125 / var29, 0, 0.0625, 0);
        AnchorPoint = Vector2.new(0.5, 0.5);
        Position = UDim2.new(0.5, 0, 0.019493177387914232, 0);
        ZIndex = 3;
    }, tbl_8)
    local tbl_24 = {}
    local tbl_22 = {
        BackgroundTransparency = 1;
        Image = "rbxassetid://10065704207";
        ImageColor3 = Color3.new(0, 0, 0);
    }
    var21 = 0
    tbl_22.Size = UDim2.new(1, 0, 1, var21)
    var21 = 0
    tbl_22.Position = UDim2.new(0, 0, -0.5, var21)
    tbl_22.Rotation = 0
    tbl_24.Icon = createElement_upvr("ImageLabel", tbl_22)
    tbl_27.ArrowBottom = createElement_upvr("Frame", {
        BackgroundTransparency = 1;
        Size = UDim2.new(0.125 / var29, 0, 0.0625, 0);
        AnchorPoint = Vector2.new(0.5, 0.5);
        Position = UDim2.new(0.5, 0, 0.9805068226120858, 0);
        ZIndex = 3;
    }, tbl_24)
    module.Body = createElement_upvr("Frame", {
        BorderSizePixel = 0;
        BackgroundColor3 = Color3.new(0, 0, 0);
        BackgroundTransparency = 0;
        Position = UDim2.new(0.015625 / aspectRatio, 0, 0.1828125, 0);
        Size = UDim2.new(var28, 0, 0.8015625, 0);
    }, tbl_27)
    local tbl_23 = {}
    local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        tbl_10.Container = createElement_upvr("Frame", tbl_28, tbl_11)
        tbl_11.Text = createElement_upvr("TextLabel", tbl_4)
        tbl_4.TextColor3 = primaryColor
        tbl_4.TextScaled = var21
        var21 = true
        tbl_4.LineHeight = var21
        var21 = 1
        tbl_4.Font = var21
        var21 = Enum.Font.Bangers
        tbl_4.TextXAlignment = var21
        var21 = Enum.TextXAlignment.Right
        tbl_4.Text = var21
        var21 = arg1.props.config.extraText..' '
        tbl_4.AnchorPoint = var21
        var21 = Vector2.new(0.5, 0.5)
        tbl_4.Position = var21
        var21 = UDim2.new(0.5, 0, 0.5, 0)
        tbl_4.Size = var21
        var21 = UDim2.new(1, 0, 1, 0)
        tbl_4.BackgroundTransparency = var21
        var21 = 1
        local tbl_4 = {}
        local tbl_11 = {}
        tbl_28.Position = UDim2.new(0, 0, 0, var21)
        var21 = 0
        tbl_28.Size = UDim2.new(1, 0, 1, var21)
        var21 = 0
        tbl_28.BackgroundColor3 = Color3.new(1, 1, 1)
        tbl_28.BackgroundTransparency = 1
        tbl_28.BorderSizePixel = 0
        local tbl_28 = {}
        tbl_10.UICorner = createElement_upvr("UICorner", tbl_20)
        tbl_20.CornerRadius = UDim.new(0, 10)
        local tbl_20 = {}
        local tbl_10 = {}
        tbl_14.Position = UDim2.new(0, 0, 0, 0)
        tbl_14.Size = UDim2.new(1, 0, 1, 0)
        tbl_14.BackgroundColor3 = Color3.new(0, 0, 0)
        tbl_14.BorderSizePixel = 0
        local tbl_14 = {}
        return createElement_upvr("Frame", tbl_14, tbl_10)
    end
    if not arg1.props.config.extraText or not decompInlinedCondition_2() then
    end
    tbl_23.Title = nil
    module.Bottom = createElement_upvr("Frame", {
        BorderSizePixel = 0;
        BackgroundTransparency = 1;
        Position = UDim2.new(0.005, 0, 1, 0);
        Size = UDim2.new(var24, 0, 0.1515625, 0);
    }, tbl_23)
    return createElement_upvr("Frame", {
        BorderSizePixel = 0;
        BackgroundTransparency = 0.8;
        BackgroundColor3 = Color3.new(0, 0, 0);
        Size = arg1.props.size;
        Position = arg1.props.position;
        AnchorPoint = arg1.props.anchorPoint;
    }, module)
end
local RunService_upvr = game:GetService("RunService")
function any_extend_result1._spin(arg1) -- Line 347
    local winIndex = arg1.props.config.winIndex
    if #arg1.props.config.items - math.floor(arg1.props.colsPerRow * 0.5 + 0.5) < winIndex then
        warn("winIndex is > maxVisibleIndex, player will see empty space")
    end
    local os_clock_result1_upvr = os.clock()
    local duration_upvr = arg1.props.config.duration
    local var83_upvw = false
    local ceiled_upvr = math.ceil(arg1.props.colsPerRow * 0.5 + 0.5)
    local var85_upvw = winIndex + math.clamp(math.random() - 0.5, -0.48, 0.48)
    local var86_upvw = 0
    arg1.maid.spinHeartbeat = RunService_upvr.Heartbeat:Connect(function() -- Line 361
        local var87 = (os.clock() - os_clock_result1_upvr) / duration_upvr
        local var88
        if 1 <= var87 then
            var87 = 1
            if not var83_upvw then
                var83_upvw = true
                arg1.onFinished()
                if arg1.props.onFinished then
                    arg1.props.onFinished()
                end
                arg1.maid.spinHeartbeat = nil
                -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
            end
        else
            var83_upvw = false
        end
        var88 = var85_upvw - ceiled_upvr
        local var89 = ceiled_upvr + var88 * (1 - math.pow(1 - var87, 2))
        local var90 = var89 % 1
        var88 = var86_upvw
        if 0 >= var89 - var86_upvw then
            var88 = false
        else
            var88 = true
        end
        local function decompInlinedCondition_3() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            return 0.5 < var88 % 1
        end
        if var88 and 0.5 < var90 and var88 % 1 < 0.5 or not var88 and var90 < 0.5 and decompInlinedCondition_3() then
            arg1.playTick()
        end
        var86_upvw = var89
        arg1.updateIndex(var89)
    end)
end
function any_extend_result1.didMount(arg1) -- Line 399
    if arg1.props.config then
        arg1:_spin()
    end
end
function any_extend_result1.didUpdate(arg1, arg2, arg3) -- Line 404
    if arg1.props.config ~= arg2.config then
        arg1.openMaid:DoCleaning()
        if arg1.props.config then
            arg1:_spin()
        end
    end
end
function any_extend_result1.willUnmount(arg1) -- Line 412
    arg1.maid:DoCleaning()
end
return require(ReplicatedStorage_upvr.RoactRodux).connect(function(arg1, arg2) -- Line 415
    return {
        config = arg1.rewardSpinnerConfig;
    }
end, function(arg1) -- Line 419
    return {
        close = function() -- Line 421, Named "close"
            arg1({
                type = "setRewardSpinnerConfig";
                items = nil;
            })
        end;
    }
end)(any_extend_result1)
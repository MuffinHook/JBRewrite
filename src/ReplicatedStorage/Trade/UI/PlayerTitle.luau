local RunService_upvr = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("PlayerTitle")
any_extend_result1.defaultProps = {
    size = UDim2.new(1, 0, 1, 0);
    position = UDim2.new(0, 0, 0, 0);
    aspectRatio = 1;
    parentRatio = 1;
}
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Spring_upvr = require(ReplicatedStorage.Std.Spring)
function any_extend_result1.init(arg1) -- Line 15
    arg1.maid = Maid_upvr.new()
    arg1.spinSpring = Spring_upvr.new(0, 0, 0.8, 15)
    arg1.scaleSpring = Spring_upvr.new(1, 0, 0.5, 40)
    local any_createBinding_result1_2, any_createBinding_result2_2 = Roact_upvr.createBinding(0)
    arg1.spin = any_createBinding_result1_2
    arg1.updateSpin = any_createBinding_result2_2
    local any_createBinding_result1, any_createBinding_result2 = Roact_upvr.createBinding(1)
    arg1.scale = any_createBinding_result1
    arg1.updateScale = any_createBinding_result2
end
local createElement_upvr = Roact_upvr.createElement
function any_extend_result1.render(arg1) -- Line 22
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local aspectRatio_upvr = arg1.props.aspectRatio
    local var14 = arg1.props.size.X.Scale / arg1.props.size.Y.Scale
    local var15
    if arg1.props.size.X.Offset ~= 0 then
        var14 = false
    else
        var14 = true
    end
    assert(var14, "cannot support nonzero offset")
    if arg1.props.size.Y.Offset ~= 0 then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    assert(true, "cannot support nonzero offset")
    local module = {
        BackgroundTransparency = 1;
        BorderSizePixel = 0;
    }
    var15 = (arg1.props.size.Y.Scale) * (arg1.props.parentRatio * var14) * 1
    var15 = 0
    module.Size = UDim2.new(arg1.props.size.X.Scale, 0, var15 / aspectRatio_upvr, var15)
    module.Position = arg1.props.position
    local module_2 = {}
    local tbl_3 = {}
    var15 = 0
    tbl_3.BorderSizePixel = var15
    var15 = 1
    tbl_3.BackgroundTransparency = var15
    var15 = Color3.new(0.1, 0.1, 0.1)
    tbl_3.BackgroundColor3 = var15
    var15 = Vector2.new(0.5, 0.5)
    tbl_3.AnchorPoint = var15
    var15 = UDim2.new(0.5 / aspectRatio_upvr, 0, 0.5, 0)
    tbl_3.Position = var15
    var15 = arg1.scale
    var15 = var15:map(function(arg1_2) -- Line 40
        return UDim2.new(arg1_2 / aspectRatio_upvr, 0, arg1_2, 0)
    end)
    tbl_3.Size = var15
    if arg1.props.ready then
        var15 = "rbxassetid://9474441364"
    else
        var15 = arg1.props
        var15 = var15.userId
        if var15 then
            var15 = "rbxthumb://type=AvatarHeadShot&w=150&h=150&id=%d":format(arg1.props.userId)
        end
    end
    tbl_3.Image = var15
    var15 = arg1.spin
    tbl_3.Rotation = var15
    var15 = {}
    var15.UICorner = createElement_upvr("UICorner", {
        CornerRadius = UDim.new(1, 0);
    })
    module_2.Icon = createElement_upvr("ImageLabel", tbl_3, var15)
    local tbl_2 = {}
    var15 = 1
    tbl_2.BackgroundTransparency = var15
    var15 = Color3.new(1, 0, 0)
    tbl_2.BackgroundColor3 = var15
    var15 = UDim2.new(1 - 1 / aspectRatio_upvr - 0.0078125, 0, 1, 0)
    tbl_2.Size = var15
    var15 = UDim2.new(1 / aspectRatio_upvr + 0.0078125, 0, 0, 0)
    tbl_2.Position = var15
    var15 = {}
    local tbl = {
        BackgroundTransparency = 1;
        Size = UDim2.new(1, 0, 1, 0);
        Position = UDim2.new(0.5, 0, 0.5, 0);
        AnchorPoint = Vector2.new(0.5, 0.5);
    }
    if not arg1.props.ready or not Color3.fromRGB(0, 200, 90) then
    end
    tbl.TextColor3 = Color3.new(1, 1, 1)
    tbl.Text = arg1.props.displayName
    tbl.TextXAlignment = Enum.TextXAlignment.Left
    tbl.Font = Enum.Font.Bangers
    tbl.LineHeight = 1
    tbl.TextScaled = true
    var15.Text = createElement_upvr("TextLabel", tbl)
    module_2.Title = createElement_upvr("Frame", tbl_2, var15)
    do
        return createElement_upvr("Frame", module, module_2)
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function any_extend_result1.PopIcon(arg1) -- Line 75
    arg1.scaleSpring:Accelerate(15)
    local Target_upvr = arg1.scaleSpring.Target
    arg1.maid.scaleHeartbeat = RunService_upvr.Heartbeat:Connect(function() -- Line 78
        local any_Update_result1_2, any_Update_result2 = arg1.scaleSpring:Update()
        local var27
        if math.abs(Target_upvr - any_Update_result1_2) < 0.001 and math.abs(any_Update_result2) < 0.001 then
            arg1.maid.scaleHeartbeat = nil
            var27 = Target_upvr
        end
        arg1.updateScale(var27)
    end)
end
function any_extend_result1.SpinIcon(arg1) -- Line 87
    arg1.spinSpring:SetTarget(360)
    arg1.spinSpring.p = 0
    arg1.maid.spinHeartbeat = RunService_upvr.Heartbeat:Connect(function() -- Line 91
        local any_Update_result1, any_Update_result2_2 = arg1.spinSpring:Update()
        local var31
        if math.abs(360 - any_Update_result1) < 0.001 and math.abs(any_Update_result2_2) < 0.001 then
            arg1.maid.spinHeartbeat = nil
            var31 = 0
        end
        arg1.updateSpin(var31)
    end)
end
function any_extend_result1.didUpdate(arg1, arg2, arg3) -- Line 100
    if arg1.props.ready ~= arg2.ready and arg1.props.ready then
        arg1:SpinIcon()
        arg1:PopIcon()
    end
end
return any_extend_result1
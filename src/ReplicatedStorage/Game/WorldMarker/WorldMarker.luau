local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local function _() -- Line 13, Named "GetRootPart"
    local Character = LocalPlayer_upvr.Character
    if Character == nil then
        return nil
    end
    local Humanoid = Character:FindFirstChild("Humanoid")
    if Humanoid == nil then
        return nil
    end
    return Humanoid.RootPart
end
local tbl_upvr = {{4, 0}, {48, 0}, {192, 24}, {math.huge, 8}}
local module_2_upvr = {}
module_2_upvr.__index = module_2_upvr
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function module_2_upvr.new() -- Line 31
    local module = {}
    setmetatable(module, module_2_upvr)
    module._maid = Maid_upvr.new()
    module.ScreenGui = nil
    module.Position = nil
    module.Radius = 8
    module.AnimRadius = nil
    module.StartRadius = nil
    module.EndRadius = nil
    module.Enabled = false
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.BorderSizePixel = 0
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.ImageColor3 = Color3.new(0, 0, 0)
    ImageLabel.Image = "rbxassetid://2819326547"
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel.ZIndex = 1
    ImageLabel.Name = "WorldMarker"
    module.Frame = ImageLabel
    module._maid:GiveTask(module.Frame)
    local ImageLabel_2 = Instance.new("ImageLabel")
    ImageLabel_2.BorderSizePixel = 0
    ImageLabel_2.BackgroundTransparency = 1
    ImageLabel_2.ImageColor3 = Color3.new(0.1, 0.1, 0.1)
    ImageLabel_2.Image = "rbxassetid://2819326547"
    ImageLabel_2.Size = UDim2.new(0.85, 0, 0.85, 0)
    ImageLabel_2.Position = UDim2.new(0.5, 0, 0.5, 0)
    ImageLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel_2.ZIndex = 2
    ImageLabel_2.Parent = ImageLabel
    module.FrameInner = ImageLabel_2
    module:SetSizes(tbl_upvr)
    module:SetRadius(module.Radius)
    module:SetEnabled(true)
    return module
end
function module_2_upvr.SetSizes(arg1, arg2) -- Line 78
    if not arg2 then
    end
    arg1._sizes = tbl_upvr
end
function module_2_upvr.SetEnabled(arg1, arg2) -- Line 85
    arg1.Enabled = arg2
    arg1.Frame.Visible = arg2
    if arg1.Frame.Name == "ImportantLocationMarker" then
        print("setting enabled", arg2)
    end
end
function module_2_upvr.SetScreenGui(arg1, arg2) -- Line 92
    arg1.ScreenGui = arg2
    arg1.Frame.Parent = arg1.ScreenGui
end
function module_2_upvr.CreateFrameIcon(arg1) -- Line 97
    local var14
    if arg1.FrameIcon ~= nil then
        var14 = false
    else
        var14 = true
    end
    assert(var14)
    var14 = "ImageLabel"
    local any = Instance.new(var14)
    var14 = 0
    any.BorderSizePixel = var14
    var14 = 1
    any.BackgroundTransparency = var14
    var14 = UDim2.new(1, 0, 1, 0)
    any.Size = var14
    var14 = UDim2.new(0.5, 0, 0.5, 0)
    any.Position = var14
    var14 = Vector2.new(0.5, 0.5)
    any.AnchorPoint = var14
    var14 = 3
    any.ZIndex = var14
    var14 = arg1.FrameInner
    any.Parent = var14
    arg1.FrameIcon = any
end
function module_2_upvr.DestroyFrameIcon(arg1) -- Line 109
    local var16
    if arg1.FrameIcon == nil then
        var16 = false
    else
        var16 = true
    end
    assert(var16)
    arg1.FrameIcon:Destroy()
    arg1.FrameIcon = nil
end
function module_2_upvr.SetIcon(arg1, arg2, arg3) -- Line 114
    if arg2 ~= nil then
        if arg1.FrameIcon == nil then
            arg1:CreateFrameIcon()
        end
        arg1.FrameIcon.Image = ("rbxassetid://%d"):format(arg2)
        if arg3 then
            arg1.FrameIcon.ImageColor3 = arg3
        end
        arg1:SetRadius(arg1.Radius)
    elseif arg1.FrameIcon ~= nil then
        arg1:DestroyFrameIcon()
    end
end
function module_2_upvr.SetPosition(arg1, arg2) -- Line 132
    arg1.Position = arg2
end
function module_2_upvr.GetPosition(arg1) -- Line 135
    return arg1.Position
end
function module_2_upvr.SetRadius(arg1, arg2) -- Line 138
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    arg1.Radius = arg2
    arg1.Frame.Size = UDim2.new(0, 2 * arg2, 0, 2 * arg2)
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if arg1.FrameIcon.Visible == false then
        arg1.FrameIcon.Visible = true
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local Anim_upvr = require(ReplicatedStorage.Module.Anim)
function module_2_upvr.AnimateRadius(arg1, arg2) -- Line 154
    if arg1.AnimRadius ~= nil then
        arg1.AnimRadius:Destroy()
        arg1.AnimRadius = nil
    end
    arg1.StartRadius = arg1.Radius
    arg1.EndRadius = arg2
    local any_new_result1 = Anim_upvr.new(0.1)
    any_new_result1.OnCompleted:Connect(function() -- Line 163
        arg1.AnimRadius:Destroy()
        arg1.AnimRadius = nil
        arg1:SetRadius(arg1.EndRadius)
    end)
    arg1.AnimRadius = any_new_result1
end
function module_2_upvr.SetAdornee(arg1, arg2) -- Line 171
    arg1._adornee = arg2
    arg1.Position = arg1._adornee.Position
end
function module_2_upvr.GetAdornee(arg1) -- Line 175
    return arg1._adornee
end
local CurrentCamera_upvr = workspace.CurrentCamera
function module_2_upvr.Update(arg1) -- Line 178
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local var21
    if not arg1.Enabled then return end
    local AbsoluteSize = arg1.ScreenGui.AbsoluteSize
    local X = AbsoluteSize.X
    local Y = AbsoluteSize.Y
    if arg1._adornee then
        arg1.Position = arg1._adornee.Position
    end
    if not arg1.Position then return end
    local any_WorldToViewportPoint_result1 = CurrentCamera_upvr:WorldToViewportPoint(arg1.Position)
    var21 = any_WorldToViewportPoint_result1.X
    if any_WorldToViewportPoint_result1.Z >= 0 then
    else
    end
    local var26 = arg1.Radius + 4
    local var27 = arg1.Radius + 4
    if var21 < var26 then
        var21 = var26
    end
    if X - var26 < var21 then
        var21 = X - var26
    end
    if any_WorldToViewportPoint_result1.Y < var27 then
    end
    if Y - var27 < var27 then
        local var28 = Y - var27
    end
    if true then
        local var29 = var21
        local var30 = var28
        var21 = X - var21
        local var31 = Y - var28
        if math.min(var21, var29) < math.min(var31, var30) then
            if var21 < var29 then
                var21 = var26
            else
                var21 = X - var26
            end
        elseif var31 < var30 then
        else
        end
    end
    arg1.Frame.Position = UDim2.new(0, var21, 0, Y - var27)
    local Character_2 = LocalPlayer_upvr.Character
    if Character_2 == nil then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    local Humanoid_2 = Character_2:FindFirstChild("Humanoid")
    if Humanoid_2 == nil then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    local RootPart = Humanoid_2.RootPart
    if RootPart then
    end
    if true then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    local _ = 2
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [161.51184059]
    if (RootPart.Position - arg1.Position).Magnitude <= arg1._sizes then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_2_upvr.Destroy(arg1) -- Line 275
    arg1._maid:Destroy()
    arg1._maid = nil
    arg1.ScreenGui = nil
    arg1.Position = nil
    setmetatable(arg1, nil)
end
return module_2_upvr

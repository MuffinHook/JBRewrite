local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_upvr = {}
module_upvr.__index = module_upvr
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Spring_upvr = require(ReplicatedStorage.Std.Spring)
function module_upvr.new() -- Line 10
    local module = {}
    setmetatable(module, module_upvr)
    module._maid = Maid_upvr.new()
    module._springActive = Spring_upvr.new(0, 0, 0.8, 1)
    module._targetColor = Color3.fromRGB(255, 255, 255)
    module:_createFx()
    return module
end
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
function module_upvr._createFx(arg1) -- Line 24
    local BlurEffect = Instance.new("BlurEffect")
    BlurEffect.Size = 0
    BlurEffect.Enabled = false
    BlurEffect.Parent = game:GetService("Lighting")
    arg1._blur = BlurEffect
    arg1._maid:GiveTask(arg1._blur)
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")
    ColorCorrectionEffect.Enabled = false
    ColorCorrectionEffect.Parent = game:GetService("Lighting")
    arg1._colorCorrection = ColorCorrectionEffect
    arg1._maid:GiveTask(arg1._colorCorrection)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.Parent = LocalPlayer_upvr.PlayerGui
    arg1._maid:GiveTask(ScreenGui)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 1, 0)
    Frame.BackgroundColor3 = arg1._targetColor
    Frame.Visible = false
    Frame.Parent = ScreenGui
    arg1._colorFrame = Frame
end
function module_upvr.SetActive(arg1, arg2) -- Line 50
    local var11
    if arg2 then
        var11 = 1
    else
        var11 = 0
    end
    arg1._springActive:SetTarget(var11)
end
function module_upvr.Update(arg1) -- Line 53
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local any_Update_result1, _ = arg1._springActive:Update()
    local var14
    if 0.001 > any_Update_result1 then
        var14 = false
    else
        var14 = true
    end
    if var14 then
        arg1._blur.Size = math.max(0, 1 - math.abs(any_Update_result1 * 2 / 0.2 - 1)) * 15
        local var15 = 1 - any_Update_result1 * 0.01
        if var15 < 0.999 then
            arg1._colorFrame.Visible = true
        else
            arg1._colorFrame.Visible = false
        end
        arg1._colorFrame.Transparency = var15
    end
    if arg1._blur.Enabled ~= var14 then
        arg1._blur.Enabled = var14
    end
    if 0.001 >= any_Update_result1 then
        local _ = false
        -- KONSTANTWARNING: Skipped task `defvar` above
    else
    end
    if true then
        arg1._colorCorrection.Saturation = 1 * any_Update_result1
        arg1._colorCorrection.TintColor = Color3.new(1, 1, 1):lerp(arg1._targetColor, any_Update_result1)
    end
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    if arg1._colorCorrection.Enabled ~= true then
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        arg1._colorCorrection.Enabled = true
    end
end
function module_upvr.Destroy(arg1) -- Line 85
    arg1._maid = nil
    arg1._maid:Destroy()
    setmetatable(arg1, nil)
end
return module_upvr
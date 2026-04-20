local module_upvr = {}
module_upvr.__index = module_upvr
local function _makeFadeGui_upvr() -- Line 10, Named "_makeFadeGui"
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.DisplayOrder = 100
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ClipToDeviceSafeArea = false
    ScreenGui.ScreenInsets = Enum.ScreenInsets.None
    ScreenGui.SafeAreaCompatibility = Enum.SafeAreaCompatibility.None
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Name = "_Fade"
    local Frame = Instance.new("Frame")
    Frame.Position = UDim2.fromScale(0, 0)
    Frame.Size = UDim2.fromScale(1, 1)
    Frame.BorderSizePixel = 0
    Frame.Interactable = false
    Frame.BackgroundTransparency = 1
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame.Parent = ScreenGui
    return ScreenGui, Frame
end
local Maid_upvr = require(game:GetService("ReplicatedStorage").Std.Maid)
local Players_upvr = game:GetService("Players")
function module_upvr.new() -- Line 29
    local module = {}
    setmetatable(module, module_upvr)
    module.maid = Maid_upvr.new()
    local _makeFadeGui_result1, _makeFadeGui_result2 = _makeFadeGui_upvr()
    module.maid:GiveTask(_makeFadeGui_result1)
    _makeFadeGui_result1.Parent = Players_upvr.LocalPlayer.PlayerGui
    module.frame = _makeFadeGui_result2
    return module
end
local TweenService_upvr = game:GetService("TweenService")
function module_upvr._FadeTo(arg1, arg2, arg3) -- Line 43
    if arg1._tween then
        arg1._tween:Cancel()
    end
    local tbl = {}
    tbl.BackgroundTransparency = arg2
    arg1._tween = TweenService_upvr:Create(arg1.frame, arg3, tbl)
    arg1._tween:Play()
end
function module_upvr.FadeToLinear(arg1, arg2, arg3) -- Line 56
    arg1:_FadeTo(arg2, TweenInfo.new(arg3, 0))
end
function module_upvr.Set(arg1, arg2) -- Line 60
    if arg1._tween then
        arg1._tween:Cancel()
    end
    arg1.frame.BackgroundTransparency = arg2
end
function module_upvr.Destroy(arg1) -- Line 67
    arg1.maid:Destroy()
    setmetatable(arg1, nil)
end
return module_upvr
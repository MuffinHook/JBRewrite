local ReplicatedStorage = game:GetService("ReplicatedStorage")
local function _(arg1) -- Line 6, Named "Ease_InOutQuad"
    local var2
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var2 = 2 * arg1 * arg1
        return var2
    end
    if arg1 >= 0.5 or not decompInlinedCondition() then
        var2 = -1 - 2 * (arg1 - 2) * arg1
    end
    return var2
end
local module_2_upvr = {}
module_2_upvr.__index = module_2_upvr
local Signal_upvr = require(ReplicatedStorage.Std.Signal)
function module_2_upvr.new(arg1) -- Line 12
    if arg1 == nil then
    else
    end
    assert(true)
    local module = {}
    setmetatable(module, module_2_upvr)
    module.Model = arg1
    module.Door1CF = module.Model.Door1.CFrame
    module.Door2CF = module.Model.Door2.CFrame
    module.OnOpened = Signal_upvr.new()
    module.Anim = nil
    module.IsOpen = false
    return module
end
local Anim_upvr = require(ReplicatedStorage.Module.Anim)
local RunService_upvr = game:GetService("RunService")
function module_2_upvr.Transition(arg1, arg2, arg3) -- Line 28
    if arg1.Anim ~= nil then
        arg1.Anim:Destroy()
    end
    arg1.Anim = Anim_upvr.new(arg2 or 6)
    arg1.Anim.OnCompleted:Connect(function() -- Line 34
        arg1.Anim:Destroy()
        arg1.Anim = nil
    end)
    arg1.Anim.OnCanceled:Connect(function() -- Line 38
        arg1.Anim:Destroy()
        arg1.Anim = nil
    end)
    arg1.Anim.Maid:GiveTask(RunService_upvr.RenderStepped:Connect(function() -- Line 42
        arg3(arg1, arg1.Anim:Update())
    end))
end
function module_2_upvr.Open(arg1, arg2) -- Line 47
    arg1.IsOpen = true
    return arg1:Transition(arg2, arg1.SeqOpen)
end
function module_2_upvr.Close(arg1, arg2) -- Line 51
    arg1.IsOpen = false
    return arg1:Transition(arg2, arg1.SeqClose)
end
function module_2_upvr.SetDoorOpen(arg1, arg2) -- Line 55
    local Model = arg1.Model
    local Door1 = Model.Door1
    local cframe_2 = CFrame.new(0, 0, -Door1.Size.Z * 0.5)
    Door1.CFrame = arg1.Door1CF * cframe_2 * CFrame.Angles(arg2 * math.pi * 0.5, 0, 0) * cframe_2:Inverse()
    local Door2 = Model.Door2
    local cframe = CFrame.new(0, 0, -Door2.Size.Z * 0.5)
    Door2.CFrame = arg1.Door2CF * cframe * CFrame.Angles(arg2 * math.pi * 0.5, 0, 0) * cframe:Inverse()
end
function module_2_upvr.SeqOpen(arg1, arg2) -- Line 65
    if arg2 == 1 then
        arg1.OnOpened:Fire()
    end
    local var16 = arg2
    if var16 >= 0.5 or not (2 * var16 * var16) then
    end
    arg1:SetDoorOpen(-1 - 2 * (var16 - 2) * var16)
end
function module_2_upvr.SeqClose(arg1, arg2) -- Line 72
    local var17 = 1 - arg2
    local var18
    local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var18 = 2 * var17 * var17
        return var18
    end
    if var17 >= 0.5 or not decompInlinedCondition_2() then
        var18 = -1 - 2 * (var17 - 2) * var17
    end
    arg1:SetDoorOpen(var18)
end
function module_2_upvr.Destroy(arg1) -- Line 76
    if arg1.Anim ~= nil then
        arg1.Anim:Destroy()
        arg1.Anim = nil
    end
    arg1.OnOpened:Destroy()
    arg1.OnOpened = nil
end
return module_2_upvr
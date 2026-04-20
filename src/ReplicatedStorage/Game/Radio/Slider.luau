local UserInputService_upvr = game:GetService("UserInputService")
local RunService_upvr = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_upvr = {}
module_upvr.__index = module_upvr
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Spring_upvr = require(ReplicatedStorage.Std.Spring)
local Signal_upvr = require(ReplicatedStorage.Std.Signal)
function module_upvr.new(arg1) -- Line 11
    assert(arg1)
    local module = {}
    setmetatable(module, module_upvr)
    module.Gui = arg1
    module.Maid = Maid_upvr.new()
    module.Value = 0
    module.SpringSlider = Spring_upvr.new(module.Value, 0, 0.8, 50)
    module.OnValueChanged = Signal_upvr.new()
    module:Setup()
    module:UpdatePosition(module.Value)
    return module
end
function module_upvr.Setup(arg1) -- Line 27
    local function StartDragger_upvr(arg1_2) -- Line 29, Named "StartDragger"
        arg1.Maid.DragHeartbeat = RunService_upvr.Heartbeat:Connect(function() -- Line 30
            arg1.Value = arg1:GetMouseValue()
            if arg1.Value ~= arg1.Value then
                arg1.OnValueChanged:Fire(arg1.Value)
                if arg1.Maid.PositionHeartbeat == nil then
                    arg1:StartUpdateThread()
                end
            end
        end)
        if not arg1_2 then
            arg1.Maid.DragEnd = UserInputService_upvr.InputEnded:Connect(function(arg1_3) -- Line 41
                if arg1_3.UserInputType == Enum.UserInputType.MouseButton1 or arg1_3.UserInputType == Enum.UserInputType.Touch then
                    arg1.Maid.DragHeartbeat = nil
                    arg1.Maid.DragEnd = nil
                end
            end)
        else
            arg1.Maid.DragEnd = arg1_2:GetPropertyChangedSignal("UserInputState"):Connect(function() -- Line 51
                if arg1_2.UserInputState == Enum.UserInputState.End then
                    arg1.Maid.DragHeartbeat = nil
                    arg1.Maid.DragEnd = nil
                end
            end)
        end
    end
    arg1.Maid:GiveTask(arg1.Gui.ContainerKnob.Knob.InputBegan:Connect(function(arg1_4, arg2) -- Line 62
        if arg2 then
        elseif arg1_4.UserInputType == Enum.UserInputType.MouseButton1 or arg1_4.UserInputType == Enum.UserInputType.Touch then
            arg1.Value = arg1:GetMouseValue()
            arg1.OnValueChanged:Fire(arg1.Value)
            if arg1.Maid.PositionHeartbeat == nil then
                arg1:StartUpdateThread()
            end
            StartDragger_upvr(arg1_4)
        end
    end))
end
local GuiService_upvr = game:GetService("GuiService")
function module_upvr.GetMouseValue(arg1) -- Line 76
    local ContainerKnob = arg1.Gui.ContainerKnob
    return math.clamp(math.floor(((UserInputService_upvr:GetMouseLocation() - ContainerKnob.AbsolutePosition - GuiService_upvr:GetGuiInset()) / ContainerKnob.AbsoluteSize).X * 24 + 0.5) / 24, 0, 1)
end
function module_upvr.SetValue(arg1, arg2) -- Line 86
    arg1.Value = arg2
    arg1.SpringSlider.p = arg2
    arg1.SpringSlider:SetTarget(arg2)
    arg1:UpdatePosition(arg2)
    arg1.OnValueChanged:Fire(arg2)
end
function module_upvr.StartUpdateThread(arg1) -- Line 93
    local var15
    if arg1.Maid.PositionHeartbeat ~= nil then
        var15 = false
    else
        var15 = true
    end
    assert(var15)
    var15 = RunService_upvr
    var15 = var15.Heartbeat
    var15 = var15:Connect(function() -- Line 95
        local any_SetTarget_result1, any_SetTarget_result2 = arg1.SpringSlider:SetTarget(arg1.Value)
        arg1:UpdatePosition(any_SetTarget_result1)
        if math.abs(arg1.Value - any_SetTarget_result1) < 0.001 and math.abs(any_SetTarget_result2) < 0.001 then
            arg1.Maid.PositionHeartbeat = nil
        end
    end)
    arg1.Maid.PositionHeartbeat = var15
end
function module_upvr.UpdatePosition(arg1, arg2) -- Line 103
    arg1.Gui.ContainerKnob.Knob.Position = UDim2.new(arg2, 0, 0.5, 0)
end
function module_upvr.Destroy(arg1) -- Line 107
    arg1.Gui = nil
    arg1.Maid:Destroy()
    arg1.Maid = nil
end
return module_upvr
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module_upvr = {
    _maid = nil;
    onCloseClicked = require(ReplicatedStorage_upvr.Std.Signal).new();
}
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local WorldMarkerGroup_upvr = require(ReplicatedStorage_upvr.Game.WorldMarker.WorldMarkerGroup)
local WorldMarker_upvr = require(ReplicatedStorage_upvr.Game.WorldMarker.WorldMarker)
local WorldMarkerSystem_upvr = require(ReplicatedStorage_upvr.Game.WorldMarker.WorldMarkerSystem)
function module_upvr.init() -- Line 16
    local ContextMessageGui = ReplicatedStorage_upvr.StarterGui:FindFirstChild("ContextMessageGui")
    ContextMessageGui.Parent = LocalPlayer_upvr.PlayerGui
    module_upvr.gui = ContextMessageGui
    local any_new_result1 = WorldMarkerGroup_upvr.new()
    any_new_result1:SetEnabled(false)
    module_upvr._worldMarkerGroup = any_new_result1
    local any_new_result1_2 = WorldMarker_upvr.new()
    any_new_result1_2:SetScreenGui(WorldMarkerSystem_upvr.gui)
    any_new_result1_2:SetIcon(5920742944)
    any_new_result1_2.FrameInner.ImageColor3 = Color3.fromRGB(255, 203, 70)
    any_new_result1:Add(any_new_result1_2)
    WorldMarkerSystem_upvr.addGroup(any_new_result1)
    module_upvr._worldMarker = any_new_result1_2
end
local Maid_upvr = require(ReplicatedStorage_upvr.Std.Maid)
function module_upvr.open() -- Line 35
    local var11_upvr
    if module_upvr._maid ~= nil then
        var11_upvr = false
    else
        var11_upvr = true
    end
    assert(var11_upvr)
    local any_new_result1_3 = Maid_upvr.new()
    var11_upvr = module_upvr
    var11_upvr._maid = any_new_result1_3
    var11_upvr = module_upvr
    var11_upvr = var11_upvr.gui
    var11_upvr.Enabled = true
    any_new_result1_3:GiveTask(function() -- Line 42
        var11_upvr.Enabled = false
    end)
    any_new_result1_3:GiveTask(function() -- Line 45
        module_upvr.setWorldMarkerEnabled(false)
    end)
    any_new_result1_3:GiveTask(var11_upvr.Container.Close.MouseButton1Down:Connect(function() -- Line 49
        module_upvr.onCloseClicked:Fire()
        module_upvr.close()
    end))
end
function module_upvr.close() -- Line 54
    local var16
    if module_upvr._maid == nil then
        var16 = false
    else
        var16 = true
    end
    assert(var16)
    var16 = module_upvr
    var16._maid = nil
    var16 = module_upvr._maid:Destroy
    var16()
end
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
function module_upvr.setMessage(arg1) -- Line 61
    local gui = module_upvr.gui
    gui.Container.Container.Message.Text = arg1
    Audio_upvr.ObjectLocal(gui, 131184732929614)
end
function module_upvr.setWorldMarkerEnabled(arg1) -- Line 68
    module_upvr._worldMarkerGroup:SetEnabled(arg1)
end
function module_upvr.setWorldMarkerPosition(arg1) -- Line 71
    module_upvr._worldMarker:SetPosition(arg1)
end
function module_upvr.setWorldMarkerSizes(arg1) -- Line 74
    module_upvr._worldMarker:SetSizes(arg1)
end
function module_upvr.isOpen() -- Line 77
    local var19
    if module_upvr._maid == nil then
        var19 = false
    else
        var19 = true
    end
    return var19
end
return module_upvr
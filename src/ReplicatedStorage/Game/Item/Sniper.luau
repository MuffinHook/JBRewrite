local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
local ItemCamera_upvr = require(ReplicatedStorage_upvr.Game.ItemSystem.ItemCamera)
local Gun_upvr = require(script.Parent.Gun)
local module_upvr = {
    __ClassName = "Sniper";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Gun_upvr)
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local Lighting_upvr = game:GetService("Lighting")
local Spring_upvr = require(ReplicatedStorage_upvr.Std.Spring)
function module_upvr.new(arg1, arg2, arg3) -- Line 32
    local any_new_result1 = Gun_upvr.new(arg1, arg2, arg3)
    setmetatable(any_new_result1, module_upvr)
    any_new_result1:Setup(arg3)
    if any_new_result1.Local then
        local ScopeGui = ReplicatedStorage_upvr.Resource.ItemSystem.Gui.ScopeGui
        assert(ScopeGui)
        local clone = ScopeGui:Clone()
        clone.ScreenInsets = Enum.ScreenInsets.None
        clone.DisplayOrder = -1
        clone.Enabled = false
        clone.Parent = LocalPlayer_upvr.PlayerGui
        any_new_result1.ScopeGui = clone
        any_new_result1.Maid:GiveTask(clone)
        local BlurEffect = Instance.new("BlurEffect")
        BlurEffect.Size = 0
        BlurEffect.Enabled = false
        BlurEffect.Parent = Lighting_upvr
        any_new_result1.Blur = BlurEffect
        any_new_result1.Maid:GiveTask(BlurEffect)
        any_new_result1.SpringBlur = Spring_upvr.new(0, 0, 0.8, 5)
    end
    return any_new_result1
end
function module_upvr.Heartbeat(arg1) -- Line 60
    if arg1.Local then
        local any_Update_result1 = arg1.SpringBlur:Update()
        if 0.01 <= any_Update_result1 and arg1.IsScoping then
            if arg1.Blur.Enabled == false then
                arg1.Blur.Enabled = true
            end
            arg1.Blur.Size = any_Update_result1
            return
        end
        if arg1.Blur.Enabled == true then
            arg1.Blur.Enabled = false
        end
    end
end
function module_upvr.ShootSound(arg1, arg2) -- Line 75
    if arg2 then
    else
        Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.shoot, {
            Pitch = 1 + math.random() * 0.1 - 0.05;
            Volume = 0.6;
        })
    end
end
function module_upvr.ScopeBegin(arg1) -- Line 82
    if Gun_upvr.ScopeBegin(arg1) == false then
        return false
    end
    Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.scope)
    if arg1.Local then
        arg1._cameraSensitivity = ItemCamera_upvr.getSensitivity()
        ItemCamera_upvr.setSensitivity(arg1._cameraSensitivity * 0.05)
        arg1._CameraDistance = ItemCamera_upvr.GetCameraDistance()
        ItemCamera_upvr.SetCameraDistance(0)
        arg1.ScopeGui.Enabled = true
        arg1.SpringBlur:Accelerate(500)
    end
end
function module_upvr.ScopeEnd(arg1) -- Line 96
    if Gun_upvr.ScopeEnd(arg1) == false then
        return false
    end
    if arg1.Local then
        if arg1._CameraDistance ~= nil then
            ItemCamera_upvr.SetCameraDistance(arg1._CameraDistance)
            arg1._CameraDistance = nil
        end
        if arg1._cameraSensitivity ~= nil then
            ItemCamera_upvr.setSensitivity(arg1._cameraSensitivity)
            arg1._cameraSensitivity = nil
        end
        arg1.ScopeGui.Enabled = false
    end
end
function module_upvr.ReloadDropAmmoVisual(arg1) -- Line 112
end
function module_upvr.ReloadRefillAmmoVisual(arg1) -- Line 113
end
function module_upvr.ReloadDropAmmoSound(arg1) -- Line 114
    Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.mag_out, {
        RollOffMaxDistance = 129;
    })
end
function module_upvr.ReloadRefillAmmoSound(arg1) -- Line 119
    Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.mag_in, {
        RollOffMaxDistance = 129;
    })
    wait(0.5)
    Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.cock, {
        RollOffMaxDistance = 129;
    })
    wait(0.2)
end
return module_upvr
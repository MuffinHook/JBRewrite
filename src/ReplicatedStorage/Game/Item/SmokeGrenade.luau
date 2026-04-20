local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SmokeGrenadeBinder_upvr = require(ReplicatedStorage.Game.SmokeGrenade.SmokeGrenadeBinder)
local Gun_upvr = require(script.Parent.Gun)
local function getThrowableSmokeGrenade_upvr(arg1) -- Line 12, Named "getThrowableSmokeGrenade"
    for _, v in ipairs(SmokeGrenadeBinder_upvr:GetAll()) do
        if v:GetCreator() == arg1 and not v:GetThrown() then
            return v
        end
    end
end
local function getNumActiveSmokeGrenade_upvr(arg1) -- Line 22, Named "getNumActiveSmokeGrenade"
    local var16
    for _, v_2 in ipairs(SmokeGrenadeBinder_upvr:GetAll()) do
        if v_2:GetCreator() == arg1 and v_2:GetThrown() then
            var16 += 1
        end
    end
    return var16
end
local function _() -- Line 34, Named "randomVector"
    return Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit
end
local var17_upvw
local module_upvr = {
    __ClassName = "SmokeGrenade";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Gun_upvr)
function module_upvr.Init(arg1) -- Line 44
    var17_upvw = arg1.Event
end
function module_upvr.new(arg1, arg2, arg3) -- Line 47
    local any_new_result1 = Gun_upvr.new(arg1, arg2, arg3)
    setmetatable(any_new_result1, module_upvr)
    any_new_result1:Setup(arg3)
    return any_new_result1
end
module_upvr.ApplySkin = false
function module_upvr.SetupArmWelds(arg1) -- Line 55
end
function module_upvr.UpdateArmIK(arg1) -- Line 56
    local IK = arg1.IK
    IK.RightArm = arg1.Model.Model.Hold.Position
    IK.RightAngle = arg1.Config.Motion.RightElbowAngle
end
function module_upvr.SetupTip(arg1) -- Line 62
    arg1.TipOffset = Vector3.new()
end
function module_upvr.BulletEmitterOnLocalHitPlayer(arg1) -- Line 65
end
local Notification_upvr = require(ReplicatedStorage.Game.Notification)
local SimulatedPhysicsProjectile_upvr = require(ReplicatedStorage.Module.SimulatedPhysicsProjectile)
function module_upvr.ShootBegin(arg1, arg2) -- Line 66
    local var23
    if arg1.Local then
        if 1 <= getNumActiveSmokeGrenade_upvr(arg1.Player) then
            Notification_upvr.new({
                Text = "Only one active smoke grenade allowed at a time.";
            })
            error("Too many SmokeGrenade, detonate before launching more.")
        end
        var23 = getThrowableSmokeGrenade_upvr(arg1.Player)
        if not var23 then
            error("No throwable SmokeGrenade left in pool")
        end
    end
    if not arg1:ShootCheckConditions() then
        return false
    end
    if arg1.Local then
        local var25 = arg1.UpperTorso.CFrame * Vector3.new(0, 0, -2)
        local any_CalculateVelocityToHitTargetWithSpeed_result1, _ = SimulatedPhysicsProjectile_upvr.CalculateVelocityToHitTargetWithSpeed(var25, arg1.MousePosition, 100, workspace.Gravity, false)
        var23._obj.PrimaryPart.Anchored = false
        var23._obj:SetPrimaryPartCFrame(CFrame.new(var25, var25 + any_CalculateVelocityToHitTargetWithSpeed_result1))
        var23:SetVelocity(any_CalculateVelocityToHitTargetWithSpeed_result1)
        var23:SetRotVelocity(-0.25 * any_CalculateVelocityToHitTargetWithSpeed_result1:Cross(Vector3.new(0, 1, 0)) + Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit * 5)
        var23:SetThrown(true)
        var23._maid:GiveTask(function() -- Line 99
        end)
        arg1:SetNextShotPossible()
        arg1:DecrementAmmo()
        var17_upvw:FireServer('u'.."jee9w33kp2w":sub(5, 7):reverse():reverse():reverse().."".."".."h4oce":sub(3, 4):reverse():reverse():reverse().."".."".."p29p3a":sub(3, 3):reverse()..""..'2')
        arg1:ReloadDropAmmoVisual()
        delay(0.1, function() -- Line 109
            if arg1.Destroyed then
                return false
            end
            arg1:ReloadRefillAmmoVisual()
        end)
    end
    if arg1.Local then
        arg1:BroadcastInputBegan(arg2)
    end
end
function module_upvr.ShootEnd(arg1, arg2) -- Line 121
    if arg1.Local then
        arg1:BroadcastInputEnded(arg2)
    end
end
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
function module_upvr.ShootSound(arg1, arg2) -- Line 126
    if arg2 then
        Audio_upvr.ObjectLocal(arg1.Model.Skeleton.BoundingBox, 2121005402)
    end
end
module_upvr.ScopeBegin = false
module_upvr.ScopeEnd = false
module_upvr.Reload = false
return module_upvr
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local C4Binder_upvr = require(ReplicatedStorage.Game.C4.C4Binder)
local Gun_upvr = require(script.Parent.Gun)
local function getDetonatableC4_upvr(arg1) -- Line 13, Named "getDetonatableC4"
    for _, v in ipairs(C4Binder_upvr:GetAll()) do
        if v:GetCreator() == arg1 and not v:IsListening() and not v:GetDetonated() and v:GetStuck() then
            return v
        end
    end
end
local function getThrowableC4_upvr(arg1) -- Line 23, Named "getThrowableC4"
    for _, v_2 in ipairs(C4Binder_upvr:GetAll()) do
        if v_2:GetCreator() == arg1 and not v_2:IsListening() and not v_2:GetDetonated() and not v_2:GetStuck() then
            return v_2
        end
    end
end
local function getNumActiveC4_upvr(arg1) -- Line 33, Named "getNumActiveC4"
    local var21
    for _, v_3 in ipairs(C4Binder_upvr:GetAll()) do
        if v_3:GetCreator() == arg1 and (v_3:IsListening() or v_3:GetStuck()) then
            var21 += 1
        end
    end
    return var21
end
local function _() -- Line 45, Named "randomVector"
    return Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit
end
local var22_upvw
local module_upvr = {
    __ClassName = "C4";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Gun_upvr)
function module_upvr.Init(arg1) -- Line 55
    var22_upvw = arg1.Event
end
local AdminPermUtils_upvr = require(ReplicatedStorage.App.AdminPermUtils)
local ActionButtonService_upvr = require(ReplicatedStorage.ActionButton.ActionButtonService)
function module_upvr.new(arg1, arg2, arg3) -- Line 58
    local any_new_result1_upvr = Gun_upvr.new(arg1, arg2, arg3)
    setmetatable(any_new_result1_upvr, module_upvr)
    any_new_result1_upvr.ApplySkin = false
    any_new_result1_upvr:Setup(arg3)
    if any_new_result1_upvr.Local and AdminPermUtils_upvr.hasPerms(any_new_result1_upvr.Player) then
        any_new_result1_upvr.Maid:GiveTask(ActionButtonService_upvr.add({
            priority = 750;
            image = "rbxassetid://4939740665";
            keyCodes = {Enum.KeyCode.F};
            onPressed = function() -- Line 69, Named "onPressed"
                local getDetonatableC4_result1 = getDetonatableC4_upvr(any_new_result1_upvr.Player)
                if getDetonatableC4_result1 then
                    getDetonatableC4_result1:Detonate({
                        nuke = true;
                    })
                end
            end;
        }))
    end
    return any_new_result1_upvr
end
function module_upvr.SetupArmWelds(arg1) -- Line 82
end
function module_upvr.UpdateArmIK(arg1) -- Line 83
    local IK = arg1.IK
    IK.RightArm = arg1.Model.Model.Hold.Position
    IK.RightAngle = arg1.Config.Motion.RightElbowAngle
end
function module_upvr.SetupTip(arg1) -- Line 89
    arg1.TipOffset = Vector3.new()
end
function module_upvr.BulletEmitterOnLocalHitPlayer(arg1) -- Line 92
end
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local SimulatedPhysicsProjectile_upvr = require(ReplicatedStorage.Module.SimulatedPhysicsProjectile)
function module_upvr.ShootBegin(arg1, arg2) -- Line 93
    local var34_upvw
    if var34_upvw then
        var34_upvw = false
        repeat
            local getDetonatableC4_result1_2 = getDetonatableC4_upvr(arg1.Player)
            if getDetonatableC4_result1_2 then
                var34_upvw = true
                getDetonatableC4_result1_2:Detonate()
            end
        until not getDetonatableC4_result1_2
        if var34_upvw then
            Audio_upvr.ObjectLocal(arg1.Model.Skeleton.BoundingBox, 6036722343, {
                Volume = 1;
            })
            arg1.SpringItemOffset:SetTarget(arg1.Config.Motion.Raise.Springs.ItemOffset)
            arg1.SpringItemRotation:SetTarget(arg1.Config.Motion.Raise.Springs.ItemRotation)
            arg1.SpringNeckRotation:SetTarget(arg1.Config.Motion.Raise.Springs.NeckRotation)
            delay(0.2, function() -- Line 114
                arg1.SpringItemOffset:SetTarget(arg1.Config.Motion.Hip.Springs.ItemOffset)
                arg1.SpringItemRotation:SetTarget(arg1.Config.Motion.Hip.Springs.ItemRotation)
                arg1.SpringNeckRotation:SetTarget(arg1.Config.Motion.Hip.Springs.NeckRotation)
            end)
            arg1.Model.Model.Screen.Color = Color3.fromRGB(91, 93, 105)
            return
        end
    end
    var34_upvw = nil
    if arg1.Local then
        if 2 <= getNumActiveC4_upvr(arg1.Player) then
            return false
        end
        var34_upvw = getThrowableC4_upvr(arg1.Player)
        if not var34_upvw then
            error("No throwable C4 left in pool")
        end
    end
    if not arg1:ShootCheckConditions() then
        return false
    end
    arg1:DecrementAmmo()
    arg1:SetNextShotPossible()
    if arg1.Local then
        local var38 = arg1.UpperTorso.CFrame * Vector3.new(0, 0, -2)
        local any_CalculateVelocityToHitTargetWithSpeed_result1, _ = SimulatedPhysicsProjectile_upvr.CalculateVelocityToHitTargetWithSpeed(var38, arg1.MousePosition, 50, workspace.Gravity, false)
        var34_upvw._obj.PrimaryPart.Anchored = false
        var34_upvw._obj:SetPrimaryPartCFrame(CFrame.new(var38, var38 + any_CalculateVelocityToHitTargetWithSpeed_result1))
        var34_upvw:SetVelocity(any_CalculateVelocityToHitTargetWithSpeed_result1)
        var34_upvw:SetRotVelocity(-0.25 * any_CalculateVelocityToHitTargetWithSpeed_result1:Cross(Vector3.new(0, 1, 0)) + Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit * 5)
        task.spawn(function() -- Line 162
            var34_upvw:ListenForAttach()
        end)
        var22_upvw:FireServer('n'.."".."id2lotyni":sub(3, 5):reverse():reverse():reverse():reverse():reverse().."".."".."tgtycpom2":sub(5, 5):reverse():reverse():reverse().."".."imj")
        arg1.Model.Model.Screen.Color = Color3.new(1, 0, 0)
    end
    if arg1.Local then
        arg1:BroadcastInputBegan(arg2)
    end
end
function module_upvr.ShootEnd(arg1, arg2) -- Line 175
    if arg1.Local then
        arg1:BroadcastInputEnded(arg2)
    end
end
function module_upvr.ShootSound(arg1, arg2) -- Line 180
    if not arg2 then
    end
end
function module_upvr.ReloadDropAmmoSound(arg1) -- Line 185
end
function module_upvr.ReloadRefillAmmoSound(arg1) -- Line 186
end
function module_upvr.ReloadDropAmmoVisual(arg1) -- Line 187
end
function module_upvr.ReloadRefillAmmoVisual(arg1) -- Line 188
end
module_upvr.ScopeBegin = false
module_upvr.ScopeEnd = false
module_upvr.Reload = false
return module_upvr
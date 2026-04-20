local Players_upvr = game:GetService("Players")
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local function _() -- Line 15, Named "randomVector"
    return Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit
end
local tbl_upvr = {
    bullet_impact_bass = 2837091387;
    reload = 6602025903;
    shoot = 6602025330;
    detected = 6602024939;
    motor = 6602024532;
}
local MilitaryTurretConsts_upvr = require(script.Parent.MilitaryTurretConsts)
local MilitaryTurretUtils_upvr = require(script.Parent.MilitaryTurretUtils)
local module_upvr_2 = {}
module_upvr_2.__index = module_upvr_2
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Signal_upvr = require(ReplicatedStorage.Std.Signal)
local Spring_upvr = require(ReplicatedStorage.Std.Spring)
local BulletEmitter_upvr = require(ReplicatedStorage.Game.ItemSystem.BulletEmitter)
local RunService_upvr = game:GetService("RunService")
local Joint_upvr = require(ReplicatedStorage.Std.Joint)
function module_upvr_2.new(arg1) -- Line 33
    RxInstanceUtils_upvr.yieldForProperty(arg1, "PrimaryPart")
    local module_upvr = {}
    setmetatable(module_upvr, module_upvr_2)
    module_upvr._maid = Maid_upvr.new()
    module_upvr.onBulletHit = Signal_upvr.new()
    module_upvr._lastPitch = 0
    module_upvr._lastYaw = 0
    module_upvr._pitchSpring = Spring_upvr.new(module_upvr._lastPitch, 0, 0.6, 15)
    module_upvr._yawSpring = Spring_upvr.new(module_upvr._lastYaw, 0, 0.6, 15)
    module_upvr._kickSpring = Spring_upvr.new(0, 0, 0.7, 70)
    local any_new_result1 = BulletEmitter_upvr.new(true)
    any_new_result1.IgnoreList = assert({arg1.Parent, workspace.Vehicles})
    any_new_result1.LifeSpan = 1
    any_new_result1.IgnoreLocalPlayer = false
    any_new_result1.GravityVector = Vector3.new(0, -2, 0)
    module_upvr._maid:GiveTask(any_new_result1.OnLocalHitPlayer:Connect(function(arg1_2) -- Line 56
        if Players_upvr:GetPlayerFromCharacter(arg1_2.Parent) == LocalPlayer_upvr then
            module_upvr.onBulletHit:Fire(MilitaryTurretConsts_upvr.TURRET_DAMAGE)
        end
        Audio_upvr.ObjectLocal(arg1_2.RootPart, tbl_upvr.bullet_impact_bass, {
            Volume = 1;
        })
    end))
    module_upvr._maid:GiveTask(any_new_result1)
    module_upvr._bulletEmitter = any_new_result1
    module_upvr._lastDt = os.clock()
    module_upvr._maxDYaw = 12.566370614359172
    module_upvr._turretMotorSound = Audio_upvr.ObjectLocal(arg1.PrimaryPart, tbl_upvr.motor, {
        Looped = true;
        DoNotPlay = true;
        Volume = 0.3;
        RollOffMaxDistance = 256;
    })
    module_upvr._clipSize = MilitaryTurretConsts_upvr.MAG_SIZE
    module_upvr._lastFire = os.clock()
    module_upvr._lastPointAt = nil
    module_upvr._lastDetectedBeep = os.clock()
    module_upvr._maid:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 82
        module_upvr:_update(arg1)
    end))
    local MotorArm = arg1:FindFirstChild("MotorArm")
    local MotorBase = arg1:FindFirstChild("MotorBase")
    if MotorArm == nil then
        RxInstanceUtils_upvr.yieldForProperty(arg1.Top, "PrimaryPart")
        RxInstanceUtils_upvr.yieldForProperty(arg1.Post, "PrimaryPart")
        Joint_upvr.WeldAllTo(arg1.Top, arg1.Top.PrimaryPart)
        Joint_upvr.WeldAllTo(arg1.Post, arg1.Post.PrimaryPart)
        MotorArm = Joint_upvr.CustomWeld(arg1.Top.PrimaryPart, arg1.PivotTop, arg1.Top.PrimaryPart.CFrame:ToObjectSpace(arg1.PivotTop.CFrame), CFrame.new())
        MotorArm.Parent = arg1
        MotorBase = Joint_upvr.CustomWeld(arg1.Post.PrimaryPart, arg1.PivotBottom, arg1.Post.PrimaryPart.CFrame:ToObjectSpace(arg1.PivotBottom.CFrame), CFrame.new())
        MotorBase.Parent = arg1
    end
    module_upvr._motorArm = MotorArm
    module_upvr._motorBase = MotorBase
    return module_upvr
end
local PlayerUtils_upvr = require(ReplicatedStorage.Game.PlayerUtils)
local RayCast_upvr = require(ReplicatedStorage.Module.RayCast)
function module_upvr_2._update(arg1, arg2) -- Line 120
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local os_clock_result1 = os.clock()
    local var29
    if not PlayerUtils_upvr.getRootPart(LocalPlayer_upvr) then
    else
        arg1._bulletEmitter:Update()
        var29 = PlayerUtils_upvr.getRootPart(LocalPlayer_upvr).Position
        var29 = 450
        if var29 < (var29 - arg2.PrimaryPart.Position).Magnitude then return end
        var29 = nil
        local any_getNearestNonPolice_result1 = MilitaryTurretUtils_upvr.getNearestNonPolice(arg2.PrimaryPart.Position, 400)
        if any_getNearestNonPolice_result1 then
            local any_getRootPart_result1 = PlayerUtils_upvr.getRootPart(any_getNearestNonPolice_result1)
            local Parent = any_getRootPart_result1.Parent
            var29 = any_getRootPart_result1.Position
        end
        local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            local any_RayIgnoreNonCollideWithIgnoreList_result1, any_RayIgnoreNonCollideWithIgnoreList_result2 = RayCast_upvr.RayIgnoreNonCollideWithIgnoreList(Position, var34.Unit, var34.Magnitude, assert(arg1._bulletEmitter.IgnoreList))
            local var34 = var29 - Position
            local Position = arg2.Top.Tip.Position
            return any_RayIgnoreNonCollideWithIgnoreList_result1
        end
        if var29 and decompInlinedCondition() and 1 < (any_RayIgnoreNonCollideWithIgnoreList_result2 - var29).Magnitude and (not Parent or not any_RayIgnoreNonCollideWithIgnoreList_result1:IsDescendantOf(Parent)) then
            var29 = nil
        end
        if var29 then
            if not arg1._lastPointAt then
                if not arg1._turretMotorSound.IsPlaying then
                    arg1._turretMotorSound:Play()
                end
                if 2 < os_clock_result1 - arg1._lastDetectedBeep then
                    arg1._lastDetectedBeep = os_clock_result1
                    Audio_upvr.ObjectLocal(arg2.PrimaryPart, tbl_upvr.detected, {
                        Volume = 1;
                        RollOffMaxDistance = 512;
                    })
                    arg1._lastFire = os_clock_result1 + 0.5
                end
            end
            arg1:_updateRotation(arg2, var29)
            if MilitaryTurretConsts_upvr.FIRE_RATE < os_clock_result1 - arg1._lastFire then
                arg1._lastFire = os_clock_result1
                if 0 < arg1._clipSize then
                    arg1._clipSize -= 1
                    arg1:_fire(arg2)
                else
                    arg1._lastFire = os_clock_result1 + MilitaryTurretConsts_upvr.RELOAD_TIME
                    arg1._clipSize = MilitaryTurretConsts_upvr.MAG_SIZE
                    Audio_upvr.ObjectLocal(arg2.PrimaryPart, tbl_upvr.reload, {
                        Volume = 1;
                        RollOffMaxDistance = 512;
                    })
                end
            end
        end
        if not var29 and arg1._lastPointAt and arg1._turretMotorSound.IsPlaying then
            arg1._turretMotorSound:Stop()
        end
        arg1._lastPointAt = var29
    end
end
function module_upvr_2._updateRotation(arg1, arg2, arg3) -- Line 193
    local os_clock_result1_2 = os.clock()
    local var40 = os_clock_result1_2 - arg1._lastDt
    arg1._lastDt = os_clock_result1_2
    local any_PointToObjectSpace_result1_2 = arg2.PivotBottom.CFrame:PointToObjectSpace(arg3)
    local arctangent = math.atan2(-any_PointToObjectSpace_result1_2.x, -any_PointToObjectSpace_result1_2.z)
    local any_PointToObjectSpace_result1 = arg2.PivotTop.CFrame * CFrame.Angles(0, arctangent, 0):PointToObjectSpace(arg3)
    arg1._lastPitch = math.atan2(any_PointToObjectSpace_result1.y, -any_PointToObjectSpace_result1.z) + math.asin(-0.56 / math.sqrt(any_PointToObjectSpace_result1.y * any_PointToObjectSpace_result1.y + any_PointToObjectSpace_result1.z * any_PointToObjectSpace_result1.z))
    arg1._lastYaw += math.clamp(MilitaryTurretUtils_upvr.shortAngleDist(arg1._lastYaw, arctangent), -arg1._maxDYaw * var40, arg1._maxDYaw * var40)
    local any_SetTarget_result1 = arg1._yawSpring:SetTarget(arg1._lastYaw)
    arg1._motorBase.C1 = CFrame.Angles(0, any_SetTarget_result1, 0)
    arg1._motorArm.C1 = CFrame.Angles(0, any_SetTarget_result1, 0) * CFrame.Angles(arg1._pitchSpring:SetTarget(arg1._lastPitch), 0, 0) * CFrame.new(0, 0, arg1._kickSpring:Update())
end
function module_upvr_2._fire(arg1, arg2) -- Line 224
    local CFrame = arg2.Top.Tip.CFrame
    arg1._bulletEmitter:Emit(CFrame.p, CFrame.LookVector + Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit * 0.008, 400)
    arg1._kickSpring:Accelerate(40)
    Audio_upvr.ObjectLocal(arg2.Top.Tip, tbl_upvr.shoot, {
        Volume = 0.5;
    })
end
function module_upvr_2.Destroy(arg1) -- Line 232
    arg1._maid = nil
    arg1._maid:Destroy()
end
return module_upvr_2
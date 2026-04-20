local Players_upvr = game:GetService("Players")
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService_upvr = game:GetService("RunService")
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local DogConsts_upvr = require(ReplicatedStorage.Game.Dog.DogConsts)
local Promise_upvr = require(ReplicatedStorage.Std.Promise)
local PlayerUtils_upvr = require(ReplicatedStorage.Game.PlayerUtils)
local DogSystem_upvr = require(script.Parent.DogSystem)
local module_upvr = {}
module_upvr.__index = module_upvr
local Spring_upvr = require(ReplicatedStorage.Std.Spring)
function module_upvr.new(arg1) -- Line 29
    local module_upvr_2 = {}
    setmetatable(module_upvr_2, module_upvr)
    module_upvr_2._maid = Maid_upvr.new()
    module_upvr_2._obj = arg1
    module_upvr_2._mapAnimTrack = {}
    module_upvr_2._damageRemote = arg1:WaitForChild(DogConsts_upvr.DAMAGE_REMOTE_NAME)
    module_upvr_2._breedIdValue = arg1:WaitForChild(DogConsts_upvr.BREED_ID_VALUE_NAME)
    module_upvr_2._animController = arg1:WaitForChild("AnimationController")
    while not arg1.PrimaryPart do
        task.wait(0.01)
    end
    module_upvr_2._bodyVelocity = arg1.PrimaryPart:WaitForChild(DogConsts_upvr.BODY_VELOCITY_NAME)
    module_upvr_2._bodyGyro = arg1.PrimaryPart:WaitForChild(DogConsts_upvr.BODY_GYRO_NAME)
    module_upvr_2:SetSpeed(0)
    module_upvr_2:SetDirection(Vector3.new())
    module_upvr_2:SetAnimSpeed(0)
    module_upvr_2._stateId = nil
    module_upvr_2._attackStateId = DogConsts_upvr.ATTACK_STATE.TO
    module_upvr_2._animStateId = nil
    module_upvr_2._animTrack = nil
    module_upvr_2._goalPos = nil
    module_upvr_2._targetSpeedSpring = Spring_upvr.new(0, 0, 1, 1)
    module_upvr_2._lastUpdate = os.clock()
    module_upvr_2._lastJump = os.clock()
    module_upvr_2._lastAttack = os.clock()
    module_upvr_2._lastAttackSend = os.clock()
    module_upvr_2._lastAnimTransition = os.clock()
    module_upvr_2._lastDiscoverOpp = os.clock()
    module_upvr_2._lastDiscoverDog = os.clock()
    module_upvr_2._lastStuckAt = os.clock()
    module_upvr_2._ownerIdValue = arg1:WaitForChild(DogConsts_upvr.OWNER_ID_VALUE_NAME)
    module_upvr_2._maid:GiveTask(module_upvr_2._ownerIdValue.Changed:Connect(function() -- Line 66
        module_upvr_2:_updateOwner()
    end))
    module_upvr_2:_updateOwner()
    module_upvr_2._targetIdValue = arg1:WaitForChild(DogConsts_upvr.TARGET_ID_VALUE_NAME)
    module_upvr_2._maid:GiveTask(module_upvr_2._targetIdValue.Changed:Connect(function() -- Line 72
        module_upvr_2:_updateTarget()
    end))
    module_upvr_2:_updateTarget()
    module_upvr_2._maid:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 77
        module_upvr_2:_updateAnimSpeed()
    end))
    module_upvr_2._barkRemote = arg1:WaitForChild(DogConsts_upvr.BARK_REMOTE_NAME)
    module_upvr_2._maid:GiveTask(module_upvr_2._barkRemote.OnClientEvent:Connect(function() -- Line 82
        module_upvr_2:_bark()
    end))
    module_upvr_2._animRemote = arg1:WaitForChild(DogConsts_upvr.ANIM_REMOTE_NAME)
    module_upvr_2._maid:GiveTask(module_upvr_2._animRemote.OnClientEvent:Connect(function(arg1_2) -- Line 87
        module_upvr_2:_playAnim(arg1_2)
    end))
    module_upvr_2._isMountedValue = arg1:WaitForChild(DogConsts_upvr.IS_MOUNTED_NAME)
    module_upvr_2._maid:GiveTask(module_upvr_2._isMountedValue.Changed:Connect(function(arg1_3) -- Line 92
        if arg1_3 then
            module_upvr_2:SetAnimation(DogConsts_upvr.ANIM_STATE.REST)
        else
            module_upvr_2._obj:SetPrimaryPartCFrame(module_upvr_2._obj.PrimaryPart.CFrame * CFrame.new(0, 10, 0))
        end
        module_upvr_2:_setEnabled(not arg1_3)
    end))
    module_upvr_2._giveUpRemote = arg1:WaitForChild(DogConsts_upvr.GIVE_UP_REMOTE_NAME)
    module_upvr_2._lastGiveUpSend = os.clock()
    module_upvr_2:_updateBreed(module_upvr_2._breedIdValue.Value)
    module_upvr_2._maid:GiveTask(module_upvr_2._breedIdValue.Changed:Connect(function(arg1_4) -- Line 106
        module_upvr_2:_updateBreed(arg1_4)
    end))
    module_upvr_2:SetState(DogConsts_upvr.STATE.FOLLOW)
    module_upvr_2:SetAnimation(DogConsts_upvr.ANIM_STATE.IDLE)
    local Collider = module_upvr_2._obj:FindFirstChild("Collider")
    if not Collider then
        error("Dog is missing `Collider` part.")
    end
    module_upvr_2._collider = Collider
    module_upvr_2:_setEnabled(true)
    return module_upvr_2
end
function module_upvr._setEnabled(arg1, arg2) -- Line 123
    arg1._enabled = arg2
end
function module_upvr._setForcesEnabled(arg1, arg2) -- Line 126
    if arg2 then
        arg1._bodyVelocity.MaxForce = DogConsts_upvr.BODY_VELOCITY_MAX_FORCE
        arg1._bodyGyro.MaxTorque = DogConsts_upvr.BODY_GYRO_MAX_TORQUE
    else
        arg1._bodyVelocity.MaxForce = Vector3.new()
        arg1._bodyGyro.MaxTorque = Vector3.new()
    end
end
function module_upvr._updateBreed(arg1, arg2) -- Line 135
    if arg2 == nil then
    else
    end
    assert(true)
    arg1:_loadAnimations(arg2)
end
function module_upvr._loadAnimations(arg1, arg2) -- Line 139
    if arg2 == nil then
    else
    end
    assert(true)
    if arg1._mapAnimTrack[DogConsts_upvr.ANIM_STATE.WALK] ~= nil then
    else
    end
    assert(true)
    for i, v in pairs(DogSystem_upvr.getAnimInsts(arg2)) do
        arg1._mapAnimTrack[i] = arg1._animController:LoadAnimation(v)
    end
end
function module_upvr._getAnimTrack(arg1, arg2) -- Line 148
    local var28 = arg1._mapAnimTrack[arg2]
    if not var28 then return end
    return var28
end
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
local VehicleUtils_upvr = require(ReplicatedStorage.Vehicle.VehicleUtils)
function module_upvr._updateOwner(arg1) -- Line 156
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local any_GetOwner_result1_2_upvr = arg1:GetOwner()
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [23.2]
    nil:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 163
        arg1:_updateLocalOwner()
    end))
    nil:GiveTask(arg1._obj.Mouth.Touched:Connect(function(...) -- Line 166
        arg1:_onMouthTouched(...)
    end))
    nil:GiveTask(Interval_upvr.every(1):Connect(function() -- Line 169
        local any_getRootPart_result1_2 = PlayerUtils_upvr.getRootPart(any_GetOwner_result1_2_upvr)
        if not any_getRootPart_result1_2 then
        elseif arg1._stateId ~= DogConsts_upvr.STATE.ATTACK and (DogConsts_upvr.TELEPORT_AFTER_DIST < (any_getRootPart_result1_2.Position - arg1._obj.PrimaryPart.Position).Magnitude or DogConsts_upvr.TELEPORT_AFTER_STUCK_FOR < os.clock() - arg1._lastStuckAt) then
            arg1._obj:SetPrimaryPartCFrame(any_getRootPart_result1_2.CFrame * CFrame.new(0, 10, 5))
        end
    end))
    arg1._maid:GiveTask(VehicleUtils_upvr.OnVehicleEntered:Connect(function(arg1_5, arg2) -- Line 187
        if arg2 then
        else
            if not arg1_5.Model:FindFirstChild("DogSit") then return end
            arg1:_setEnabled(false)
            arg1:_setForcesEnabled(false)
        end
    end))
    arg1._maid:GiveTask(VehicleUtils_upvr.OnVehicleExited:Connect(function(arg1_6, arg2) -- Line 198
        if arg2 then
        else
            if not arg1_6.Model:FindFirstChild("DogSit") then return end
            arg1:_setEnabled(true)
            arg1:_setForcesEnabled(true)
        end
    end))
    arg1:_setEnabled(true)
    arg1:_setForcesEnabled(true)
    nil:GiveTask(function() -- Line 212
        arg1:_setEnabled(false)
        arg1:_setForcesEnabled(false)
    end)
    do
        return
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    arg1._maid.ownerMaid = nil
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_upvr._updateTarget(arg1) -- Line 221
    if arg1:GetTarget() then
        arg1:SetState(DogConsts_upvr.STATE.ATTACK)
    else
        arg1:SetState(DogConsts_upvr.STATE.FOLLOW)
    end
end
function module_upvr._onMouthTouched(arg1, arg2) -- Line 229
    local os_clock_result1_2 = os.clock()
    local any_GetTarget_result1 = arg1:GetTarget()
    if any_GetTarget_result1 and arg2:IsDescendantOf(any_GetTarget_result1.Character) and os_clock_result1_2 - arg1._lastAttack < 2 and 1 < os_clock_result1_2 - arg1._lastAttackSend then
        arg1._lastAttackSend = os_clock_result1_2
        arg1._damageRemote:FireServer()
    end
end
function module_upvr.GetBreedId(arg1) -- Line 243
    return arg1._breedIdValue.Value
end
function module_upvr._playAnim(arg1, arg2) -- Line 247
    local any__getAnimTrack_result1 = arg1:_getAnimTrack(arg2)
    if any__getAnimTrack_result1 then
        any__getAnimTrack_result1:Play(0.25)
    end
end
function module_upvr._playAnimNetwork(arg1, arg2) -- Line 253
    arg1:_playAnim(arg2)
    arg1._animRemote:FireServer(arg2)
end
function module_upvr.SetAnimation(arg1, arg2) -- Line 257
    local var49
    if arg2 == arg1._animStateId then
        var49 = false
    else
        var49 = true
    end
    assert(var49)
    if arg1._animTrack ~= nil then
        var49 = nil
        arg1._animTrack = var49
        var49 = arg1._animTrack:Stop
        var49(0.25)
    end
    arg1._animStateId = arg2
    arg1._animTrack = arg1:_getAnimTrack(arg2)
    if arg1._animTrack then
        arg1._animTrack:Play(0.25)
    end
    if arg2 == DogConsts_upvr.ANIM_STATE.PET then
        local any_GetOwner_result1_4 = arg1:GetOwner()
        var49 = PlayerUtils_upvr
        var49 = var49.getHumanoid(any_GetOwner_result1_4)
        if var49 then
            local any_getPetTrack_result1 = DogSystem_upvr.getPetTrack()
            if any_getPetTrack_result1 then
                if any_GetOwner_result1_4 == LocalPlayer_upvr then
                    any_getPetTrack_result1:Play(0.25)
                    local var53_upvw
                    var53_upvw = any_getPetTrack_result1.Stopped:Connect(function() -- Line 281
                        var53_upvw:Disconnect()
                        arg1:SetAnimation(DogConsts_upvr.ANIM_STATE.IDLE_PLAY)
                    end)
                else
                    Promise_upvr.delay(any_getPetTrack_result1.Length):andThen(function() -- Line 286
                        arg1:SetAnimation(DogConsts_upvr.ANIM_STATE.IDLE_PLAY)
                    end)
                end
                -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
            end
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
    elseif arg2 == DogConsts_upvr.ANIM_STATE.IDLE_PLAY then
        var49 = 1
        Promise_upvr.delay(var49):andThen(function() -- Line 293
            arg1:SetAnimation(DogConsts_upvr.ANIM_STATE.IDLE)
            arg1:_updateTarget()
        end)
    end
    var49 = DogConsts_upvr.ANIM_SPS[arg1:GetBreedId()][arg1._animStateId]
    if var49 and arg1._animTrack then
        arg1._animTrack:AdjustSpeed(arg1._speed / var49)
    end
    arg1._lastAnimTransition = os.clock()
end
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
function module_upvr._bark(arg1) -- Line 309
    if arg1._animStateId == DogConsts_upvr.ANIM_STATE.REST then
        arg1:SetAnimation(DogConsts_upvr.ANIM_STATE.IDLE)
    end
    arg1:_playAnim(DogConsts_upvr.ANIM_STATE.BARK)
    Audio_upvr.ObjectLocal(arg1._obj.PrimaryPart, DogConsts_upvr.BARK_SOUND_ID[arg1:GetBreedId()], {
        Volume = 0.3;
        Pitch = 1 + 0.1 * math.random();
    })
end
function module_upvr.Bark(arg1) -- Line 320
    arg1._barkRemote:FireServer()
    arg1:_bark()
end
function module_upvr.SetState(arg1, arg2) -- Line 324
    if arg2 == nil then
    else
    end
    assert(true)
    if arg2 == DogConsts_upvr.STATE.ATTACK then
        arg1._attackStateId = DogConsts_upvr.ATTACK_STATE.TO
        arg1._goToPosition = nil
    end
    arg1._stateId = arg2
end
function module_upvr.DistanceTo(arg1, arg2) -- Line 333
    return ((arg2 - arg1._obj.PrimaryPart.Position) * Vector3.new(1, 0, 1)).Magnitude
end
function module_upvr._getGoalRootPart(arg1) -- Line 337
    local var58
    if arg1._stateId == DogConsts_upvr.STATE.ATTACK then
        var58 = arg1:GetTarget()
    elseif arg1._stateId == DogConsts_upvr.STATE.FOLLOW then
        var58 = arg1:GetOwner()
    end
    if not var58 then return end
    return PlayerUtils_upvr.getRootPart(var58)
end
function module_upvr._getGoalPos(arg1) -- Line 349
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    do
        return
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_upvr._getTargetSpeed(arg1, arg2, arg3) -- Line 398
    local var59 = 0
    if arg1._goalPos then
        local var60 = (arg2 - arg1._goalPos).Magnitude / arg3
        var59 = arg1._targetSpeedSpring:SetTarget(var60)
        if var59 < var60 then
            arg1._targetSpeedSpring.Freq = 3
            return var59
        end
        arg1._targetSpeedSpring.Freq = 10
    end
    return var59
end
function module_upvr._getGoalSpeed(arg1, arg2) -- Line 413
    local var61 = DogConsts_upvr.TOP_SPEED[arg1:GetBreedId()]
    if arg1._stateId == DogConsts_upvr.STATE.ATTACK then
        return var61 * 0.8
    end
    local var62
    if var62 == DogConsts_upvr.STATE.FOLLOW then
        var62 = 0
        if 1 <= arg2 then
            local var63 = (arg2 - 6) / 122
            var62 = math.max(arg1._targetSpeed + arg2 / 5, (1 - var63) * 10 + var63 * var61)
        end
        if var62 <= 4 then
        end
        return math.clamp(0, 0, var61)
    end
end
function module_upvr.Jump(arg1) -- Line 438
    if not arg1._enabled then
    else
        arg1._lastJump = os.clock()
        arg1._obj.PrimaryPart.Velocity = Vector3.new(0, 30, 0)
    end
end
function module_upvr._getNearestDog(arg1, arg2) -- Line 446
    local any_GetOwner_result1_3 = arg1:GetOwner()
    local any_getRootPart_result1_3 = PlayerUtils_upvr.getRootPart(any_GetOwner_result1_3)
    local var81
    if not any_getRootPart_result1_3 then return end
    var81 = nil
    for _, v_2 in ipairs(DogSystem_upvr.getAll()) do
        if v_2 ~= arg1 then
            if v_2:GetOwner().TeamValue.Value ~= any_GetOwner_result1_3.TeamValue.Value then
                if (v_2._obj.PrimaryPart.Position - any_getRootPart_result1_3.Position).Magnitude < (arg2 or math.huge) then
                    var81 = v_2
                end
            end
        end
    end
    return var81
end
function module_upvr._getNearestOpp(arg1, arg2) -- Line 471
    local any_GetOwner_result1_5 = arg1:GetOwner()
    local any_getRootPart_result1_4 = PlayerUtils_upvr.getRootPart(any_GetOwner_result1_5)
    local var104
    if not any_getRootPart_result1_4 then return end
    var104 = nil
    for _, v_3 in ipairs(Players_upvr:GetPlayers()) do
        if v_3 ~= any_GetOwner_result1_5 then
            if v_3.TeamValue.Value ~= any_GetOwner_result1_5.TeamValue.Value then
                local any_getRootPart_result1_5 = PlayerUtils_upvr.getRootPart(v_3)
                if any_getRootPart_result1_5 then
                    if (any_getRootPart_result1_5.Position - any_getRootPart_result1_4.Position).Magnitude < (arg2 or math.huge) then
                        var104 = v_3
                    end
                end
            end
        end
    end
    return var104
end
function module_upvr._updateAnimSpeed(arg1) -- Line 499
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    if not arg1._enabled then
    else
        local any_getRootPart_result1 = PlayerUtils_upvr.getRootPart(arg1:GetOwner())
        if not any_getRootPart_result1 then return end
        local PrimaryPart_2 = arg1._obj.PrimaryPart
        if arg1._stateId == DogConsts_upvr.STATE.REST or arg1._stateId == DogConsts_upvr.STATE.PET then
            local var112 = PrimaryPart_2.Position - any_getRootPart_result1.Position
            local Magnitude_2 = var112.Magnitude
            if 8 < Magnitude_2 then
                arg1:_updateTarget()
            elseif Magnitude_2 < 4 and 0.75 < var112.Unit:Dot(any_getRootPart_result1.CFrame.LookVector) and arg1._stateId ~= DogConsts_upvr.STATE.PET then
                arg1:SetAnimation(DogConsts_upvr.ANIM_STATE.PET)
                arg1:SetState(DogConsts_upvr.STATE.PET)
            end
        end
        local var114
        if var114 == DogConsts_upvr.STATE.FOLLOW or arg1._stateId == DogConsts_upvr.STATE.ATTACK then
            if PrimaryPart_2.Velocity.Magnitude < 1 then
                local const_number = 0
            end
            if 1 < math.abs(const_number - arg1._animSpeed) or arg1._animSpeed ~= 0 and const_number == 0 then
                arg1:SetAnimSpeed(const_number)
            end
        end
        if arg1._stateId == DogConsts_upvr.STATE.FOLLOW and arg1._animStateId == DogConsts_upvr.ANIM_STATE.IDLE and 6 < os.clock() - arg1._lastAnimTransition then
            arg1:SetState(DogConsts_upvr.STATE.REST)
            arg1:SetAnimation(DogConsts_upvr.ANIM_STATE.REST)
        end
    end
end
function module_upvr._discoverDog(arg1) -- Line 550
    arg1._lastDiscoverDog = os.clock()
    local any__getNearestDog_result1 = arg1:_getNearestDog(DogConsts_upvr.CONFUSION_OPP_RADIUS)
    if any__getNearestDog_result1 then
        arg1:SetDirection(((any__getNearestDog_result1._obj.PrimaryPart.Position - arg1._obj.PrimaryPart.Position) * Vector3.new(1, 0, 1)).Unit)
        arg1:Bark()
        arg1:_playAnimNetwork(DogConsts_upvr.ANIM_STATE.POINT)
        return true
    end
end
function module_upvr._discoverOpp(arg1) -- Line 567
    arg1._lastDiscoverOpp = os.clock()
    local any__getNearestOpp_result1_2 = arg1:_getNearestOpp(DogConsts_upvr.BARK_OPP_RADIUS)
    if any__getNearestOpp_result1_2 then
        arg1:_barkAt(((PlayerUtils_upvr.getRootPart(any__getNearestOpp_result1_2).Position - arg1._obj.PrimaryPart.Position) * Vector3.new(1, 0, 1)).Unit)
        return true
    end
end
function module_upvr._barkAt(arg1, arg2) -- Line 581
    local var118
    if math.abs(arg2.Magnitude - 1) >= 0.001 then
        var118 = false
    else
        var118 = true
    end
    assert(var118)
    arg1:SetDirection(arg2)
    arg1:Bark()
    arg1:_playAnimNetwork(DogConsts_upvr.ANIM_STATE.POINT)
end
local RayCast_upvr = require(ReplicatedStorage.Module.RayCast)
function module_upvr._updateLocalOwner(arg1) -- Line 590
    if not arg1._enabled then
    else
        local os_clock_result1 = os.clock()
        arg1._lastUpdate = os_clock_result1
        if arg1._stateId == DogConsts_upvr.STATE.FOLLOW or arg1._stateId == DogConsts_upvr.STATE.ATTACK then
            local any__getGoalPos_result1 = arg1:_getGoalPos()
            if not any__getGoalPos_result1 then return end
            arg1._targetSpeed = arg1:_getTargetSpeed(any__getGoalPos_result1, os_clock_result1 - arg1._lastUpdate)
            arg1._goalPos = any__getGoalPos_result1
            local PrimaryPart = arg1._obj.PrimaryPart
            local var123 = (any__getGoalPos_result1 - PrimaryPart.Position) * Vector3.new(1, 0, 1)
            local Magnitude = var123.Magnitude
            local any__getGoalSpeed_result1 = arg1:_getGoalSpeed(Magnitude)
            arg1:SetSpeed(any__getGoalSpeed_result1)
            if 0 < any__getGoalSpeed_result1 then
                arg1:SetDirection(var123.Unit)
            end
            local var126 = 1
            if arg1:GetBreedId() == DogConsts_upvr.ENUM_BREED.GERMAN then
                var126 = -1
            end
            arg1._bodyGyro.CFrame = CFrame.new(Vector3.new(), arg1._direction * var126) + PrimaryPart.Position
            arg1._bodyVelocity.Velocity = PrimaryPart.CFrame.LookVector * var126 * arg1._speed
            if any__getGoalSpeed_result1 * 0.5 < math.abs(PrimaryPart.Velocity:Dot(PrimaryPart.CFrame.LookVector)) or any__getGoalSpeed_result1 < 5 then
                arg1._lastStuckAt = os_clock_result1
            end
            if 0.1 < os_clock_result1 - arg1._lastStuckAt and 0.5 < os_clock_result1 - arg1._lastJump then
                arg1:Jump()
            end
            if arg1._stateId == DogConsts_upvr.STATE.ATTACK then
                if arg1._attackStateId == DogConsts_upvr.ATTACK_STATE.TO then
                    local ATTACK_LEAD_TIME = DogConsts_upvr.ATTACK_LEAD_TIME
                    if Magnitude <= any__getGoalSpeed_result1 * ATTACK_LEAD_TIME and not arg1._goToPosition then
                        local var128 = math.random() * 8 + 16
                        if 0.5 < math.random() then
                            var128 = -var128
                        end
                        local var129 = math.random() * 8 + 16
                        if 0.5 < math.random() then
                            var129 = -var129
                        end
                        local var130 = any__getGoalPos_result1 + Vector3.new(var128, 0, var129)
                        local Position = PrimaryPart.Position
                        local _, any_RayIgnoreNonCollideWithIgnoreList_result2 = RayCast_upvr.RayIgnoreNonCollideWithIgnoreList(Position, (var130 - Position).Unit, (var130 - Position).Magnitude, {arg1._obj, arg1:_getGoalRootPart().Parent})
                        arg1._goToPosition = any_RayIgnoreNonCollideWithIgnoreList_result2
                        arg1._lastAttack = os.clock()
                        arg1:Jump()
                        arg1:Bark()
                        Promise_upvr.delay(ATTACK_LEAD_TIME):andThen(function() -- Line 669
                            arg1._attackStateId = DogConsts_upvr.ATTACK_STATE.AWAY
                        end)
                        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
                    end
                elseif arg1._attackStateId == DogConsts_upvr.ATTACK_STATE.AWAY and Magnitude <= 10 then
                    arg1._goToPosition = nil
                    arg1._attackStateId = DogConsts_upvr.ATTACK_STATE.TO
                end
                if DogConsts_upvr.GIVE_UP_AFTER_DIST < Magnitude and 1 < os_clock_result1 - arg1._lastGiveUpSend then
                    arg1._lastGiveUpSend = os_clock_result1
                    arg1._giveUpRemote:FireServer()
                    -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
                end
                -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
            end
        else
            arg1._lastStuckAt = os_clock_result1
        end
        if arg1._animStateId == DogConsts_upvr.ANIM_STATE.IDLE or arg1._animStateId == DogConsts_upvr.ANIM_STATE.REST or 1.5 < os_clock_result1 - arg1._lastAnimTransition then
            local any__getNearestDog_result1_2 = arg1:_getNearestDog(DogConsts_upvr.BARK_CONFUSION_RADIUS)
            if any__getNearestDog_result1_2 then
                if 1 < os_clock_result1 - arg1._lastDiscoverDog then
                    arg1._lastDiscoverDog = os_clock_result1
                    arg1:_barkAt(((any__getNearestDog_result1_2._obj.PrimaryPart.Position - arg1._obj.PrimaryPart.Position) * Vector3.new(1, 0, 1)).Unit)
                    -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
                end
            else
                local any__getNearestOpp_result1 = arg1:_getNearestOpp(DogConsts_upvr.BARK_OPP_RADIUS)
                if any__getNearestOpp_result1 and 10 < os_clock_result1 - arg1._lastDiscoverOpp then
                    arg1._lastDiscoverOpp = os_clock_result1
                    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                    arg1:_barkAt(((PlayerUtils_upvr.getRootPart(any__getNearestOpp_result1).Position - arg1._obj.PrimaryPart.Position) * Vector3.new(1, 0, 1)).Unit)
                end
            end
        end
        if arg1._stateId == DogConsts_upvr.STATE.ATTACK and DogConsts_upvr.GIVE_UP_AFTER_STUCK_FOR < os_clock_result1 - arg1._lastStuckAt and 1 < os_clock_result1 - arg1._lastGiveUpSend then
            arg1._lastGiveUpSend = os_clock_result1
            arg1._giveUpRemote:FireServer()
        end
    end
end
function module_upvr.SetDirection(arg1, arg2) -- Line 729
    arg1._direction = arg2
end
function module_upvr.SetSpeed(arg1, arg2) -- Line 732
    local var138
    if var138 < 0 then
        var138 = 0
    end
    arg1._speed = var138
end
function module_upvr.SetAnimSpeed(arg1, arg2) -- Line 738
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    arg1._animSpeed = arg2
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if arg1._animStateId ~= DogConsts_upvr.ANIM_STATE.SPRINT then
        arg1:SetAnimation(DogConsts_upvr.ANIM_STATE.SPRINT)
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_upvr.GetOwner(arg1) -- Line 766
    local _ownerIdValue = arg1._ownerIdValue
    if not _ownerIdValue then return end
    return Players_upvr:GetPlayerByUserId(_ownerIdValue.Value)
end
function module_upvr.GetTarget(arg1) -- Line 775
    local _targetIdValue = arg1._targetIdValue
    if not _targetIdValue then return end
    return Players_upvr:GetPlayerByUserId(_targetIdValue.Value)
end
function module_upvr.Destroy(arg1) -- Line 784
    local _maid = arg1._maid
    local var142
    if _maid == nil then
        var142 = false
    else
        var142 = true
    end
    assert(var142)
    arg1._maid = nil
    _maid:Destroy()
end
return module_upvr
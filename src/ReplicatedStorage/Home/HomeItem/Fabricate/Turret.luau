local Players_upvr = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerUtils_upvr = require(ReplicatedStorage.Game.PlayerUtils)
local function _() -- Line 14, Named "randomVector"
    return Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit
end
local function offsetLookAtTarget_upvr(arg1, arg2, arg3, arg4, arg5, arg6) -- Line 22, Named "offsetLookAtTarget"
    if arg4 == 0 or arg5 == 0 or arg6 == 0 then
        return 0, 0
    end
    local var4 = arg4 * arg4 + arg6 * arg6
    if arg6 >= 0 or not math.atan(arg4 / arg6) then
    end
    if arg1 * arg1 >= var4 or not math.asin(arg1 / var4 ^ 0.5) then
    end
    local var5 = math.pi - math.atan(-arg4 / arg6) + math.asin(var4 ^ 0.5 / arg1)
    local var8 = arg6 * math.cos(var5) + arg4 * math.sin(var5)
    local var9 = arg5 * arg5 + var8 * var8
    if var8 >= 0 or not math.atan(-arg5 / var8) then
    end
    if arg2 * arg2 >= var9 or not math.asin(arg2 / var9 ^ 0.5) then
    end
    return var5, math.atan(arg5 / var8) - math.asin(var9 ^ 0.5 / arg2)
end
local function _(arg1, arg2) -- Line 36, Named "shortAngleDist"
    local var10 = (arg2 - arg1) % (-math.pi*2)
    return 2 * var10 % (-math.pi*2) - var10
end
local function getNearestPlayer_upvr(arg1, arg2) -- Line 41, Named "getNearestPlayer"
    local var28
    for _, v in ipairs(Players_upvr:GetPlayers()) do
        local any_getRootPart_result1_5 = PlayerUtils_upvr.getRootPart(v)
        if any_getRootPart_result1_5 then
            if (any_getRootPart_result1_5.Position - arg1).Magnitude < (arg2 or math.huge) then
            end
        end
    end
    return nil
end
local function getNearestOpp_upvr(arg1, arg2, arg3) -- Line 56, Named "getNearestOpp"
    local var59
    for _, v_2 in Players_upvr:GetPlayers() do
        if not arg1:HasPermissionToEnter(v_2) then
            local any_getHumanoid_result1_2 = PlayerUtils_upvr.getHumanoid(v_2)
            if any_getHumanoid_result1_2 and 0 < any_getHumanoid_result1_2.Health then
                local RootPart_2 = any_getHumanoid_result1_2.RootPart
                if RootPart_2 then
                    if (RootPart_2.Position - arg2).Magnitude < (arg3 or math.huge) then
                    end
                end
            end
        end
    end
    return nil
end
local tbl_upvr = {
    bullet_impact_bass = 2837091387;
    reload = 6602025903;
    shoot = 6602025330;
    detected = 6602024939;
    motor = 6602024532;
}
local var64_upvw
local module = {
    init = function(arg1) -- Line 89, Named "init"
        var64_upvw = arg1.Event
    end;
}
local Spring_upvr = require(ReplicatedStorage.Std.Spring)
local BulletEmitter_upvr = require(ReplicatedStorage.Game.ItemSystem.BulletEmitter)
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local RunService_upvr = game:GetService("RunService")
local RayCast_upvr = require(ReplicatedStorage.Module.RayCast)
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
function module.setup(arg1) -- Line 92
    local _obj_upvr = arg1._obj
    local var74_upvw = 0
    local var75_upvw = 0
    local any_new_result1_upvr = Spring_upvr.new(0, 0, 0.7, 70)
    local any_new_result1_upvr_3 = BulletEmitter_upvr.new(true)
    any_new_result1_upvr_3.IgnoreList = assert({})
    any_new_result1_upvr_3.LifeSpan = 1
    any_new_result1_upvr_3.IgnoreLocalPlayer = false
    any_new_result1_upvr_3.ShieldBlockPct = 0.5
    any_new_result1_upvr_3.GravityVector = Vector3.new(0, -49.049, 0)
    arg1._maid:GiveTask(any_new_result1_upvr_3.OnLocalHitPlayer:Connect(function(arg1_2) -- Line 110
        local any_GetPlayerFromCharacter_result1 = Players_upvr:GetPlayerFromCharacter(arg1_2.Parent)
        if not any_GetPlayerFromCharacter_result1 then
        else
            if any_GetPlayerFromCharacter_result1 == LocalPlayer_upvr then
                local var80 = true
                local any_GetHome_result1_2 = arg1:GetHome()
                if any_GetHome_result1_2 then
                    if any_GetHome_result1_2:HasPermissionToEnter(any_GetPlayerFromCharacter_result1) then
                        var80 = false
                    end
                end
                if var80 then
                    var64_upvw:FireServer('y'.."hsgepze0":sub(5, 6):reverse():reverse():reverse().."".."lkho3", 3, "Shot")
                end
            end
            Audio_upvr.ObjectLocal(arg1_2.RootPart, tbl_upvr.bullet_impact_bass, {
                Volume = 1;
            })
        end
    end))
    local os_clock_result1_3_upvw = os.clock()
    local any_new_result1_upvr_2 = Spring_upvr.new(var74_upvw, 0, 0.6, 15)
    local any_new_result1_upvr_4 = Spring_upvr.new(var75_upvw, 0, 0.6, 15)
    local function updateRotation_upvr(arg1_3) -- Line 132, Named "updateRotation"
        local os_clock_result1 = os.clock()
        local var87 = os_clock_result1 - os_clock_result1_3_upvw
        os_clock_result1_3_upvw = os_clock_result1
        local CFrame_2 = _obj_upvr.Pivot.CFrame
        local any_PointToObjectSpace_result1 = CFrame_2:PointToObjectSpace(arg1_3)
        local offsetLookAtTarget_upvr_result1, offsetLookAtTarget_upvr_result2 = offsetLookAtTarget_upvr(0.3935546875, 1.7648589611053467, nil, any_PointToObjectSpace_result1.x, any_PointToObjectSpace_result1.y, any_PointToObjectSpace_result1.z)
        var74_upvw = offsetLookAtTarget_upvr_result2
        local var92 = (offsetLookAtTarget_upvr_result1 - var75_upvw) % (-math.pi*2)
        var75_upvw += math.clamp(2 * var92 % (-math.pi*2) - var92, -2.5132741228718345 * var87, 2.5132741228718345 * var87)
        _obj_upvr.Top:SetPrimaryPartCFrame(CFrame_2 * CFrame.Angles(0, any_new_result1_upvr_4:SetTarget(var75_upvw), 0) * CFrame.Angles(any_new_result1_upvr_2:SetTarget(var74_upvw), 0, 0) * CFrame.new(0, 0, any_new_result1_upvr:Update()))
    end
    arg1._maid:GiveTask(any_new_result1_upvr_3)
    local function fire_upvr() -- Line 159, Named "fire"
        local CFrame = _obj_upvr.Top.Tip.CFrame
        any_new_result1_upvr_3:Emit(CFrame.p, CFrame.LookVector + Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit * 0.01, 300)
        any_new_result1_upvr:Accelerate(40)
        Audio_upvr.ObjectLocal(_obj_upvr.Top.Tip, tbl_upvr.shoot, {
            Volume = 0.5;
        })
    end
    local var97_upvw
    local any_ObjectLocal_result1_upvr = Audio_upvr.ObjectLocal(_obj_upvr.Pivot, tbl_upvr.motor, {
        Looped = true;
        DoNotPlay = true;
        Volume = 0.3;
    })
    local os_clock_result1_2_upvw = os.clock()
    local os_clock_result1_upvw = os.clock()
    local var101_upvw = 20
    arg1._maid:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 179
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        local os_clock_result1_4 = os.clock()
        local any_getRootPart_result1_4 = PlayerUtils_upvr.getRootPart(LocalPlayer_upvr)
        if not any_getRootPart_result1_4 then
        else
            if 128 < (any_getRootPart_result1_4.Position - arg1._obj.PrimaryPart.Position).Magnitude then return end
            any_new_result1_upvr_3:Update()
            local any_GetHome_result1 = arg1:GetHome()
            local var105
            if not arg1:GetGhosted() and not arg1:IsBeingDragged() then
                if any_GetHome_result1:GetOwnerId() then
                    local getNearestOpp_result1 = getNearestOpp_upvr(any_GetHome_result1, arg1._obj.PrimaryPart.Position, 64)
                    if getNearestOpp_result1 then
                        local any_getRootPart_result1_3 = PlayerUtils_upvr.getRootPart(getNearestOpp_result1)
                        local _ = any_getRootPart_result1_3.Parent
                        var105 = any_getRootPart_result1_3.Position
                        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
                    end
                else
                    local getNearestPlayer_upvr_result1 = getNearestPlayer_upvr(arg1._obj.PrimaryPart.Position, 64)
                    if getNearestPlayer_upvr_result1 then
                        local any_getRootPart_result1_2 = PlayerUtils_upvr.getRootPart(getNearestPlayer_upvr_result1)
                        var105 = any_getRootPart_result1_2.Position
                    end
                end
            end
            local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                local any_RayIgnoreNonCollide_result1, any_RayIgnoreNonCollide_result2 = RayCast_upvr.RayIgnoreNonCollide(Position, var112.Unit, var112.Magnitude, _obj_upvr)
                local var112 = var105 - Position
                local Position = _obj_upvr.Top.Tip.Position
                return 1 < (any_RayIgnoreNonCollide_result2 - var105).Magnitude
            end
            local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                return any_RayIgnoreNonCollide_result1:IsDescendantOf(any_getRootPart_result1_2.Parent)
            end
            if var105 and decompInlinedCondition() and (not any_getRootPart_result1_2.Parent or any_RayIgnoreNonCollide_result1 and not decompInlinedCondition_2()) then
                var105 = nil
            end
            if var105 then
                if not var97_upvw then
                    if not any_ObjectLocal_result1_upvr.IsPlaying then
                        any_ObjectLocal_result1_upvr:Play()
                    end
                    if 2 < os_clock_result1_4 - os_clock_result1_2_upvw then
                        os_clock_result1_2_upvw = os_clock_result1_4
                        Audio_upvr.ObjectLocal(_obj_upvr.Pivot, tbl_upvr.detected, {
                            Volume = 1;
                        })
                        os_clock_result1_upvw = os_clock_result1_4 + 0.5
                    end
                end
                updateRotation_upvr(var105)
                if 0.1 < os_clock_result1_4 - os_clock_result1_upvw then
                    os_clock_result1_upvw = os_clock_result1_4
                    if 0 < var101_upvw then
                        var101_upvw -= 1
                        fire_upvr()
                    else
                        os_clock_result1_upvw = os_clock_result1_4 + 3
                        var101_upvw = 20
                        Audio_upvr.ObjectLocal(_obj_upvr.Pivot, tbl_upvr.reload, {
                            Volume = 1;
                        })
                    end
                end
            end
            if not var105 and var97_upvw and any_ObjectLocal_result1_upvr.IsPlaying then
                any_ObjectLocal_result1_upvr:Stop()
            end
            var97_upvw = var105
        end
    end))
    local var118_upvw = false
    arg1._maid:GiveTask(Interval_upvr.every(0.5):Connect(function() -- Line 264
        var118_upvw = not var118_upvw
        local var119
        local function decompInlinedCondition_3() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var119 = Color3.new(0, 1, 0)
            return var119
        end
        if not var118_upvw or not decompInlinedCondition_3() then
            var119 = Color3.new(1, 0, 0)
        end
        _obj_upvr.Top.Light.Color = var119
    end))
end
return module
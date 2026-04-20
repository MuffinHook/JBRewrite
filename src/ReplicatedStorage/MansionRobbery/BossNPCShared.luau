local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {}
local BossNPCUtils_upvr = require(ReplicatedStorage.MansionRobbery.BossNPCUtils)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local BossNPCConsts_upvr = require(ReplicatedStorage.MansionRobbery.BossNPCConsts)
local NPCUtils_upvr = require(ReplicatedStorage.NPC.NPCUtils)
local Players_upvr = game:GetService("Players")
local MansionRobberyUtils_upvr = require(ReplicatedStorage.MansionRobbery.MansionRobberyUtils)
local GeomUtils_upvr = require(ReplicatedStorage.Std.GeomUtils)
local RunService_upvr = game:GetService("RunService")
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local NPCShared_upvr = require(ReplicatedStorage.NPC.NPCShared)
local NPCConsts_upvr = require(ReplicatedStorage.NPC.NPCConsts)
function module.setup(arg1) -- Line 15
    local obj_upvr = arg1.obj
    local var15_upvw
    var15_upvw = BossNPCUtils_upvr.getMovementState(obj_upvr)
    arg1.maid:GiveTask(BossNPCUtils_upvr.getMovementStateChangedSignal(obj_upvr):Connect(function() -- Line 19, Named "handleMovement"
        var15_upvw = BossNPCUtils_upvr.getMovementState(obj_upvr)
    end))
    local var16_upvw
    arg1.maid.lastAttackMaidShared = nil
    local function handleAttackState() -- Line 27
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        var16_upvw = BossNPCUtils_upvr.getAttackState(obj_upvr)
        if not arg1:IsLocallyOwned() then return end
        local any_new_result1 = Maid_upvr.new()
        arg1.maid.lastAttackMaidShared = any_new_result1
        local var18_upvw = true
        any_new_result1:GiveTask(function() -- Line 38
            var18_upvw = false
        end)
        if var16_upvw == BossNPCConsts_upvr.ATTACK_STATE.ExtendoWhack then
            NPCUtils_upvr.setLookAt(obj_upvr, NPCUtils_upvr.getTarget(obj_upvr))
            any_new_result1:GiveTask(function() -- Line 43
                NPCUtils_upvr.setLookAt(obj_upvr, nil)
            end)
            any_new_result1:GiveTask(task.delay(BossNPCConsts_upvr.EXTENDO_WHACK_DURATION, function() -- Line 46
                if var18_upvw then
                    task.defer(BossNPCUtils_upvr.setAttackState, obj_upvr, BossNPCConsts_upvr.ATTACK_STATE.None)
                end
            end))
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        if var16_upvw == BossNPCConsts_upvr.ATTACK_STATE.LaserSweep then
            NPCUtils_upvr.setLookAt(obj_upvr, NPCUtils_upvr.getTarget(obj_upvr))
            any_new_result1:GiveTask(task.delay(BossNPCConsts_upvr.LASER_SWEEP_WARM_UP_DURATION, function() -- Line 55
                local tbl_upvr = {}
                for i, v in Players_upvr:GetPlayers() do
                    if v.Character and v.Character.PrimaryPart and MansionRobberyUtils_upvr.getIsPlayerInRobbery(arg1.obj.Parent, v) then
                        table.insert(tbl_upvr, v.Character.PrimaryPart)
                    end
                end
                local CFrame_upvr = obj_upvr.PrimaryPart.CFrame
                local function _() -- Line 73, Named "resort"
                    local any_generate2DPointClockwiseComparisonFunction_result1_upvr_2 = GeomUtils_upvr.generate2DPointClockwiseComparisonFunction()
                    table.sort(tbl_upvr, function(arg1_2, arg2) -- Line 75
                        local any_PointToObjectSpace_result1_4 = CFrame_upvr:PointToObjectSpace(arg1_2.Position)
                        local any_PointToObjectSpace_result1 = CFrame_upvr:PointToObjectSpace(arg2.Position)
                        return any_generate2DPointClockwiseComparisonFunction_result1_upvr_2(Vector2.new(any_PointToObjectSpace_result1_4.X, -any_PointToObjectSpace_result1_4.Z), Vector2.new(any_PointToObjectSpace_result1.X, -any_PointToObjectSpace_result1.Z))
                    end)
                end
                while true do
                    i = 0
                    if i >= #tbl_upvr then break end
                    if not var18_upvw then break end
                    i = table.sort
                    v = tbl_upvr
                    local any_generate2DPointClockwiseComparisonFunction_result1_upvr = GeomUtils_upvr.generate2DPointClockwiseComparisonFunction()
                    i(v, function(arg1_3, arg2) -- Line 75
                        local any_PointToObjectSpace_result1_3 = CFrame_upvr:PointToObjectSpace(arg1_3.Position)
                        local any_PointToObjectSpace_result1_2 = CFrame_upvr:PointToObjectSpace(arg2.Position)
                        return any_generate2DPointClockwiseComparisonFunction_result1_upvr(Vector2.new(any_PointToObjectSpace_result1_3.X, -any_PointToObjectSpace_result1_3.Z), Vector2.new(any_PointToObjectSpace_result1_2.X, -any_PointToObjectSpace_result1_2.Z))
                    end)
                    any_generate2DPointClockwiseComparisonFunction_result1_upvr = table.remove
                    i = tbl_upvr
                    v = 1
                    any_generate2DPointClockwiseComparisonFunction_result1_upvr = any_generate2DPointClockwiseComparisonFunction_result1_upvr(i, v)
                    i = NPCUtils_upvr
                    i = i.setTarget
                    v = obj_upvr
                    i(v, any_generate2DPointClockwiseComparisonFunction_result1_upvr)
                    i = NPCUtils_upvr
                    i = i.setLookAt
                    v = obj_upvr
                    i(v, NPCUtils_upvr.getTarget(obj_upvr))
                    i = task.wait
                    v = BossNPCConsts_upvr
                    v = v.LASER_SWEEP_TIME_BTWN_TARAGETS
                    i(v)
                end
                any_generate2DPointClockwiseComparisonFunction_result1_upvr = var18_upvw
                if any_generate2DPointClockwiseComparisonFunction_result1_upvr then
                    any_generate2DPointClockwiseComparisonFunction_result1_upvr = task.defer
                    i = BossNPCUtils_upvr
                    i = i.setAttackState
                    v = obj_upvr
                    any_generate2DPointClockwiseComparisonFunction_result1_upvr(i, v, BossNPCConsts_upvr.ATTACK_STATE.None)
                end
            end))
            any_new_result1:GiveTask(function() -- Line 103
                NPCUtils_upvr.setLookAt(obj_upvr, nil)
            end)
        elseif var16_upvw == BossNPCConsts_upvr.ATTACK_STATE.AuraBlast then
            local os_clock_result1_upvr = os.clock()
            local var41_upvw
            local Health_upvr = arg1.humanoid.Health
            var41_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 111
                local var43 = (os.clock() - os_clock_result1_upvr) / BossNPCConsts_upvr.AURA_BLAST_DURATION
                if 1 <= var43 then
                    var41_upvw:Disconnect()
                    task.defer(BossNPCUtils_upvr.setAttackState, obj_upvr, BossNPCConsts_upvr.ATTACK_STATE.None)
                else
                    arg1.humanoid.Health = math.min(Health_upvr + var43 * BossNPCConsts_upvr.AURA_BLAST_PERCENT_HEALTH_TO_RECOVER / 100 * arg1.humanoid.MaxHealth, arg1.humanoid.MaxHealth)
                end
            end)
            Audio_upvr.ObjectLocal(arg1.obj.PrimaryPart, 11793816932, {
                Volume = 1;
                RollOffMinDistance = 128;
            })
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end
    handleAttackState()
    arg1.maid:GiveTask(BossNPCUtils_upvr.getAttackStateChangedSignal(obj_upvr):Connect(handleAttackState))
    local function goToTargetPos_upvr(arg1_4) -- Line 131, Named "goToTargetPos"
        if var16_upvw ~= BossNPCConsts_upvr.ATTACK_STATE.None and var16_upvw ~= BossNPCConsts_upvr.ATTACK_STATE.LockedNone then
            NPCShared_upvr.move(arg1.humanoid, Vector3.new(0, 0, 0))
        else
            if var15_upvw == BossNPCConsts_upvr.MOVEMENT_STATE.StrafeTarget then
                local any_getHomePosition_result1 = NPCUtils_upvr.getHomePosition(obj_upvr)
                local var46 = arg1_4 - (arg1_4 - any_getHomePosition_result1).Unit * 20 - any_getHomePosition_result1
                if 80 < var46.Magnitude then
                    var46 = var46.Unit * 80
                end
                NPCShared_upvr.goTo(arg1, any_getHomePosition_result1 + var46)
                return
            end
            if var15_upvw == BossNPCConsts_upvr.MOVEMENT_STATE.GoToTarget then
                NPCShared_upvr.goTo(arg1, arg1_4)
            end
        end
    end
    function arg1.customUpdateTarget(arg1_5, arg2) -- Line 152
        if NPCUtils_upvr.getTargetType(obj_upvr) == NPCConsts_upvr.DEST_TYPE.OBJ then
            local any_getTarget_result1_upvr = NPCUtils_upvr.getTarget(obj_upvr)
            if not any_getTarget_result1_upvr then
                return false
            end
            arg2:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 159
                goToTargetPos_upvr(any_getTarget_result1_upvr.Position)
            end))
            return true
        end
        any_getTarget_result1_upvr = false
        return any_getTarget_result1_upvr
    end
end
return module
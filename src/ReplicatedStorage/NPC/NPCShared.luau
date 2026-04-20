local ReplicatedStorage = game:GetService("ReplicatedStorage")
local NPCConsts_upvr = require(ReplicatedStorage.NPC.NPCConsts)
local module_upvr = {}
local Signal_upvr = require(ReplicatedStorage.Std.Signal)
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local NPCUtils_upvr = require(ReplicatedStorage.NPC.NPCUtils)
local RunService_upvr = game:GetService("RunService")
local GeomUtils_upvr = require(ReplicatedStorage.Std.GeomUtils)
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
local Region_upvr = require(ReplicatedStorage.Std.Region)
local RegionUtils_upvr = require(ReplicatedStorage.Std.Region.RegionUtils)
function module_upvr.setup(arg1) -- Line 23
    local obj_upvr = arg1.obj
    arg1.maid:GiveTask(function() -- Line 26
        if arg1._path then
            arg1._path:Destroy()
            arg1._path = nil
        end
        arg1._waypoints = nil
    end)
    arg1._waypoints = nil
    arg1._nextWaypointIndex = nil
    arg1.maid.reachedConnection = nil
    arg1._lastJump = 0
    arg1.onWaypoint = Signal_upvr.new()
    function arg1.shouldMoveToNextWaypointFunc() -- Line 41
        return true
    end
    arg1.lookAtConstraint = nil
    arg1.maid:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(obj_upvr, NPCConsts_upvr.LOOK_AT_CONSTRAINT_NAME, function(arg1_2, arg2) -- Line 50
        arg1.lookAtConstraint = arg1_2
        arg2:GiveTask(function() -- Line 52
            arg1.lookAtConstraint = nil
        end)
    end))
    local function updateTarget_upvr() -- Line 59, Named "updateTarget"
        local any_new_result1 = Maid_upvr.new()
        arg1.maid.targetMaid = any_new_result1
        if not arg1:IsLocallyOwned() then
        else
            if arg1.customUpdateTarget and arg1:customUpdateTarget(any_new_result1) == true then return end
            local any_getTargetType_result1 = NPCUtils_upvr.getTargetType(obj_upvr)
            if any_getTargetType_result1 then
                if any_getTargetType_result1 == NPCConsts_upvr.DEST_TYPE.OBJ then
                    if not NPCUtils_upvr.getTarget(obj_upvr) then
                    else
                        any_new_result1:GiveTask(RunService_upvr.PostSimulation:Connect(function() -- Line 81
                            -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
                            local var21
                            if not obj_upvr.PrimaryPart then
                            else
                                local any_getTarget_result1 = NPCUtils_upvr.getTarget(obj_upvr)
                                local Position = any_getTarget_result1.Position
                                local Magnitude = (any_getTarget_result1.Velocity * Vector3.new(1, 0, 1)).Magnitude
                                local Position_2 = obj_upvr.PrimaryPart.Position
                                var21 = nil
                                if 0.1 < Magnitude then
                                    var21 = (any_getTarget_result1.Velocity * Vector3.new(1, 0, 1)).Unit
                                else
                                    var21 = Vector3.new(0, 0, 0)
                                end
                                if not GeomUtils_upvr.getTrajectoryInterceptTime(Position_2, obj_upvr.PrimaryPart.Velocity.Magnitude, Position, Magnitude, var21) then
                                end
                                if NPCUtils_upvr.getExtrapolateTargetMovement(obj_upvr) then
                                end
                                local var26 = true
                                if arg1.hasAllowedRegion then
                                    var26 = arg1.allowedRegion:CastPoint(Position)
                                end
                                local any_getHomePosition_result1 = NPCUtils_upvr.getHomePosition(obj_upvr)
                                if var26 then
                                    module_upvr.goTo(arg1, Position + (var21 * Magnitude) * (math.clamp(((Position - Position_2) * Vector3.new(1, 0, 1)).Magnitude / 36, 0, 1) * 3))
                                    return
                                end
                                if any_getHomePosition_result1 and not arg1.allowedRegion:CastPoint(Position_2) then
                                    module_upvr.goTo(arg1, any_getHomePosition_result1)
                                    return
                                end
                                module_upvr.move(arg1.humanoid, Vector3.new(0, 0, 0))
                            end
                        end))
                    end
                end
                if any_getTargetType_result1 == NPCConsts_upvr.DEST_TYPE.POS then
                    local any_getTarget_result1_3_upvr = NPCUtils_upvr.getTarget(obj_upvr)
                    if not any_getTarget_result1_3_upvr then
                    else
                        any_new_result1:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 141
                            module_upvr.goTo(arg1, any_getTarget_result1_3_upvr)
                        end))
                    end
                end
                any_getTarget_result1_3_upvr = NPCConsts_upvr
                any_getTarget_result1_3_upvr = any_getTarget_result1_3_upvr.DEST_TYPE
                any_getTarget_result1_3_upvr = any_getTarget_result1_3_upvr.IDLE
                if any_getTargetType_result1 == any_getTarget_result1_3_upvr then
                    any_getTarget_result1_3_upvr = nil
                    local var30_upvw = any_getTarget_result1_3_upvr
                    any_new_result1:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 147
                        if var30_upvw then
                            module_upvr.goTo(arg1, var30_upvw)
                        end
                    end))
                    any_new_result1:GiveTask(Interval_upvr.every(2):Connect(function() -- Line 152
                        local any_getTarget_result1_2 = NPCUtils_upvr.getTarget(obj_upvr)
                        if not any_getTarget_result1_2 then
                        else
                            local var34 = GeomUtils_upvr.randomPointOnCircle() * 16
                            if math.random() < 0.5 then
                                var30_upvw = any_getTarget_result1_2 + Vector3.new(var34.X, 0, var34.Y)
                            end
                        end
                    end))
                    return
                end
                error("invalid targeType", any_getTargetType_result1)
            end
        end
    end
    updateTarget_upvr()
    arg1.maid:GiveTask(obj_upvr:GetAttributeChangedSignal(NPCConsts_upvr.DEST_POS_ATTR_NAME):Connect(updateTarget_upvr))
    arg1.maid:GiveTask(obj_upvr:GetAttributeChangedSignal(NPCConsts_upvr.DEST_TYPE_ATTR_NAME):Connect(updateTarget_upvr))
    arg1.maid:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(obj_upvr, NPCConsts_upvr.DEST_OBJ_VALUE_NAME, function(arg1_3, arg2) -- Line 173
        updateTarget_upvr()
        arg2:GiveTask(arg1_3.Changed:Connect(updateTarget_upvr))
    end))
    arg1.maid:GiveTask(obj_upvr:GetAttributeChangedSignal(NPCConsts_upvr.NETWORK_OWNER_ID_ATTR_NAME):Connect(updateTarget_upvr))
    local function updateLookAt_upvr() -- Line 181, Named "updateLookAt"
        local any_new_result1_2 = Maid_upvr.new()
        arg1.maid.lookAtMaid = any_new_result1_2
        if not arg1:IsLocallyOwned() then
        else
            local any_getLookAtType_result1 = NPCUtils_upvr.getLookAtType(obj_upvr)
            if any_getLookAtType_result1 then
                if any_getLookAtType_result1 == NPCConsts_upvr.DEST_TYPE.OBJ then
                    local any_getLookAt_result1_upvr = NPCUtils_upvr.getLookAt(obj_upvr)
                    if not any_getLookAt_result1_upvr then return end
                    any_new_result1_2.runtime = RunService_upvr.Heartbeat:Connect(function() -- Line 196
                        module_upvr.lookAt(arg1, any_getLookAt_result1_upvr.Position)
                    end)
                else
                    any_getLookAt_result1_upvr = NPCConsts_upvr
                    any_getLookAt_result1_upvr = any_getLookAt_result1_upvr.DEST_TYPE
                    any_getLookAt_result1_upvr = any_getLookAt_result1_upvr.POS
                    if any_getLookAtType_result1 == any_getLookAt_result1_upvr then
                        any_getLookAt_result1_upvr = NPCUtils_upvr
                        any_getLookAt_result1_upvr = any_getLookAt_result1_upvr.getLookAt(obj_upvr)
                        local var40_upvr = any_getLookAt_result1_upvr
                        if not var40_upvr then return end
                        any_new_result1_2.runtime = RunService_upvr.Heartbeat:Connect(function() -- Line 204
                            module_upvr.lookAt(arg1, var40_upvr)
                        end)
                    end
                end
            end
            var40_upvr = any_new_result1_2:GiveTask
            var40_upvr(function() -- Line 209
                if arg1.lookAtConstraint then
                    arg1.lookAtConstraint.Enabled = false
                end
            end)
        end
    end
    updateLookAt_upvr()
    arg1.maid:GiveTask(obj_upvr:GetAttributeChangedSignal(NPCConsts_upvr.LOOK_AT_POS_ATTR_NAME):Connect(updateLookAt_upvr))
    arg1.maid:GiveTask(obj_upvr:GetAttributeChangedSignal(NPCConsts_upvr.LOOK_AT_TYPE_ATTR_NAME):Connect(updateLookAt_upvr))
    arg1.maid:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(obj_upvr, NPCConsts_upvr.LOOK_AT_OBJ_VALUE_NAME, function(arg1_4, arg2) -- Line 219
        updateLookAt_upvr()
        arg2:GiveTask(arg1_4.Changed:Connect(updateLookAt_upvr))
    end))
    arg1.maid:GiveTask(obj_upvr:GetAttributeChangedSignal(NPCConsts_upvr.NETWORK_OWNER_ID_ATTR_NAME):Connect(updateLookAt_upvr))
    arg1.maid:GiveTask(Interval_upvr.every(1):Connect(function() -- Line 226
        module_upvr._createNewPath(arg1)
        module_upvr._updatePathfind(arg1)
    end))
    arg1.maid:GiveTask(Interval_upvr.every(1):Connect(function() -- Line 233
        if arg1:IsLocallyOwned() then
            local tbl = {
                [Enum.HumanoidStateType.Dead] = true;
                [Enum.HumanoidStateType.Running] = true;
                [Enum.HumanoidStateType.Jumping] = true;
                [Enum.HumanoidStateType.Landed] = true;
                [Enum.HumanoidStateType.Freefall] = true;
            }
            local humanoid = arg1.humanoid
            for _, v in ipairs(Enum.HumanoidStateType:GetEnumItems()) do
                if v ~= Enum.HumanoidStateType.None and humanoid:GetStateEnabled(v) and not tbl[v] then
                    humanoid:SetStateEnabled(v, false)
                end
            end
            if not tbl[humanoid:GetState()] then
                humanoid:ChangeState(Enum.HumanoidStateType.Running)
            end
        end
    end))
    local RaycastParams_new_result1_upvr = RaycastParams.new()
    RaycastParams_new_result1_upvr.FilterType = Enum.RaycastFilterType.Blacklist
    RaycastParams_new_result1_upvr.FilterDescendantsInstances = {}
    RaycastParams_new_result1_upvr.IgnoreWater = true
    arg1.occlusionCastParams = RaycastParams_new_result1_upvr
    arg1.maid:GiveTask(Interval_upvr.every(1):Connect(function() -- Line 259
        RaycastParams_new_result1_upvr.FilterDescendantsInstances = module_upvr._buildOcclusionBlacklist(arg1)
    end))
    arg1.allowedRegion = Region_upvr.new(RegionUtils_upvr.NilCondition)
    arg1.maid:GiveTask(arg1.allowedRegion)
    arg1.hasAllowedRegion = false
    arg1.maid:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(obj_upvr, NPCConsts_upvr.ALLOWED_PRISMS_FOLDER_NAME, function(arg1_5, arg2) -- Line 271
        arg2:GiveTask(RxInstanceUtils_upvr.observeChildren(arg1_5, function(arg1_6, arg2_2) -- Line 275
            local tbl_4_upvr = {
                c = CFrame.new();
                s = Vector3.new();
            }
            arg2_2:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(arg1_6, 'c', function(arg1_7) -- Line 278
                tbl_4_upvr.c = arg1_7.Value
            end))
            arg2_2:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(arg1_6, 's', function(arg1_8) -- Line 283
                tbl_4_upvr.s = arg1_8.Value
            end))
            local any_AddPrism_result1 = arg1.allowedRegion:AddPrism(tbl_4_upvr)
            arg2_2:GiveTask(any_AddPrism_result1)
            if 0 >= #arg1_5:GetChildren() then
                any_AddPrism_result1 = false
            else
                any_AddPrism_result1 = true
            end
            arg1.hasAllowedRegion = any_AddPrism_result1
            arg2_2:GiveTask(function() -- Line 289, Named "f"
                local var61
                if 0 >= #arg1_5:GetChildren() then
                    var61 = false
                else
                    var61 = true
                end
                arg1.hasAllowedRegion = var61
            end)
        end))
    end))
    arg1.maid:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(obj_upvr, NPCConsts_upvr.HOME_POSITION_OBJ_NAME, function(arg1_9, arg2) -- Line 306
        arg1.homePosition = NPCUtils_upvr.getHomePosition(obj_upvr)
        arg2:GiveTask(arg1_9.Changed:Connect(function() -- Line 307, Named "update"
            arg1.homePosition = NPCUtils_upvr.getHomePosition(obj_upvr)
        end))
        arg2:GiveTask(function() -- Line 312
            arg1.homePosition = nil
        end)
    end))
end
local CollectionService_upvr = game:GetService("CollectionService")
local Players_upvr = game:GetService("Players")
local DestructibleConsts_upvr = require(ReplicatedStorage.Game.Destructible.DestructibleConsts)
function module_upvr._buildOcclusionBlacklist(arg1) -- Line 319
    local module_2 = {arg1.obj}
    local tbl_3 = {}
    for _, v_2 in CollectionService_upvr:GetTagged("Humanoid") do
        tbl_3[v_2] = true
        table.insert(module_2, v_2.Parent)
    end
    for _, v_3 in ipairs(Players_upvr:GetPlayers()) do
        if v_3.Character then
            local Humanoid = v_3.Character:FindFirstChild("Humanoid")
            if Humanoid and not tbl_3[Humanoid.Parent] then
                table.insert(module_2, Humanoid.Parent)
            end
        end
    end
    for _, v_4 in CollectionService_upvr:GetTagged(DestructibleConsts_upvr.SPAWN_TAG_NAME) do
        if v_4:FindFirstChild(DestructibleConsts_upvr.INSTANCE_VALUE_NAME) and v_4[DestructibleConsts_upvr.INSTANCE_VALUE_NAME].Value then
            table.insert(module_2, v_4[DestructibleConsts_upvr.INSTANCE_VALUE_NAME].Value)
        end
    end
    return module_2
end
local PathfindingService_upvr = game:GetService("PathfindingService")
function module_upvr._createNewPath(arg1) -- Line 343
    if arg1._path then
        arg1._path:Destroy()
        arg1._path = nil
    end
    arg1._path = PathfindingService_upvr:CreatePath({
        AgentHeight = 4;
        AgentRadius = 2;
        WaypointSpacing = math.huge;
        Costs = arg1.agentCosts;
    })
end
function module_upvr.pathfindTo(arg1, arg2) -- Line 355
    arg1._pathfindTo = arg2
end
function module_upvr._updatePathfind(arg1) -- Line 358
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    module_upvr.move(arg1.humanoid, Vector3.new(0, 0, 0))
    do
        return
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if arg1.maid.reachedConnection then
        arg1.maid.reachedConnection = nil
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_upvr.lookAt(arg1, arg2) -- Line 426
    if arg1.lookAtConstraint ~= nil then
        if arg2 ~= nil then
            if not arg1.lookAtConstraint.Enabled then
                arg1.lookAtConstraint.Enabled = true
            end
            arg1.lookAtConstraint.CFrame = CFrame.lookAt(arg1.lookAtConstraint.Attachment0.WorldPosition, arg2)
            return
        end
        if arg1.lookAtConstraint.Enabled then
            arg1.lookAtConstraint.Enabled = false
        end
    end
end
function module_upvr.goTo(arg1, arg2) -- Line 441
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    arg1._lastTargetOcclusionCheck = 0
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local Raycast_upvr = require(ReplicatedStorage.Std.Raycast)
function module_upvr.isNonOccluded(arg1, arg2, arg3) -- Line 468
    local Position_3 = arg1.Position
    local var119 = arg2 - Position_3
    if var119.Magnitude < 0.1 then
        return false
    end
    local any_collidable_result1 = Raycast_upvr.collidable(Position_3, var119.Unit, var119.Magnitude, arg3)
    if not any_collidable_result1 then
        return true
    end
    local Position_4 = any_collidable_result1.Position
    if (Position_4 - arg2).Magnitude >= 0.1 then
        Position_4 = false
    else
        Position_4 = true
    end
    return Position_4
end
function module_upvr.moveTo(arg1, arg2) -- Line 481
    arg1:MoveTo(arg2)
end
function module_upvr.moveTowards(arg1, arg2) -- Line 484
    module_upvr.move(arg1, (arg2 - arg1.RootPart.Position).Unit)
end
function module_upvr.zigZagTowards(arg1, arg2) -- Line 488
    local var122 = arg2 - arg1.RootPart.Position
    module_upvr.move(arg1, var122.Unit + (var122.Unit:Cross(Vector3.new(0, 1, 0))) * (math.cos(os.clock() * 7 + arg1.Parent:GetAttribute(NPCConsts_upvr.FREQ_OFFSET_ATTR_NAME)) * math.clamp(var122.Magnitude / 24, 0, 1)) * 0.3 * arg1.Parent:GetAttribute(NPCConsts_upvr.SIDE_STRAFE_MULT_ATTR_NAME))
end
function module_upvr.move(arg1, arg2) -- Line 498
    arg1:Move(arg2)
end
function module_upvr.getDistTo(arg1, arg2) -- Line 501
    return ((arg2 - arg1.Position) * Vector3.new(1, 0, 1)).Magnitude
end
return module_upvr
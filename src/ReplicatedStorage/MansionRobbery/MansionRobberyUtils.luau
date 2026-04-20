local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MansionRobberyConsts_upvr = require(ReplicatedStorage.MansionRobbery.MansionRobberyConsts)
local CollectionService_upvr = game:GetService("CollectionService")
local module_upvr = {}
local function _(arg1) -- Line 12, Named "validateObj"
    local var5
    if typeof(arg1) ~= "Instance" then
        var5 = false
    else
        var5 = true
    end
    assert(var5, "Invalid obj passed")
    var5 = CollectionService_upvr:HasTag(arg1, MansionRobberyConsts_upvr.TAG_NAME)
    assert(var5, "Obj does not have mansion robbery tag")
end
function module_upvr.setNumPlayersInElevator(arg1, arg2) -- Line 16
    local var6
    if typeof(arg1) ~= "Instance" then
        var6 = false
    else
        var6 = true
    end
    assert(var6, "Invalid obj passed")
    var6 = CollectionService_upvr:HasTag(arg1, MansionRobberyConsts_upvr.TAG_NAME)
    assert(var6, "Obj does not have mansion robbery tag")
    arg1:SetAttribute(MansionRobberyConsts_upvr.NUM_PLAYERS_IN_ELEVATOR_ATTR_NAME, arg2)
    return true
end
function module_upvr.getNumPlayersInElevator(arg1) -- Line 21
    local var7
    if typeof(arg1) ~= "Instance" then
        var7 = false
    else
        var7 = true
    end
    assert(var7, "Invalid obj passed")
    var7 = CollectionService_upvr:HasTag(arg1, MansionRobberyConsts_upvr.TAG_NAME)
    assert(var7, "Obj does not have mansion robbery tag")
    return arg1:GetAttribute(MansionRobberyConsts_upvr.NUM_PLAYERS_IN_ELEVATOR_ATTR_NAME)
end
function module_upvr.getNumPlayersInElevatorChangedSignal(arg1) -- Line 25
    local var8
    if typeof(arg1) ~= "Instance" then
        var8 = false
    else
        var8 = true
    end
    assert(var8, "Invalid obj passed")
    var8 = CollectionService_upvr:HasTag(arg1, MansionRobberyConsts_upvr.TAG_NAME)
    assert(var8, "Obj does not have mansion robbery tag")
    return arg1:GetAttributeChangedSignal(MansionRobberyConsts_upvr.NUM_PLAYERS_IN_ELEVATOR_ATTR_NAME)
end
function module_upvr.getIsElevatorMoving(arg1) -- Line 29
    local var9
    if typeof(arg1) ~= "Instance" then
        var9 = false
    else
        var9 = true
    end
    assert(var9, "Invalid obj passed")
    var9 = CollectionService_upvr:HasTag(arg1, MansionRobberyConsts_upvr.TAG_NAME)
    assert(var9, "Obj does not have mansion robbery tag")
    var9 = arg1
    var9 = module_upvr.getEntranceElevatorModel(var9):GetAttribute(MansionRobberyConsts_upvr.IS_ELEVATOR_MOVING_ATTR_NAME)
    return var9
end
function module_upvr.getIsElevatorMovingChangedSignal(arg1) -- Line 34
    local var10
    if typeof(arg1) ~= "Instance" then
        var10 = false
    else
        var10 = true
    end
    assert(var10, "Invalid obj passed")
    var10 = CollectionService_upvr:HasTag(arg1, MansionRobberyConsts_upvr.TAG_NAME)
    assert(var10, "Obj does not have mansion robbery tag")
    var10 = arg1
    var10 = module_upvr.getEntranceElevatorModel(var10):GetAttributeChangedSignal(MansionRobberyConsts_upvr.IS_ELEVATOR_MOVING_ATTR_NAME)
    return var10
end
function module_upvr.setIsElevatorMoving(arg1, arg2) -- Line 39
    local var11
    if typeof(arg1) ~= "Instance" then
        var11 = false
    else
        var11 = true
    end
    assert(var11, "Invalid obj passed")
    var11 = CollectionService_upvr:HasTag(arg1, MansionRobberyConsts_upvr.TAG_NAME)
    assert(var11, "Obj does not have mansion robbery tag")
    var11 = arg1
    var11 = module_upvr.getEntranceElevatorModel(var11):SetAttribute
    var11(MansionRobberyConsts_upvr.IS_ELEVATOR_MOVING_ATTR_NAME, arg2)
end
function module_upvr.getEntranceElevatorModel(arg1) -- Line 44
    local var12
    if typeof(arg1) ~= "Instance" then
        var12 = false
    else
        var12 = true
    end
    assert(var12, "Invalid obj passed")
    var12 = CollectionService_upvr:HasTag(arg1, MansionRobberyConsts_upvr.TAG_NAME)
    assert(var12, "Obj does not have mansion robbery tag")
    return arg1:FindFirstChild("Lobby"):FindFirstChild(MansionRobberyConsts_upvr.ENTRANCE_ELEVATOR_NAME)
end
function module_upvr.getEntranceElevatorFloorCFrame(arg1) -- Line 48
    local var13
    if typeof(arg1) ~= "Instance" then
        var13 = false
    else
        var13 = true
    end
    assert(var13, "Invalid obj passed")
    var13 = CollectionService_upvr:HasTag(arg1, MansionRobberyConsts_upvr.TAG_NAME)
    assert(var13, "Obj does not have mansion robbery tag")
    var13 = arg1
    return module_upvr.getEntranceElevatorModel(var13):FindFirstChild("Floor", true).CFrame
end
function module_upvr.getArrivalElevatorModel(arg1) -- Line 52
    local var14
    if typeof(arg1) ~= "Instance" then
        var14 = false
    else
        var14 = true
    end
    assert(var14, "Invalid obj passed")
    var14 = CollectionService_upvr:HasTag(arg1, MansionRobberyConsts_upvr.TAG_NAME)
    assert(var14, "Obj does not have mansion robbery tag")
    return arg1:FindFirstChild(MansionRobberyConsts_upvr.ARRIVAL_ELEVATOR_NAME)
end
function module_upvr.getArrivalElevatorFloorCFrame(arg1) -- Line 56
    local var15
    if typeof(arg1) ~= "Instance" then
        var15 = false
    else
        var15 = true
    end
    assert(var15, "Invalid obj passed")
    var15 = CollectionService_upvr:HasTag(arg1, MansionRobberyConsts_upvr.TAG_NAME)
    assert(var15, "Obj does not have mansion robbery tag")
    var15 = arg1
    return module_upvr.getArrivalElevatorModel(var15):FindFirstChild("Floor", true).CFrame
end
local CharacterUtils_upvr = require(ReplicatedStorage.Std.CharacterUtils)
local RegionUtils_upvr = require(ReplicatedStorage.Std.Region.RegionUtils)
function module_upvr.isPlayerInElevator(arg1, arg2) -- Line 60
    local var18
    if typeof(arg1) ~= "Instance" then
        var18 = false
    else
        var18 = true
    end
    assert(var18, "Invalid obj passed")
    var18 = CollectionService_upvr:HasTag(arg1, MansionRobberyConsts_upvr.TAG_NAME)
    assert(var18, "Obj does not have mansion robbery tag")
    if not arg2 then
        var18 = "Invalid player passed"
        warn(var18)
        return false
    end
    local Character = arg2.Character
    if Character then
        var18 = CharacterUtils_upvr
        var18 = var18.getRootPart(Character)
        return RegionUtils_upvr.isPointInPart(module_upvr.getEntranceElevatorModel(arg1).PrimaryPart, var18.Position)
    end
    var18 = false
    return var18
end
function module_upvr.getShieldsFolder(arg1) -- Line 76
    return arg1:FindFirstChild(MansionRobberyConsts_upvr.SHIELD_MODELS_FOLDER_NAME)
end
function module_upvr.getShields(arg1) -- Line 79
    local var20
    if typeof(arg1) ~= "Instance" then
        var20 = false
    else
        var20 = true
    end
    assert(var20, "Invalid obj passed")
    var20 = CollectionService_upvr:HasTag(arg1, MansionRobberyConsts_upvr.TAG_NAME)
    assert(var20, "Obj does not have mansion robbery tag")
    var20 = arg1
    if not module_upvr.getShieldsFolder(var20) then
        var20 = warn
        var20("No shield models folder")
        var20 = {}
        return var20
    end
    var20 = module_upvr.getShieldsFolder(var20):GetChildren()
    return var20
end
function module_upvr.getProgressionState(arg1) -- Line 88
    local var22
    if typeof(arg1) ~= "Instance" then
        var22 = false
    else
        var22 = true
    end
    assert(var22, "Invalid obj passed")
    var22 = CollectionService_upvr:HasTag(arg1, MansionRobberyConsts_upvr.TAG_NAME)
    assert(var22, "Obj does not have mansion robbery tag")
    return arg1:GetAttribute(MansionRobberyConsts_upvr.PROGRESSION_STATE_ATTR_NAME)
end
function module_upvr.setProgressionState(arg1, arg2) -- Line 92
    local var23
    if typeof(arg1) ~= "Instance" then
        var23 = false
    else
        var23 = true
    end
    assert(var23, "Invalid obj passed")
    var23 = CollectionService_upvr:HasTag(arg1, MansionRobberyConsts_upvr.TAG_NAME)
    assert(var23, "Obj does not have mansion robbery tag")
    arg1:SetAttribute(MansionRobberyConsts_upvr.PROGRESSION_STATE_ATTR_NAME, arg2)
    return true
end
function module_upvr.getProgressionStateChangedSignal(arg1) -- Line 97
    local var24
    if typeof(arg1) ~= "Instance" then
        var24 = false
    else
        var24 = true
    end
    assert(var24, "Invalid obj passed")
    var24 = CollectionService_upvr:HasTag(arg1, MansionRobberyConsts_upvr.TAG_NAME)
    assert(var24, "Obj does not have mansion robbery tag")
    return arg1:GetAttributeChangedSignal(MansionRobberyConsts_upvr.PROGRESSION_STATE_ATTR_NAME)
end
function module_upvr.getExitTeleportationPoints(arg1) -- Line 101
    local var25
    if typeof(arg1) ~= "Instance" then
        var25 = false
    else
        var25 = true
    end
    assert(var25, "Invalid obj passed")
    var25 = CollectionService_upvr:HasTag(arg1, MansionRobberyConsts_upvr.TAG_NAME)
    assert(var25, "Obj does not have mansion robbery tag")
    return arg1:FindFirstChild("Lobby"):FindFirstChild(MansionRobberyConsts_upvr.EXIT_TELEPORTS_FOLDER_NAME):GetChildren()
end
function module_upvr.getRandomExitTeleportationCFrame(arg1) -- Line 105
    local var26
    if typeof(arg1) ~= "Instance" then
        var26 = false
    else
        var26 = true
    end
    assert(var26, "Invalid obj passed")
    var26 = CollectionService_upvr:HasTag(arg1, MansionRobberyConsts_upvr.TAG_NAME)
    assert(var26, "Obj does not have mansion robbery tag")
    var26 = arg1
    local any_getExitTeleportationPoints_result1 = module_upvr.getExitTeleportationPoints(var26)
    var26 = any_getExitTeleportationPoints_result1[math.random(#any_getExitTeleportationPoints_result1)].CFrame * CFrame.new(0, 5, 0)
    return var26
end
function module_upvr.getIsPlayerInRobbery(arg1, arg2) -- Line 110
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var28
    if typeof(arg1) ~= "Instance" then
        var28 = false
    else
        var28 = true
    end
    assert(var28, "Invalid obj passed")
    var28 = CollectionService_upvr:HasTag(arg1, MansionRobberyConsts_upvr.TAG_NAME)
    assert(var28, "Obj does not have mansion robbery tag")
    var28 = arg1:FindFirstChild(MansionRobberyConsts_upvr.IN_ROBBERY_FOLDER_NAME):FindFirstChild(arg2.UserId)
    if var28 then
        if var28.Value ~= true then
        else
        end
    end
    return true
end
function module_upvr.setLastClosedTime(arg1) -- Line 116
    local var29
    if typeof(arg1) ~= "Instance" then
        var29 = false
    else
        var29 = true
    end
    assert(var29, "Invalid obj passed")
    var29 = CollectionService_upvr:HasTag(arg1, MansionRobberyConsts_upvr.TAG_NAME)
    assert(var29, "Obj does not have mansion robbery tag")
    arg1:SetAttribute(MansionRobberyConsts_upvr.LAST_CLOSED_TIME_ATTR_NAME, workspace:GetServerTimeNow())
    return true
end
function module_upvr.getLastClosedTime(arg1) -- Line 121
    local var30
    if typeof(arg1) ~= "Instance" then
        var30 = false
    else
        var30 = true
    end
    assert(var30, "Invalid obj passed")
    var30 = CollectionService_upvr:HasTag(arg1, MansionRobberyConsts_upvr.TAG_NAME)
    assert(var30, "Obj does not have mansion robbery tag")
    return arg1:GetAttribute(MansionRobberyConsts_upvr.LAST_CLOSED_TIME_ATTR_NAME)
end
function module_upvr.getBossRoomPlayerSpawns(arg1) -- Line 125
    local var31
    if typeof(arg1) ~= "Instance" then
        var31 = false
    else
        var31 = true
    end
    assert(var31, "Invalid obj passed")
    var31 = CollectionService_upvr:HasTag(arg1, MansionRobberyConsts_upvr.TAG_NAME)
    assert(var31, "Obj does not have mansion robbery tag")
    return arg1:FindFirstChild(MansionRobberyConsts_upvr.BOSS_ROOM_PLAYER_SPAWNS_FOLDER_NAME):GetChildren()
end
function module_upvr.getRandomBossRoomPlayerSpawn(arg1) -- Line 129
    local var32
    if typeof(arg1) ~= "Instance" then
        var32 = false
    else
        var32 = true
    end
    assert(var32, "Invalid obj passed")
    var32 = CollectionService_upvr:HasTag(arg1, MansionRobberyConsts_upvr.TAG_NAME)
    assert(var32, "Obj does not have mansion robbery tag")
    var32 = arg1
    local any_getBossRoomPlayerSpawns_result1 = module_upvr.getBossRoomPlayerSpawns(var32)
    var32 = any_getBossRoomPlayerSpawns_result1[math.random(#any_getBossRoomPlayerSpawns_result1)]
    return var32
end
local TableUtils_upvr = require(ReplicatedStorage.Std.TableUtils)
local Players_upvr = game:GetService("Players")
function module_upvr.getPlayersInRobbery(arg1) -- Line 134
    local var36
    if typeof(arg1) ~= "Instance" then
        var36 = false
    else
        var36 = true
    end
    assert(var36, "Invalid obj passed")
    var36 = CollectionService_upvr:HasTag(arg1, MansionRobberyConsts_upvr.TAG_NAME)
    assert(var36, "Obj does not have mansion robbery tag")
    var36 = Players_upvr:GetPlayers()
    return TableUtils_upvr.filter(var36, function(arg1_2) -- Line 136
        return module_upvr.getIsPlayerInRobbery(arg1, arg1_2)
    end)
end
function module_upvr.setShieldLastDownTime(arg1, arg2) -- Line 140
    arg1:SetAttribute(MansionRobberyConsts_upvr.SHIELD_LAST_DOWN_TIME_ATTR_NAME, arg2)
    return true
end
function module_upvr.getShieldLastDownTime(arg1) -- Line 144
    return arg1:GetAttribute(MansionRobberyConsts_upvr.SHIELD_LAST_DOWN_TIME_ATTR_NAME) or 0
end
function module_upvr.getFinalExitDoor(arg1) -- Line 147
    local var38
    if typeof(arg1) ~= "Instance" then
        var38 = false
    else
        var38 = true
    end
    assert(var38, "Invalid obj passed")
    var38 = CollectionService_upvr:HasTag(arg1, MansionRobberyConsts_upvr.TAG_NAME)
    assert(var38, "Obj does not have mansion robbery tag")
    return arg1:FindFirstChild("ExitDoor")
end
return module_upvr
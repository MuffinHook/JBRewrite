local CollectionService_upvr = game:GetService("CollectionService")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local OilRigConsts_upvr = require(ReplicatedStorage_upvr.OilRig.OilRigConsts)
local TableUtils_upvr = require(ReplicatedStorage_upvr.Std.TableUtils)
local module = {}
local function _(arg1) -- Line 8, Named "validateObj"
    local var6
    if typeof(arg1) ~= "Instance" then
        var6 = false
    else
        var6 = true
    end
    assert(var6, "Invalid obj passed")
    var6 = CollectionService_upvr:HasTag(arg1, OilRigConsts_upvr.TAG_NAME)
    assert(var6, "Obj does not have oil rig robbery tag")
end
function module.setLastClosedTime(arg1, arg2) -- Line 12
    local var7
    if typeof(arg1) ~= "Instance" then
        var7 = false
    else
        var7 = true
    end
    assert(var7, "Invalid obj passed")
    var7 = CollectionService_upvr:HasTag(arg1, OilRigConsts_upvr.TAG_NAME)
    assert(var7, "Obj does not have oil rig robbery tag")
    arg1:SetAttribute(OilRigConsts_upvr.LAST_CLOSED_TIME_ATTR_NAME, arg2)
    return true
end
function module.getLastClosedTime(arg1) -- Line 17
    local var8
    if typeof(arg1) ~= "Instance" then
        var8 = false
    else
        var8 = true
    end
    assert(var8, "Invalid obj passed")
    var8 = CollectionService_upvr:HasTag(arg1, OilRigConsts_upvr.TAG_NAME)
    assert(var8, "Obj does not have oil rig robbery tag")
    return arg1:GetAttribute(OilRigConsts_upvr.LAST_CLOSED_TIME_ATTR_NAME)
end
function module.setLastStartedTime(arg1, arg2) -- Line 21
    local var9
    if typeof(arg1) ~= "Instance" then
        var9 = false
    else
        var9 = true
    end
    assert(var9, "Invalid obj passed")
    var9 = CollectionService_upvr:HasTag(arg1, OilRigConsts_upvr.TAG_NAME)
    assert(var9, "Obj does not have oil rig robbery tag")
    arg1:SetAttribute(OilRigConsts_upvr.LAST_STARTED_TIME_ATTR_NAME, arg2)
    return true
end
function module.getLastStartedTime(arg1) -- Line 26
    local var10
    if typeof(arg1) ~= "Instance" then
        var10 = false
    else
        var10 = true
    end
    assert(var10, "Invalid obj passed")
    var10 = CollectionService_upvr:HasTag(arg1, OilRigConsts_upvr.TAG_NAME)
    assert(var10, "Obj does not have oil rig robbery tag")
    return arg1:GetAttribute(OilRigConsts_upvr.LAST_STARTED_TIME_ATTR_NAME)
end
function module.getProgressionState(arg1) -- Line 30
    local var11
    if typeof(arg1) ~= "Instance" then
        var11 = false
    else
        var11 = true
    end
    assert(var11, "Invalid obj passed")
    var11 = CollectionService_upvr:HasTag(arg1, OilRigConsts_upvr.TAG_NAME)
    assert(var11, "Obj does not have oil rig robbery tag")
    return arg1:GetAttribute(OilRigConsts_upvr.PROGRESSION_STATE_ATTR_NAME)
end
function module.setProgressionState(arg1, arg2) -- Line 34
    local var12
    if typeof(arg1) ~= "Instance" then
        var12 = false
    else
        var12 = true
    end
    assert(var12, "Invalid obj passed")
    var12 = CollectionService_upvr:HasTag(arg1, OilRigConsts_upvr.TAG_NAME)
    assert(var12, "Obj does not have oil rig robbery tag")
    arg1:SetAttribute(OilRigConsts_upvr.PROGRESSION_STATE_ATTR_NAME, arg2)
    return true
end
function module.getProgressionStateChangedSignal(arg1) -- Line 39
    local var13
    if typeof(arg1) ~= "Instance" then
        var13 = false
    else
        var13 = true
    end
    assert(var13, "Invalid obj passed")
    var13 = CollectionService_upvr:HasTag(arg1, OilRigConsts_upvr.TAG_NAME)
    assert(var13, "Obj does not have oil rig robbery tag")
    return arg1:GetAttributeChangedSignal(OilRigConsts_upvr.PROGRESSION_STATE_ATTR_NAME)
end
function module.getNPCSpawnLocations(arg1, arg2, arg3) -- Line 44
    local var14
    if typeof(arg1) ~= "Instance" then
        var14 = false
    else
        var14 = true
    end
    assert(var14, "Invalid obj passed")
    var14 = CollectionService_upvr:HasTag(arg1, OilRigConsts_upvr.TAG_NAME)
    assert(var14, "Obj does not have oil rig robbery tag")
    var14 = TableUtils_upvr
    var14 = var14.filter
    var14 = var14(arg1:FindFirstChild(OilRigConsts_upvr.NPC_SPAWNS_FOLDER_NAME):FindFirstChild(arg2):GetChildren(), function(arg1_2) -- Line 47
        local var16
        if arg1_2.Name ~= arg3 then
            var16 = false
        else
            var16 = true
        end
        return var16
    end)
    return var14
end
function module.getFloor2GuardInRoomSpawnLocations(arg1) -- Line 51
    local var17
    if typeof(arg1) ~= "Instance" then
        var17 = false
    else
        var17 = true
    end
    assert(var17, "Invalid obj passed")
    var17 = CollectionService_upvr:HasTag(arg1, OilRigConsts_upvr.TAG_NAME)
    assert(var17, "Obj does not have oil rig robbery tag")
    var17 = arg1:FindFirstChild("NPCSpawns"):FindFirstChild("Floor2"):GetDescendants()
    return TableUtils_upvr.filter(var17, function(arg1_3) -- Line 55
        return arg1_3:IsA("BasePart")
    end)
end
function module.getIsPlayerInRobbery(arg1, arg2) -- Line 61
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var19
    if typeof(arg1) ~= "Instance" then
        var19 = false
    else
        var19 = true
    end
    assert(var19, "Invalid obj passed")
    var19 = CollectionService_upvr:HasTag(arg1, OilRigConsts_upvr.TAG_NAME)
    assert(var19, "Obj does not have oil rig robbery tag")
    var19 = arg1:FindFirstChild(OilRigConsts_upvr.PLAYERS_IN_ROBBERY_FOLDER_NAME):FindFirstChild(arg2.UserId)
    if var19 then
        if var19.Value ~= true then
        else
        end
    end
    return true
end
function module.getTNTModel(arg1) -- Line 67
    local var20
    if typeof(arg1) ~= "Instance" then
        var20 = false
    else
        var20 = true
    end
    assert(var20, "Invalid obj passed")
    var20 = CollectionService_upvr:HasTag(arg1, OilRigConsts_upvr.TAG_NAME)
    assert(var20, "Obj does not have oil rig robbery tag")
    local clone = ReplicatedStorage_upvr.OilRig.Res.TNT:Clone()
    var20 = CollectionService_upvr:AddTag
    var20(clone, OilRigConsts_upvr.TNT_MODEL_TAG_NAME)
    return clone
end
function module.updateTNTTimers(arg1, arg2) -- Line 73
    local var26
    if typeof(arg1) ~= "Instance" then
        var26 = false
    else
        var26 = true
    end
    assert(var26, "Invalid obj passed")
    var26 = CollectionService_upvr:HasTag(arg1, OilRigConsts_upvr.TAG_NAME)
    assert(var26, "Obj does not have oil rig robbery tag")
    var26 = CollectionService_upvr:GetTagged(OilRigConsts_upvr.TNT_MODEL_TAG_NAME)
    var26 = TableUtils_upvr.filter(var26, function(arg1_4) -- Line 75
        return arg1_4:IsDescendantOf(arg1)
    end)
    for _, v in var26 do
        local TextLabel = v:FindFirstChild("Timer"):FindFirstChild("SurfaceGui"):FindFirstChild("TextLabel")
        TextLabel.TextScaled = true
        TextLabel.Text = arg2
    end
end
function module.getExteriorCountdown(arg1) -- Line 84
    local var29
    if typeof(arg1) ~= "Instance" then
        var29 = false
    else
        var29 = true
    end
    assert(var29, "Invalid obj passed")
    var29 = CollectionService_upvr:HasTag(arg1, OilRigConsts_upvr.TAG_NAME)
    assert(var29, "Obj does not have oil rig robbery tag")
    if arg1:FindFirstChild("ExteriorCountdown") and arg1.ExteriorCountdown:FindFirstChild("SurfaceGui") and arg1.ExteriorCountdown.SurfaceGui:FindFirstChild("TextLabel") then
        var29 = arg1.ExteriorCountdown
        var29 = var29.SurfaceGui
        var29 = var29.TextLabel
        return arg1.ExteriorCountdown.SurfaceGui, var29
    end
end
function module.getActiveRobberyRegionPart(arg1) -- Line 94
    local var30
    if typeof(arg1) ~= "Instance" then
        var30 = false
    else
        var30 = true
    end
    assert(var30, "Invalid obj passed")
    var30 = CollectionService_upvr:HasTag(arg1, OilRigConsts_upvr.TAG_NAME)
    assert(var30, "Obj does not have oil rig robbery tag")
    return arg1:FindFirstChild("ActiveRobberyRegion")
end
function module.getTNTPlacementParts(arg1) -- Line 98
    local var31
    if typeof(arg1) ~= "Instance" then
        var31 = false
    else
        var31 = true
    end
    assert(var31, "Invalid obj passed")
    var31 = CollectionService_upvr:HasTag(arg1, OilRigConsts_upvr.TAG_NAME)
    assert(var31, "Obj does not have oil rig robbery tag")
    return arg1:FindFirstChild("TNTPlantLocations"):GetChildren()
end
return module
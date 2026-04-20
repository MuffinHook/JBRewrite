local CollectionService_upvr = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GuardNPCConsts_upvr = require(ReplicatedStorage.GuardNPC.GuardNPCConsts)
local NPCConsts_upvr = require(ReplicatedStorage.NPC.NPCConsts)
local module_upvr = {}
local function _(arg1) -- Line 7, Named "validateObj"
    local var6
    if typeof(arg1) ~= "Instance" then
        var6 = false
    else
        var6 = true
    end
    assert(var6, "Invalid obj passed")
    var6 = CollectionService_upvr:HasTag(arg1, GuardNPCConsts_upvr.TAG_NAME)
    assert(var6, "Obj does not have guard npc tag")
end
function module_upvr.setBulletSpread(arg1, arg2) -- Line 12
    local var7
    if typeof(arg1) ~= "Instance" then
        var7 = false
    else
        var7 = true
    end
    assert(var7, "Invalid obj passed")
    var7 = CollectionService_upvr:HasTag(arg1, GuardNPCConsts_upvr.TAG_NAME)
    assert(var7, "Obj does not have guard npc tag")
    arg1:SetAttribute(GuardNPCConsts_upvr.BULLET_SPREAD_ATTR_NAME, arg2)
    return true
end
function module_upvr.getBulletSpread(arg1) -- Line 17
    local var8
    if typeof(arg1) ~= "Instance" then
        var8 = false
    else
        var8 = true
    end
    assert(var8, "Invalid obj passed")
    var8 = CollectionService_upvr:HasTag(arg1, GuardNPCConsts_upvr.TAG_NAME)
    assert(var8, "Obj does not have guard npc tag")
    return arg1:GetAttribute(GuardNPCConsts_upvr.BULLET_SPREAD_ATTR_NAME)
end
function module_upvr.getTriggerPressFreq(arg1) -- Line 21
    return arg1:GetAttribute(GuardNPCConsts_upvr.TRIGGER_PRESS_FREQ_ATTR_NAME)
end
function module_upvr.getTriggerPressFreqChanged(arg1) -- Line 24
    return arg1:GetAttributeChangedSignal(GuardNPCConsts_upvr.TRIGGER_PRESS_FREQ_ATTR_NAME)
end
function module_upvr.setTriggerPressFreq(arg1, arg2) -- Line 27
    arg1:SetAttribute(GuardNPCConsts_upvr.TRIGGER_PRESS_FREQ_ATTR_NAME, arg2)
    return true
end
function module_upvr.getItemName(arg1) -- Line 31
    return arg1:GetAttribute(GuardNPCConsts_upvr.ITEM_NAME_ATTR_NAME)
end
function module_upvr.setItemName(arg1, arg2) -- Line 34
    arg1:SetAttribute(GuardNPCConsts_upvr.ITEM_NAME_ATTR_NAME, arg2)
    return true
end
function module_upvr.getItemNameChangedSignal(arg1) -- Line 38
    return arg1:GetAttributeChangedSignal(GuardNPCConsts_upvr.ITEM_NAME_ATTR_NAME)
end
function module_upvr.setDefenseTargetType(arg1, arg2) -- Line 41
    arg1:SetAttribute(GuardNPCConsts_upvr.DEFENSE_TARGET_TYPE_ATTR_NAME, arg2)
end
function module_upvr.getDefenseTargetType(arg1) -- Line 44
    return arg1:GetAttribute(GuardNPCConsts_upvr.DEFENSE_TARGET_TYPE_ATTR_NAME)
end
function module_upvr.setDefenseTarget(arg1, arg2) -- Line 47
    if arg2:IsA("BasePart") then
        module_upvr.setDefenseTargetType(arg1, NPCConsts_upvr.DEST_TYPE.OBJ)
        if not arg1:FindFirstChild(GuardNPCConsts_upvr.DEFENSE_OBJ_VALUE_NAME) then
            local ObjectValue = Instance.new("ObjectValue")
            ObjectValue.Name = GuardNPCConsts_upvr.DEFENSE_OBJ_VALUE_NAME
            ObjectValue.Value = nil
            ObjectValue.Parent = arg1
        end
        ObjectValue.Value = arg2
    else
        error("Unknown target type")
    end
    return true
end
function module_upvr.getDefenseTarget(arg1) -- Line 63
    if module_upvr.getDefenseTargetType(arg1) == NPCConsts_upvr.DEST_TYPE.OBJ then
        return arg1:FindFirstChild(GuardNPCConsts_upvr.DEFENSE_OBJ_VALUE_NAME).Value
    end
end
function module_upvr.getDefenseTargetPos(arg1) -- Line 69
    if module_upvr.getDefenseTargetType(arg1) == NPCConsts_upvr.DEST_TYPE.OBJ then
        return arg1:FindFirstChild(GuardNPCConsts_upvr.DEFENSE_OBJ_VALUE_NAME).Value.Position
    end
end
function module_upvr.setIsDocile(arg1, arg2) -- Line 75
    local var10
    if typeof(arg1) ~= "Instance" then
        var10 = false
    else
        var10 = true
    end
    assert(var10, "Invalid obj passed")
    var10 = CollectionService_upvr:HasTag(arg1, GuardNPCConsts_upvr.TAG_NAME)
    assert(var10, "Obj does not have guard npc tag")
    arg1:SetAttribute(GuardNPCConsts_upvr.IS_DOCILE_ATTR_NAME, arg2)
    return true
end
function module_upvr.getIsDocile(arg1) -- Line 80
    local var11
    if typeof(arg1) ~= "Instance" then
        var11 = false
    else
        var11 = true
    end
    assert(var11, "Invalid obj passed")
    var11 = CollectionService_upvr:HasTag(arg1, GuardNPCConsts_upvr.TAG_NAME)
    assert(var11, "Obj does not have guard npc tag")
    return arg1:GetAttribute(GuardNPCConsts_upvr.IS_DOCILE_ATTR_NAME)
end
function module_upvr.setMaxAllowedShootDistanceFromDefenseTarget(arg1, arg2) -- Line 84
    arg1:SetAttribute(GuardNPCConsts_upvr.MAX_ALLOWED_SHOOT_DIST_FROM_DEFENSE_TARGET_ATTR_NAME, arg2)
    return true
end
function module_upvr.getMaxAllowedShootDistanceFromDefenseTarget(arg1, arg2) -- Line 88
    return arg1:GetAttribute(GuardNPCConsts_upvr.MAX_ALLOWED_SHOOT_DIST_FROM_DEFENSE_TARGET_ATTR_NAME)
end
function module_upvr.setMaxShootDist(arg1, arg2) -- Line 91
    arg1:SetAttribute(GuardNPCConsts_upvr.MAX_SHOOT_DIST_ATTR_NAME, arg2)
    return true
end
function module_upvr.getMaxShootDist(arg1) -- Line 95
    return arg1:GetAttribute(GuardNPCConsts_upvr.MAX_SHOOT_DIST_ATTR_NAME)
end
function module_upvr.setIsTargetingInvolvedPlayer(arg1, arg2) -- Line 98
    arg1:SetAttribute(GuardNPCConsts_upvr.TARGETING_INVOLVED_PLAYER_ATTR_NAME, arg2)
    return true
end
function module_upvr.getIsTargetingInvolvedPlayer(arg1) -- Line 102
    return arg1:GetAttribute(GuardNPCConsts_upvr.TARGETING_INVOLVED_PLAYER_ATTR_NAME)
end
function module_upvr.clearDamager(arg1, arg2) -- Line 105
    local SOME_2 = arg1:FindFirstChild(GuardNPCConsts_upvr.DAMAGERS_FOLDER_NAME)
    if SOME_2 then
        local SOME_4 = SOME_2:FindFirstChild(tostring(arg2))
        if SOME_4 then
            SOME_4:Destroy()
            return true
        end
    end
    return false
end
function module_upvr.addDamager(arg1, arg2, arg3) -- Line 116
    if not arg1:FindFirstChild(GuardNPCConsts_upvr.DAMAGERS_FOLDER_NAME) then
        local Folder = Instance.new("Folder")
        Folder.Name = GuardNPCConsts_upvr.DAMAGERS_FOLDER_NAME
        Folder.Parent = arg1
    end
    if not Folder:FindFirstChild(tostring(arg2)) then
        local NumberValue = Instance.new("NumberValue")
        NumberValue.Name = arg2
        NumberValue.Parent = Folder
        NumberValue.Value = 0
    end
    NumberValue.Value += arg3
    return true
end
function module_upvr.getDamagers(arg1) -- Line 133
    local SOME = arg1:FindFirstChild(GuardNPCConsts_upvr.DAMAGERS_FOLDER_NAME)
    if not SOME then
        return nil
    end
    for _, v in SOME:GetChildren() do
        ({})[tonumber(v.Name)] = v.Value
        local var27
    end
    return var27
end
return module_upvr
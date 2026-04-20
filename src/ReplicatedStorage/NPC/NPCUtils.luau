local NPCConsts_upvr = require(game:GetService("ReplicatedStorage").NPC.NPCConsts)
local module_upvr = {
    getTargetType = function(arg1) -- Line 6, Named "getTargetType"
        return arg1:GetAttribute(NPCConsts_upvr.DEST_TYPE_ATTR_NAME)
    end;
    setTargetType = function(arg1, arg2) -- Line 9, Named "setTargetType"
        arg1:SetAttribute(NPCConsts_upvr.DEST_TYPE_ATTR_NAME, arg2)
    end;
}
function module_upvr.getTarget(arg1) -- Line 12
    local any_getTargetType_result1 = module_upvr.getTargetType(arg1)
    if any_getTargetType_result1 == NPCConsts_upvr.DEST_TYPE.POS or any_getTargetType_result1 == NPCConsts_upvr.DEST_TYPE.IDLE then
        return arg1:GetAttribute(NPCConsts_upvr.DEST_POS_ATTR_NAME)
    end
    if any_getTargetType_result1 == NPCConsts_upvr.DEST_TYPE.OBJ then
        local SOME_4 = arg1:FindFirstChild(NPCConsts_upvr.DEST_OBJ_VALUE_NAME)
        if SOME_4 then
            return SOME_4.Value
        end
    end
    return nil
end
function module_upvr.setTarget(arg1, arg2, arg3) -- Line 24
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if typeof(arg2) == "Instance" and arg2:IsA("BasePart") or arg2 == nil then
        local OBJ = NPCConsts_upvr.DEST_TYPE.OBJ
    else
        error("Unknown targetType")
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if OBJ == NPCConsts_upvr.DEST_TYPE.POS or OBJ == NPCConsts_upvr.DEST_TYPE.IDLE then
        arg1:SetAttribute(NPCConsts_upvr.DEST_POS_ATTR_NAME, arg2)
    elseif OBJ == NPCConsts_upvr.DEST_TYPE.OBJ then
        local SOME_3 = arg1:FindFirstChild(NPCConsts_upvr.DEST_OBJ_VALUE_NAME)
        if not SOME_3 then
            error("Could not find destObj")
        end
        SOME_3.Value = arg2
    end
    if module_upvr.getTargetType(arg1) ~= OBJ then
        module_upvr.setTargetType(arg1, OBJ)
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_upvr.setHomePosition(arg1, arg2) -- Line 47
    arg1:SetAttribute(NPCConsts_upvr.HOME_POSITION_OBJ_NAME, arg2)
end
function module_upvr.getHomePosition(arg1) -- Line 52
    return arg1:GetAttribute(NPCConsts_upvr.HOME_POSITION_OBJ_NAME)
end
function module_upvr.getLookAtType(arg1) -- Line 55
    return arg1:GetAttribute(NPCConsts_upvr.LOOK_AT_TYPE_ATTR_NAME)
end
function module_upvr.setLookAtType(arg1, arg2) -- Line 58
    arg1:SetAttribute(NPCConsts_upvr.LOOK_AT_TYPE_ATTR_NAME, arg2)
end
function module_upvr.getLookAt(arg1) -- Line 61
    local any_getLookAtType_result1 = module_upvr.getLookAtType(arg1)
    if any_getLookAtType_result1 == NPCConsts_upvr.DEST_TYPE.POS or any_getLookAtType_result1 == NPCConsts_upvr.DEST_TYPE.IDLE then
        return arg1:GetAttribute(NPCConsts_upvr.LOOK_AT_POS_ATTR_NAME)
    end
    if any_getLookAtType_result1 == NPCConsts_upvr.DEST_TYPE.OBJ then
        local SOME = arg1:FindFirstChild(NPCConsts_upvr.LOOK_AT_OBJ_VALUE_NAME)
        if SOME then
            return SOME.Value
        end
    end
    return nil
end
function module_upvr.setLookAt(arg1, arg2, arg3) -- Line 73
    if arg3 == nil then
        if typeof(arg2) == "Vector3" then
            local POS = NPCConsts_upvr.DEST_TYPE.POS
        elseif typeof(arg2) == "Instance" and arg2:IsA("BasePart") or arg2 == nil then
        else
            error("Unknown targetType")
        end
    end
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        return NPCConsts_upvr.DEST_TYPE.OBJ == NPCConsts_upvr.DEST_TYPE.IDLE
    end
    if NPCConsts_upvr.DEST_TYPE.OBJ == NPCConsts_upvr.DEST_TYPE.POS or decompInlinedCondition() then
        arg1:SetAttribute(NPCConsts_upvr.LOOK_AT_POS_ATTR_NAME, arg2)
    else
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        if NPCConsts_upvr.DEST_TYPE.OBJ == NPCConsts_upvr.DEST_TYPE.OBJ then
            local SOME_5 = arg1:FindFirstChild(NPCConsts_upvr.LOOK_AT_OBJ_VALUE_NAME)
            if not SOME_5 then
                error("Could not find destObj")
            end
            SOME_5.Value = arg2
        end
    end
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    if module_upvr.getLookAtType(arg1) ~= NPCConsts_upvr.DEST_TYPE.OBJ then
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        module_upvr.setLookAtType(arg1, NPCConsts_upvr.DEST_TYPE.OBJ)
    end
end
local Players_upvr = game:GetService("Players")
function module_upvr.getNetworkOwner(arg1) -- Line 96
    local attribute = arg1:GetAttribute(NPCConsts_upvr.NETWORK_OWNER_ID_ATTR_NAME)
    if not attribute then return end
    return Players_upvr:GetPlayerByUserId(attribute)
end
function module_upvr.setExtrapolateTargetMovement(arg1, arg2) -- Line 103
    return arg1:SetAttribute(NPCConsts_upvr.EXTRAPOLATE_TARGET_MOVEMENT_ATTR_NAME, arg2)
end
function module_upvr.getExtrapolateTargetMovement(arg1) -- Line 106
    return arg1:GetAttribute(NPCConsts_upvr.EXTRAPOLATE_TARGET_MOVEMENT_ATTR_NAME)
end
function module_upvr.setCustomNetworkOwnership(arg1, arg2) -- Line 109
    arg1:SetAttribute(NPCConsts_upvr.CUSTOM_NETWORK_OWNERSHIP_ATTR_NAME, arg2)
end
function module_upvr.getCustomNetworkOwnership(arg1) -- Line 112
    return arg1:GetAttribute(NPCConsts_upvr.CUSTOM_NETWORK_OWNERSHIP_ATTR_NAME)
end
return module_upvr
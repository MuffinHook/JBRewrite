local BriefcaseConsts_upvr = require(game:GetService("ReplicatedStorage").AirDrop.BriefcaseConsts)
local function getQuatBtwn_upvr(arg1, arg2, arg3) -- Line 7, Named "getQuatBtwn"
    local any_Dot_result1 = arg1:Dot(arg2)
    local any_Cross_result1 = arg1:Cross(arg2)
    if any_Dot_result1 < -0.99999 then
        return CFrame.fromAxisAngle(arg3, math.pi)
    end
    return CFrame.new(0, 0, 0, any_Cross_result1.x, any_Cross_result1.y, any_Cross_result1.z, 1 + any_Dot_result1)
end
local module_upvr = {
    getOrigin = function(arg1) -- Line 16, Named "getOrigin"
        return arg1:GetAttribute(BriefcaseConsts_upvr.ORIGIN_ATTR_NAME)
    end;
    setOrigin = function(arg1, arg2) -- Line 19, Named "setOrigin"
        arg1:SetAttribute(BriefcaseConsts_upvr.ORIGIN_ATTR_NAME, arg2)
    end;
    getTarget = function(arg1) -- Line 22, Named "getTarget"
        return arg1:GetAttribute(BriefcaseConsts_upvr.TARGET_ATTR_NAME)
    end;
    setTarget = function(arg1, arg2) -- Line 25, Named "setTarget"
        arg1:SetAttribute(BriefcaseConsts_upvr.TARGET_ATTR_NAME, arg2)
    end;
    getTargetNormal = function(arg1) -- Line 28, Named "getTargetNormal"
        return arg1:GetAttribute(BriefcaseConsts_upvr.TARGET_NORMAL_ATTR_NAME)
    end;
    setTargetNormal = function(arg1, arg2) -- Line 31, Named "setTargetNormal"
        arg1:SetAttribute(BriefcaseConsts_upvr.TARGET_NORMAL_ATTR_NAME, arg2)
    end;
    getCollected = function(arg1) -- Line 34, Named "getCollected"
        return arg1:GetAttribute(BriefcaseConsts_upvr.COLLECTED_ATTR_NAME)
    end;
    setCollected = function(arg1, arg2) -- Line 37, Named "setCollected"
        arg1:SetAttribute(BriefcaseConsts_upvr.COLLECTED_ATTR_NAME, arg2)
    end;
    getCollectedChangedSignal = function(arg1) -- Line 40, Named "getCollectedChangedSignal"
        return arg1:GetAttributeChangedSignal(BriefcaseConsts_upvr.COLLECTED_ATTR_NAME)
    end;
    getBornAt = function(arg1) -- Line 43, Named "getBornAt"
        return arg1:GetAttribute(BriefcaseConsts_upvr.BORN_AT_ATTR_NAME)
    end;
    setBornAt = function(arg1, arg2) -- Line 46, Named "setBornAt"
        arg1:SetAttribute(BriefcaseConsts_upvr.BORN_AT_ATTR_NAME, arg2)
    end;
    getSpeed = function(arg1) -- Line 49, Named "getSpeed"
        return arg1:GetAttribute(BriefcaseConsts_upvr.SPEED_ATTR_NAME)
    end;
    setSpeed = function(arg1, arg2) -- Line 52, Named "setSpeed"
        arg1:SetAttribute(BriefcaseConsts_upvr.SPEED_ATTR_NAME, arg2)
    end;
    getLanded = function(arg1) -- Line 55, Named "getLanded"
        return arg1:GetAttribute(BriefcaseConsts_upvr.LANDED_ATTR_NAME)
    end;
    setLanded = function(arg1, arg2) -- Line 58, Named "setLanded"
        arg1:SetAttribute(BriefcaseConsts_upvr.LANDED_ATTR_NAME, arg2)
    end;
    getLandedTime = function(arg1) -- Line 61, Named "getLandedTime"
        return arg1:GetAttribute(BriefcaseConsts_upvr.BRIEFCASE_LANDING_TIME_ATTRIBUTE_NAME)
    end;
    setLandedTime = function(arg1, arg2) -- Line 64, Named "setLandedTime"
        arg1:SetAttribute(BriefcaseConsts_upvr.BRIEFCASE_LANDING_TIME_ATTRIBUTE_NAME, arg2)
    end;
    getRarityProbabilities = function(arg1) -- Line 67, Named "getRarityProbabilities"
        local SOME = arg1:FindFirstChild(BriefcaseConsts_upvr.BRIEFCASE_RARITY_PROBABILITIES_FOLDER_NAME)
        assert(SOME, "No rarity folder found")
        local module = {}
        for _, v in SOME:GetChildren() do
            module[v.Name] = v.Value
        end
        return module
    end;
}
function module_upvr.getTimeSinceBriefcaseLanded(arg1) -- Line 78
    local any_getLandedTime_result1 = module_upvr.getLandedTime(arg1)
    assert(any_getLandedTime_result1, "Briefcase hasn't landed yet but trying to collect reward")
    return workspace:GetServerTimeNow() - any_getLandedTime_result1
end
function module_upvr.setBriefcaseActiveDurationStart(arg1, arg2) -- Line 83
    arg1:SetAttribute(BriefcaseConsts_upvr.BRIEFCASE_ACTIVE_DURATION_START, arg2)
end
function module_upvr.getBriefcaseActiveDurationStart(arg1) -- Line 86
    return arg1:GetAttribute(BriefcaseConsts_upvr.BRIEFCASE_ACTIVE_DURATION_START)
end
function module_upvr.getBriefcaseActiveDuration(arg1) -- Line 89
    if not module_upvr.getBriefcaseActiveDurationStart(arg1) then
        return nil
    end
    return workspace:GetServerTimeNow() - module_upvr.getBriefcaseActiveDurationStart(arg1)
end
function module_upvr.setRarityProbabilities(arg1, arg2) -- Line 95
    if typeof(arg2) ~= "table" then
        print(arg2)
        error("Invalid rarityProbs given")
    end
    if not arg1:FindFirstChild(BriefcaseConsts_upvr.BRIEFCASE_RARITY_PROBABILITIES_FOLDER_NAME) then
        local Folder = Instance.new("Folder")
        Folder.Name = BriefcaseConsts_upvr.BRIEFCASE_RARITY_PROBABILITIES_FOLDER_NAME
        Folder.Parent = arg1
    end
    for i_2, v_2 in arg2 do
        if not Folder:FindFirstChild(i_2) then
            local NumberValue = Instance.new("NumberValue")
            NumberValue.Name = i_2
            NumberValue.Parent = Folder
        end
        NumberValue.Value = v_2
    end
    for _, v_3 in Folder:GetChildren() do
        if not arg2[tonumber(v_3.Name)] then
            v_3:Destroy()
        end
    end
    return true
end
function module_upvr.getLandedChangedSignal(arg1) -- Line 127
    return arg1:GetAttributeChangedSignal(BriefcaseConsts_upvr.LANDED_ATTR_NAME)
end
function module_upvr.getOpenDuration(arg1) -- Line 130
    return arg1:GetAttribute(BriefcaseConsts_upvr.OPEN_DURATION_ATTRIBUTE_NAME)
end
function module_upvr.setOpenDuration(arg1, arg2) -- Line 133
    arg1:SetAttribute(BriefcaseConsts_upvr.OPEN_DURATION_ATTRIBUTE_NAME, arg2)
    return true
end
function module_upvr.getPositionAt(arg1, arg2, arg3, arg4) -- Line 137
    if arg4 < arg1 then
    end
    return arg2 + (arg3 - arg2) * (arg4 / arg4)
end
function module_upvr.getCFrameAt(arg1, arg2, arg3, arg4, arg5) -- Line 146
    if arg5 < arg1 then
        local var24 = arg5
    end
    local var25 = var24 % (-math.pi*2)
    local var26 = 0
    if arg5 - 1 < var24 then
        var26 = (var24 - arg5) / 1 + 1
    end
    local var27 = var26 * var26
    return getQuatBtwn_upvr(Vector3.new(0, 1, 0), Vector3.new(0, 1, 0):lerp(arg4, var27), Vector3.new(0, 0, 1)) * CFrame.Angles(math.cos(var25) * 0.2 * (1 - var27), var25, math.sin(var25) * 0.2 * (1 - var27)) + arg2 + (arg3 - arg2) * (var24 / arg5)
end
function module_upvr.setLastEPress(arg1, arg2) -- Line 171
    arg1:SetAttribute(BriefcaseConsts_upvr.LAST_E_PRESS_ATTR_NAME, arg2)
    return true
end
function module_upvr.getLastEPress(arg1) -- Line 175
    return arg1:GetAttribute(BriefcaseConsts_upvr.LAST_E_PRESS_ATTR_NAME)
end
function module_upvr.setIsCurrentlyEPressed(arg1, arg2) -- Line 178
    arg1:SetAttribute(BriefcaseConsts_upvr.IS_CURRENTLY_E_PRESSED_ATTR_NAME, arg2)
    return true
end
function module_upvr.getIsCurrentlyEPressed(arg1) -- Line 182
    return arg1:GetAttribute(BriefcaseConsts_upvr.IS_CURRENTLY_E_PRESSED_ATTR_NAME)
end
return module_upvr
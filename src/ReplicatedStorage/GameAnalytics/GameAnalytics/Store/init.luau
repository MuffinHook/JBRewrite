local DataStoreService_upvr = game:GetService("DataStoreService")
local RunService_upvr = game:GetService("RunService")
local DataStoreQueue_upvr = require(script.DataStoreQueue)
local module_upvr = {}
local IncrementErrorCount
local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
    IncrementErrorCount = {}
    return IncrementErrorCount
end
if not RunService_upvr:IsStudio() or not decompInlinedCondition() then
    IncrementErrorCount = DataStoreService_upvr:GetDataStore("GA_PlayerDS_1.0.0")
end
module_upvr.PlayerDS = IncrementErrorCount
IncrementErrorCount = 180
module_upvr.AutoSaveData = IncrementErrorCount
IncrementErrorCount = {}
IncrementErrorCount.Sessions = 0
IncrementErrorCount.Transactions = 0
IncrementErrorCount.ProgressionTries = {}
IncrementErrorCount.CurrentCustomDimension01 = ""
IncrementErrorCount.CurrentCustomDimension02 = ""
IncrementErrorCount.CurrentCustomDimension03 = ""
IncrementErrorCount.ConfigsHash = ""
IncrementErrorCount.AbId = ""
IncrementErrorCount.AbVariantId = ""
IncrementErrorCount.InitAuthorized = false
IncrementErrorCount.SdkConfig = {}
IncrementErrorCount.ClientServerTimeOffset = 0
IncrementErrorCount.Configurations = {}
IncrementErrorCount.RemoteConfigsIsReady = false
IncrementErrorCount.PlayerTeleporting = false
IncrementErrorCount.OwnedGamepasses = nil
IncrementErrorCount.CountryCode = ""
IncrementErrorCount.CustomUserId = ""
module_upvr.BasePlayerData = IncrementErrorCount
IncrementErrorCount = {}
IncrementErrorCount[1] = "Sessions"
IncrementErrorCount[2] = "Transactions"
IncrementErrorCount[3] = "ProgressionTries"
IncrementErrorCount[4] = "CurrentCustomDimension01"
IncrementErrorCount[5] = "CurrentCustomDimension02"
IncrementErrorCount[6] = "CurrentCustomDimension03"
IncrementErrorCount[7] = "OwnedGamepasses"
module_upvr.DataToSave = IncrementErrorCount
IncrementErrorCount = {}
module_upvr.PlayerCache = IncrementErrorCount
IncrementErrorCount = {}
module_upvr.EventsQueue = IncrementErrorCount
module_upvr.DataStoreQueue = DataStoreQueue_upvr
function IncrementErrorCount(arg1, arg2) -- Line 45, Named "GetPlayerData"
    local UserId_upvr = arg2.UserId
    local any_AddRequest_result1_2, any_AddRequest_result2_2 = DataStoreQueue_upvr.AddRequest(UserId_upvr, function() -- Line 47
        local var8
        local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var8 = {}
            return var8
        end
        if not RunService_upvr:IsStudio() or not decompInlinedCondition_2() then
            var8 = module_upvr
            var8 = var8.PlayerDS:GetAsync(UserId_upvr)
            if not var8 then
                var8 = {}
            end
        end
        return var8
    end, 7)
    if not any_AddRequest_result1_2 then
        any_AddRequest_result2_2 = {}
    end
    return any_AddRequest_result2_2
end
module_upvr.GetPlayerData = IncrementErrorCount
function IncrementErrorCount(arg1, arg2) -- Line 57, Named "GetPlayerDataFromCache"
    local var11 = module_upvr.PlayerCache[tonumber(arg2)]
    if var11 then
        return var11
    end
    return module_upvr.PlayerCache[tostring(arg2)]
end
module_upvr.GetPlayerDataFromCache = IncrementErrorCount
function IncrementErrorCount(arg1, arg2) -- Line 66, Named "GetErrorDataStore"
    local var12_upvw
    if not pcall(function() -- Line 68
        local var14
        local function decompInlinedCondition_3() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var14 = {}
            return var14
        end
        if not RunService_upvr:IsStudio() or not decompInlinedCondition_3() then
            var14 = DataStoreService_upvr:GetDataStore("GA_ErrorDS_1.0.0", arg2)
        end
        var12_upvw = var14
    end) then
        var12_upvw = {}
    end
    return var12_upvw
end
module_upvr.GetErrorDataStore = IncrementErrorCount
function IncrementErrorCount(arg1, arg2) -- Line 79, Named "SavePlayerData"
    local any_GetPlayerDataFromCache_result1 = module_upvr:GetPlayerDataFromCache(arg2.UserId)
    local module_upvr_2 = {}
    if not any_GetPlayerDataFromCache_result1 then
    else
        for var25, v in pairs(module_upvr.DataToSave) do
            module_upvr_2[v] = any_GetPlayerDataFromCache_result1[v]
        end
        local UserId_upvr_2 = arg2.UserId
        if not RunService_upvr:IsStudio() then
            function var25() -- Line 96
                return module_upvr.PlayerDS:SetAsync(UserId_upvr_2, module_upvr_2)
            end
            v = 7
            DataStoreQueue_upvr.AddRequest(UserId_upvr_2, var25, v)
        end
    end
end
module_upvr.SavePlayerData = IncrementErrorCount
function IncrementErrorCount(arg1, arg2, arg3, arg4) -- Line 102
    if not arg3 then return end
    local var26 = 0
    if not RunService_upvr:IsStudio() then
        local any_AddRequest_result1, any_AddRequest_result2 = DataStoreQueue_upvr.AddRequest(arg3, function() -- Line 111
            return arg2:IncrementAsync(arg3, arg4)
        end, 7)
        _ = any_AddRequest_result1 -- Setting global
        var26 = any_AddRequest_result2
    end
    return var26
end
module_upvr.IncrementErrorCount = IncrementErrorCount
return module_upvr
local Validation_upvr = require(script.Parent.Validation)
local Logger_upvr = require(script.Parent.Logger)
local Store_upvr = require(script.Parent.Store)
local Events_upvr = require(script.Parent.Events)
local HttpService_upvr = game:GetService("HttpService")
local module_upvr = {
    _availableCustomDimensions01 = {};
    _availableCustomDimensions02 = {};
    _availableCustomDimensions03 = {};
    _availableGamepasses = {};
    _enableEventSubmission = true;
    Initialized = false;
    ReportErrors = true;
    UseCustomUserId = false;
    AutomaticSendBusinessEvents = true;
    ConfigsHash = "";
}
local function _(arg1) -- Line 23, Named "getClientTsAdjusted"
    local any_GetPlayerDataFromCache_result1_6 = Store_upvr:GetPlayerDataFromCache(arg1)
    if not any_GetPlayerDataFromCache_result1_6 then
        return os.time()
    end
    local os_time_result1_2 = os.time()
    local var9 = os_time_result1_2 + any_GetPlayerDataFromCache_result1_6.ClientServerTimeOffset
    if Validation_upvr:validateClientTs(var9) then
        return var9
    end
    return os_time_result1_2
end
local var10_upvw
local function populateConfigurations_upvr(arg1) -- Line 38, Named "populateConfigurations"
    local any_GetPlayerDataFromCache_result1_4 = Store_upvr:GetPlayerDataFromCache(arg1.UserId)
    local SdkConfig = any_GetPlayerDataFromCache_result1_4.SdkConfig
    if SdkConfig.configs then
        local var20
        for _, v in pairs(SdkConfig.configs) do
            if v then
                local var21 = v.key or ""
                var20 = v.end_ts
                local any_GetPlayerDataFromCache_result1_5 = Store_upvr:GetPlayerDataFromCache(arg1.UserId)
                if not any_GetPlayerDataFromCache_result1_5 then
                    var20 = os.time()
                else
                    local os_time_result1 = os.time()
                    local var24 = os_time_result1 + any_GetPlayerDataFromCache_result1_5.ClientServerTimeOffset
                    if Validation_upvr:validateClientTs(var24) then
                        var20 = var24
                    else
                        var20 = os_time_result1
                    end
                end
                if 0 < #var21 and v.value and (v.start_ts or 0) < var20 and var20 < (var20 or math.huge) then
                    any_GetPlayerDataFromCache_result1_4.Configurations[var21] = v.value
                    Logger_upvr:d("configuration added: key="..v.key..", value="..v.value)
                end
            end
        end
    end
    Logger_upvr:i("Remote configs populated")
    any_GetPlayerDataFromCache_result1_4.RemoteConfigsIsReady = true
    local var25 = var10_upvw
    if not var25 then
        var25 = game:GetService("ReplicatedStorage"):WaitForChild("GameAnalyticsRemoteConfigs")
    end
    var10_upvw = var25
    var10_upvw:FireClient(arg1, any_GetPlayerDataFromCache_result1_4.Configurations)
end
function module_upvr.sessionIsStarted(arg1, arg2) -- Line 67
    local any_GetPlayerDataFromCache_result1_7 = Store_upvr:GetPlayerDataFromCache(arg2)
    local var27
    if not any_GetPlayerDataFromCache_result1_7 then
        var27 = false
        return var27
    end
    if any_GetPlayerDataFromCache_result1_7.SessionStart == 0 then
        var27 = false
    else
        var27 = true
    end
    return var27
end
function module_upvr.isEnabled(arg1, arg2) -- Line 76
    local any_GetPlayerDataFromCache_result1_3 = Store_upvr:GetPlayerDataFromCache(arg2)
    if not any_GetPlayerDataFromCache_result1_3 then
        return false
    end
    if not any_GetPlayerDataFromCache_result1_3.InitAuthorized then
        return false
    end
    return true
end
function module_upvr.validateAndFixCurrentDimensions(arg1, arg2) -- Line 87
    local any_GetPlayerDataFromCache_result1 = Store_upvr:GetPlayerDataFromCache(arg2)
    if not Validation_upvr:validateDimension(arg1._availableCustomDimensions01, any_GetPlayerDataFromCache_result1.CurrentCustomDimension01) then
        Logger_upvr:d("Invalid dimension01 found in variable. Setting to nil. Invalid dimension: "..any_GetPlayerDataFromCache_result1.CurrentCustomDimension01)
    end
    if not Validation_upvr:validateDimension(arg1._availableCustomDimensions02, any_GetPlayerDataFromCache_result1.CurrentCustomDimension02) then
        Logger_upvr:d("Invalid dimension02 found in variable. Setting to nil. Invalid dimension: "..any_GetPlayerDataFromCache_result1.CurrentCustomDimension02)
    end
    if not Validation_upvr:validateDimension(arg1._availableCustomDimensions03, any_GetPlayerDataFromCache_result1.CurrentCustomDimension03) then
        Logger_upvr:d("Invalid dimension03 found in variable. Setting to nil. Invalid dimension: "..any_GetPlayerDataFromCache_result1.CurrentCustomDimension03)
    end
end
function module_upvr.setAvailableCustomDimensions01(arg1, arg2) -- Line 106
    if not Validation_upvr:validateCustomDimensions(arg2) then
    else
        arg1._availableCustomDimensions01 = arg2
        Logger_upvr:i("Set available custom01 dimension values: ("..table.concat(arg2, ", ")..')')
    end
end
function module_upvr.setAvailableCustomDimensions02(arg1, arg2) -- Line 115
    if not Validation_upvr:validateCustomDimensions(arg2) then
    else
        arg1._availableCustomDimensions02 = arg2
        Logger_upvr:i("Set available custom02 dimension values: ("..table.concat(arg2, ", ")..')')
    end
end
function module_upvr.setAvailableCustomDimensions03(arg1, arg2) -- Line 124
    if not Validation_upvr:validateCustomDimensions(arg2) then
    else
        arg1._availableCustomDimensions03 = arg2
        Logger_upvr:i("Set available custom03 dimension values: ("..table.concat(arg2, ", ")..')')
    end
end
function module_upvr.setAvailableGamepasses(arg1, arg2) -- Line 133
    arg1._availableGamepasses = arg2
    Logger_upvr:i("Set available game passes: ("..table.concat(arg2, ", ")..')')
end
function module_upvr.setEventSubmission(arg1, arg2) -- Line 138
    arg1._enableEventSubmission = arg2
end
function module_upvr.isEventSubmissionEnabled(arg1) -- Line 142
    return arg1._enableEventSubmission
end
function module_upvr.setCustomDimension01(arg1, arg2, arg3) -- Line 146
    Store_upvr:GetPlayerDataFromCache(arg2).CurrentCustomDimension01 = arg3
end
function module_upvr.setCustomDimension02(arg1, arg2, arg3) -- Line 151
    Store_upvr:GetPlayerDataFromCache(arg2).CurrentCustomDimension02 = arg3
end
function module_upvr.setCustomDimension03(arg1, arg2, arg3) -- Line 156
    Store_upvr:GetPlayerDataFromCache(arg2).CurrentCustomDimension03 = arg3
end
local HttpApi_upvr = require(script.Parent.HttpApi)
function module_upvr.startNewSession(arg1, arg2, arg3) -- Line 161
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if module_upvr:isEventSubmissionEnabled() and arg3 == nil then
        Logger_upvr:i("Starting a new session.")
    end
    local any_GetPlayerDataFromCache_result1_2 = Store_upvr:GetPlayerDataFromCache(arg2.UserId)
    module_upvr:validateAndFixCurrentDimensions(arg2.UserId)
    local any_initRequest_result1 = HttpApi_upvr:initRequest(Events_upvr.GameKey, Events_upvr.SecretKey, Events_upvr.Build, any_GetPlayerDataFromCache_result1_2, arg2.UserId)
    local statusCode = any_initRequest_result1.statusCode
    local body = any_initRequest_result1.body
    if statusCode == HttpApi_upvr.EGAHTTPApiResponse.Ok or statusCode == HttpApi_upvr.EGAHTTPApiResponse.Created or body then
        local var35 = 0
        local var36 = body.server_ts or -1
        if 0 < var36 then
            var35 = var36 - os.time()
        end
        body.time_offset = var35
        if statusCode ~= HttpApi_upvr.EGAHTTPApiResponse.Created then
            local SdkConfig_2 = any_GetPlayerDataFromCache_result1_2.SdkConfig
            if SdkConfig_2.configs then
                body.configs = SdkConfig_2.configs
            end
            if SdkConfig_2.ab_id then
                body.ab_id = SdkConfig_2.ab_id
            end
            if SdkConfig_2.ab_variant_id then
                body.ab_variant_id = SdkConfig_2.ab_variant_id
            end
        end
        any_GetPlayerDataFromCache_result1_2.SdkConfig = body
        any_GetPlayerDataFromCache_result1_2.InitAuthorized = true
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if statusCode == HttpApi_upvr.EGAHTTPApiResponse.Unauthorized then
        Logger_upvr:w("Initialize SDK failed - Unauthorized")
        any_GetPlayerDataFromCache_result1_2.InitAuthorized = false
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_upvr.endSession(arg1, arg2) -- Line 247
    if module_upvr.Initialized and module_upvr:isEventSubmissionEnabled() then
        Logger_upvr:i("Ending session.")
        if module_upvr:isEnabled(arg2) and module_upvr:sessionIsStarted(arg2) then
            Events_upvr:addSessionEndEvent(arg2)
            Store_upvr.PlayerCache[arg2] = nil
        end
    end
end
function module_upvr.getRemoteConfigsStringValue(arg1, arg2, arg3, arg4) -- Line 257
    return Store_upvr:GetPlayerDataFromCache(arg2).Configurations[arg3] or arg4
end
function module_upvr.isRemoteConfigsReady(arg1, arg2) -- Line 262
    return Store_upvr:GetPlayerDataFromCache(arg2).RemoteConfigsIsReady
end
function module_upvr.getRemoteConfigsContentAsString(arg1, arg2) -- Line 267
    return HttpService_upvr:JSONEncode(Store_upvr:GetPlayerDataFromCache(arg2).Configurations)
end
return module_upvr
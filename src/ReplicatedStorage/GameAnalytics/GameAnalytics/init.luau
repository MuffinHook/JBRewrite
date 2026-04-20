local module_upvr = {
    EGAResourceFlowType = require(script.GAResourceFlowType);
    EGAProgressionStatus = require(script.GAProgressionStatus);
    EGAErrorSeverity = require(script.GAErrorSeverity);
}
local Logger_upvr = require(script.Logger)
local Threading_upvr = require(script.Threading)
local State_upvr = require(script.State)
local Validation_upvr = require(script.Validation)
local Store_upvr = require(script.Store)
local Events_upvr = require(script.Events)
local Players_upvr = game:GetService("Players")
local MarketplaceService_upvr = game:GetService("MarketplaceService")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local tbl_6_upvr = {}
local tbl_20_upvw = {}
local tbl_5_upvw = {}
local tbl_8_upvw = {}
local tbl_9_upvw = {}
local tbl_3_upvr = {}
local function addToInitializationQueue_upvr(arg1, ...) -- Line 36, Named "addToInitializationQueue"
    if tbl_9_upvw ~= nil then
        local tbl_4 = {}
        tbl_4.Func = arg1
        tbl_4.Args = {...}
        table.insert(tbl_9_upvw, tbl_4)
        Logger_upvr:i("Added event to initialization queue")
    else
        Logger_upvr:w("Initialization queue already cleared.")
    end
end
local function addToInitializationQueueByUserId_upvr(arg1, arg2, ...) -- Line 50, Named "addToInitializationQueueByUserId"
    if not module_upvr:isPlayerReady(arg1) then
        if tbl_3_upvr[arg1] == nil then
            tbl_3_upvr[arg1] = {}
        end
        local tbl_12 = {}
        tbl_12.Func = arg2
        tbl_12.Args = {...}
        table.insert(tbl_3_upvr[arg1], tbl_12)
        Logger_upvr:i("Added event to player initialization queue")
    else
        Logger_upvr:w("Player initialization queue already cleared.")
    end
end
local function isSdkReady_upvr(arg1) -- Line 70, Named "isSdkReady"
    local var21 = arg1.playerId or nil
    local var22 = arg1.needsInitialized or true
    if var22 and not State_upvr.Initialized then
        if arg1.shouldWarn or false then
            Logger_upvr:w((arg1.message or "").." SDK is not initialized")
        end
        return false
    end
    if var22 and var21 and not State_upvr:isEnabled(var21) then
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        if arg1.shouldWarn or false then
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            Logger_upvr:w((arg1.message or "").." SDK is disabled")
        end
        return false
    end
    if var22 and var21 and not State_upvr:sessionIsStarted(var21) then
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        if arg1.shouldWarn or false then
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            Logger_upvr:w((arg1.message or "").." Session has not started yet")
        end
        return false
    end
    return true
end
function module_upvr.configureAvailableCustomDimensions01(arg1, arg2) -- Line 106
    if isSdkReady_upvr({
        needsInitialized = true;
        shouldWarn = false;
    }) then
        Logger_upvr:w("Available custom dimensions must be set before SDK is initialized")
    else
        State_upvr:setAvailableCustomDimensions01(arg2)
    end
end
function module_upvr.configureAvailableCustomDimensions02(arg1, arg2) -- Line 115
    if isSdkReady_upvr({
        needsInitialized = true;
        shouldWarn = false;
    }) then
        Logger_upvr:w("Available custom dimensions must be set before SDK is initialized")
    else
        State_upvr:setAvailableCustomDimensions02(arg2)
    end
end
function module_upvr.configureAvailableCustomDimensions03(arg1, arg2) -- Line 124
    if isSdkReady_upvr({
        needsInitialized = true;
        shouldWarn = false;
    }) then
        Logger_upvr:w("Available custom dimensions must be set before SDK is initialized")
    else
        State_upvr:setAvailableCustomDimensions03(arg2)
    end
end
function module_upvr.configureAvailableResourceCurrencies(arg1, arg2) -- Line 133
    if isSdkReady_upvr({
        needsInitialized = true;
        shouldWarn = false;
    }) then
        Logger_upvr:w("Available resource currencies must be set before SDK is initialized")
    else
        Events_upvr:setAvailableResourceCurrencies(arg2)
    end
end
function module_upvr.configureAvailableResourceItemTypes(arg1, arg2) -- Line 142
    if isSdkReady_upvr({
        needsInitialized = true;
        shouldWarn = false;
    }) then
        Logger_upvr:w("Available resource item types must be set before SDK is initialized")
    else
        Events_upvr:setAvailableResourceItemTypes(arg2)
    end
end
function module_upvr.configureBuild(arg1, arg2) -- Line 151
    if isSdkReady_upvr({
        needsInitialized = true;
        shouldWarn = false;
    }) then
        Logger_upvr:w("Build version must be set before SDK is initialized.")
    else
        Events_upvr:setBuild(arg2)
    end
end
function module_upvr.configureAvailableGamepasses(arg1, arg2) -- Line 160
    if isSdkReady_upvr({
        needsInitialized = true;
        shouldWarn = false;
    }) then
        Logger_upvr:w("Available gamepasses must be set before SDK is initialized.")
    else
        State_upvr:setAvailableGamepasses(arg2)
    end
end
function module_upvr.startNewSession(arg1, arg2, arg3) -- Line 169
    Threading_upvr:performTaskOnGAThread(function() -- Line 170
        if not State_upvr:isEventSubmissionEnabled() then
        else
            if not State_upvr.Initialized then
                Logger_upvr:w("Cannot start new session. SDK is not initialized yet.")
                return
            end
            State_upvr:startNewSession(arg2, arg3)
        end
    end)
end
function module_upvr.endSession(arg1, arg2) -- Line 184
    Threading_upvr:performTaskOnGAThread(function() -- Line 185
        if not State_upvr:isEventSubmissionEnabled() then
        else
            State_upvr:endSession(arg2)
        end
    end)
end
function module_upvr.filterForBusinessEvent(arg1, arg2) -- Line 193
    return string.gsub(arg2, "[^A-Za-z0-9%s%-_%.%(%)!%?]", "")
end
function module_upvr.addBusinessEvent(arg1, arg2, arg3) -- Line 197
    Threading_upvr:performTaskOnGAThread(function() -- Line 198
        if not State_upvr:isEventSubmissionEnabled() then
        else
            local tbl_2 = {}
            tbl_2.playerId = arg2
            tbl_2.needsInitialized = true
            tbl_2.shouldWarn = false
            tbl_2.message = "Could not add business event"
            if not isSdkReady_upvr(tbl_2) then
                if arg2 then
                    addToInitializationQueueByUserId_upvr(arg2, module_upvr.addBusinessEvent, module_upvr, arg2, arg3)
                else
                    addToInitializationQueue_upvr(module_upvr.addBusinessEvent, module_upvr, arg2, arg3)
                end
            end
            local var34 = arg3.itemType or ""
            local var35 = arg3.cartType or ""
            Events_upvr:addBusinessEvent(arg2, "USD", math.floor((arg3.amount or 0) * 0.7 * 0.35), var34, arg3.itemId or "", var35)
            if var34 == "Gamepass" and var35 ~= "Website" then
                local any_GetPlayerDataFromCache_result1 = Store_upvr:GetPlayerDataFromCache(arg2)
                if not any_GetPlayerDataFromCache_result1.OwnedGamepasses then
                    any_GetPlayerDataFromCache_result1.OwnedGamepasses = {}
                end
                table.insert(any_GetPlayerDataFromCache_result1.OwnedGamepasses, arg3.gamepassId or nil)
                Store_upvr.PlayerCache[arg2] = any_GetPlayerDataFromCache_result1
                Store_upvr:SavePlayerData(Players_upvr:GetPlayerByUserId(arg2))
            end
        end
    end)
end
function module_upvr.addResourceEvent(arg1, arg2, arg3) -- Line 234
    Threading_upvr:performTaskOnGAThread(function() -- Line 235
        if not State_upvr:isEventSubmissionEnabled() then
        else
            local tbl_18 = {}
            tbl_18.playerId = arg2
            tbl_18.needsInitialized = true
            tbl_18.shouldWarn = false
            tbl_18.message = "Could not add resource event"
            if not isSdkReady_upvr(tbl_18) then
                if arg2 then
                    addToInitializationQueueByUserId_upvr(arg2, module_upvr.addResourceEvent, module_upvr, arg2, arg3)
                else
                    addToInitializationQueue_upvr(module_upvr.addResourceEvent, module_upvr, arg2, arg3)
                end
            end
            Events_upvr:addResourceEvent(arg2, arg3.flowType or 0, arg3.currency or "", arg3.amount or 0, arg3.itemType or "", arg3.itemId or "")
        end
    end)
end
function module_upvr.addProgressionEvent(arg1, arg2, arg3) -- Line 259
    Threading_upvr:performTaskOnGAThread(function() -- Line 260
        if not State_upvr:isEventSubmissionEnabled() then
        else
            local tbl_19 = {}
            tbl_19.playerId = arg2
            tbl_19.needsInitialized = true
            tbl_19.shouldWarn = false
            tbl_19.message = "Could not add progression event"
            if not isSdkReady_upvr(tbl_19) then
                if arg2 then
                    addToInitializationQueueByUserId_upvr(arg2, module_upvr.addProgressionEvent, module_upvr, arg2, arg3)
                else
                    addToInitializationQueue_upvr(module_upvr.addProgressionEvent, module_upvr, arg2, arg3)
                end
            end
            Events_upvr:addProgressionEvent(arg2, arg3.progressionStatus or 0, arg3.progression01 or "", arg3.progression02 or nil, arg3.progression03 or nil, arg3.score or nil)
        end
    end)
end
function module_upvr.addDesignEvent(arg1, arg2, arg3) -- Line 284
    Threading_upvr:performTaskOnGAThread(function() -- Line 285
        if not State_upvr:isEventSubmissionEnabled() then
        else
            local tbl_7 = {}
            tbl_7.playerId = arg2
            tbl_7.needsInitialized = true
            tbl_7.shouldWarn = false
            tbl_7.message = "Could not add design event"
            if not isSdkReady_upvr(tbl_7) then
                if arg2 then
                    addToInitializationQueueByUserId_upvr(arg2, module_upvr.addDesignEvent, module_upvr, arg2, arg3)
                else
                    addToInitializationQueue_upvr(module_upvr.addDesignEvent, module_upvr, arg2, arg3)
                end
            end
            Events_upvr:addDesignEvent(arg2, arg3.eventId or "", arg3.value or nil)
        end
    end)
end
function module_upvr.addErrorEvent(arg1, arg2, arg3) -- Line 306
    Threading_upvr:performTaskOnGAThread(function() -- Line 307
        if not State_upvr:isEventSubmissionEnabled() then
        else
            local tbl_21 = {}
            tbl_21.playerId = arg2
            tbl_21.needsInitialized = true
            tbl_21.shouldWarn = false
            tbl_21.message = "Could not add error event"
            if not isSdkReady_upvr(tbl_21) then
                if arg2 then
                    addToInitializationQueueByUserId_upvr(arg2, module_upvr.addErrorEvent, module_upvr, arg2, arg3)
                else
                    addToInitializationQueue_upvr(module_upvr.addErrorEvent, module_upvr, arg2, arg3)
                end
            end
            Events_upvr:addErrorEvent(arg2, arg3.severity or 0, arg3.message or "")
        end
    end)
end
local RunService_upvr = game:GetService("RunService")
function module_upvr.setEnabledDebugLog(arg1, arg2) -- Line 328
    if RunService_upvr:IsStudio() then
        if arg2 then
            Logger_upvr:setDebugLog(arg2)
            Logger_upvr:i("Debug logging enabled")
        else
            Logger_upvr:i("Debug logging disabled")
            Logger_upvr:setDebugLog(arg2)
        end
    end
    Logger_upvr:i("setEnabledDebugLog can only be used in studio")
end
function module_upvr.setEnabledInfoLog(arg1, arg2) -- Line 342
    if arg2 then
        Logger_upvr:setInfoLog(arg2)
        Logger_upvr:i("Info logging enabled")
    else
        Logger_upvr:i("Info logging disabled")
        Logger_upvr:setInfoLog(arg2)
    end
end
function module_upvr.setEnabledVerboseLog(arg1, arg2) -- Line 352
    if arg2 then
        Logger_upvr:setVerboseLog(arg2)
        Logger_upvr:ii("Verbose logging enabled")
    else
        Logger_upvr:ii("Verbose logging disabled")
        Logger_upvr:setVerboseLog(arg2)
    end
end
function module_upvr.setEnabledEventSubmission(arg1, arg2) -- Line 363
    Threading_upvr:performTaskOnGAThread(function() -- Line 364
        if arg2 then
            State_upvr:setEventSubmission(arg2)
            Logger_upvr:i("Event submission enabled")
        else
            Logger_upvr:i("Event submission disabled")
            State_upvr:setEventSubmission(arg2)
        end
    end)
end
function module_upvr.setCustomDimension01(arg1, arg2, arg3) -- Line 375
    Threading_upvr:performTaskOnGAThread(function() -- Line 376
        if not Validation_upvr:validateDimension(State_upvr._availableCustomDimensions01, arg3) then
            Logger_upvr:w("Could not set custom01 dimension value to '"..arg3.."'. Value not found in available custom01 dimension values")
        else
            local tbl_13 = {}
            tbl_13.playerId = arg2
            tbl_13.needsInitialized = true
            tbl_13.shouldWarn = true
            tbl_13.message = "Could not set custom01 dimension"
            if not isSdkReady_upvr(tbl_13) then return end
            State_upvr:setCustomDimension01(arg2, arg3)
        end
    end)
end
function module_upvr.setCustomDimension02(arg1, arg2, arg3) -- Line 390
    Threading_upvr:performTaskOnGAThread(function() -- Line 391
        if not Validation_upvr:validateDimension(State_upvr._availableCustomDimensions02, arg3) then
            Logger_upvr:w("Could not set custom02 dimension value to '"..arg3.."'. Value not found in available custom02 dimension values")
        else
            local tbl_17 = {}
            tbl_17.playerId = arg2
            tbl_17.needsInitialized = true
            tbl_17.shouldWarn = true
            tbl_17.message = "Could not set custom02 dimension"
            if not isSdkReady_upvr(tbl_17) then return end
            State_upvr:setCustomDimension02(arg2, arg3)
        end
    end)
end
function module_upvr.setCustomDimension03(arg1, arg2, arg3) -- Line 405
    Threading_upvr:performTaskOnGAThread(function() -- Line 406
        if not Validation_upvr:validateDimension(State_upvr._availableCustomDimensions03, arg3) then
            Logger_upvr:w("Could not set custom03 dimension value to '"..arg3.."'. Value not found in available custom03 dimension values")
        else
            local tbl_10 = {}
            tbl_10.playerId = arg2
            tbl_10.needsInitialized = true
            tbl_10.shouldWarn = true
            tbl_10.message = "Could not set custom03 dimension"
            if not isSdkReady_upvr(tbl_10) then return end
            State_upvr:setCustomDimension03(arg2, arg3)
        end
    end)
end
function module_upvr.setEnabledReportErrors(arg1, arg2) -- Line 420
    Threading_upvr:performTaskOnGAThread(function() -- Line 421
        State_upvr.ReportErrors = arg2
    end)
end
function module_upvr.setEnabledCustomUserId(arg1, arg2) -- Line 426
    Threading_upvr:performTaskOnGAThread(function() -- Line 427
        State_upvr.UseCustomUserId = arg2
    end)
end
function module_upvr.setEnabledAutomaticSendBusinessEvents(arg1, arg2) -- Line 432
    Threading_upvr:performTaskOnGAThread(function() -- Line 433
        State_upvr.AutomaticSendBusinessEvents = arg2
    end)
end
function module_upvr.addGameAnalyticsTeleportData(arg1, arg2, arg3) -- Line 438
    local tbl_11 = {}
    for _, v in ipairs(arg2) do
        local any_GetPlayerDataFromCache_result1_4 = Store_upvr:GetPlayerDataFromCache(v)
        any_GetPlayerDataFromCache_result1_4.PlayerTeleporting = true
        tbl_11[tostring(v)] = {
            SessionID = any_GetPlayerDataFromCache_result1_4.SessionID;
            Sessions = any_GetPlayerDataFromCache_result1_4.Sessions;
            SessionStart = any_GetPlayerDataFromCache_result1_4.SessionStart;
        }
    end
    arg3.gameanalyticsData = tbl_11
    return arg3
end
function module_upvr.getRemoteConfigsValueAsString(arg1, arg2, arg3) -- Line 457
    return State_upvr:getRemoteConfigsStringValue(arg2, arg3.key or "", arg3.defaultValue or nil)
end
function module_upvr.isRemoteConfigsReady(arg1, arg2) -- Line 463
    return State_upvr:isRemoteConfigsReady(arg2)
end
function module_upvr.getRemoteConfigsContentAsString(arg1, arg2) -- Line 467
    return State_upvr:getRemoteConfigsContentAsString(arg2)
end
local Postie_upvr = require(script.Postie)
local Utilities_upvr = require(script.Utilities)
local LocalizationService_upvr = game:GetService("LocalizationService")
local var69_upvw
function module_upvr.PlayerJoined(arg1, arg2) -- Line 471
    local TeleportData_2 = arg2:GetJoinData().TeleportData
    local var181
    local any_GetPlayerData_result1 = Store_upvr:GetPlayerData(arg2)
    if TeleportData_2 then
        local gameanalyticsData = TeleportData_2.gameanalyticsData
        if gameanalyticsData then
            gameanalyticsData = TeleportData_2.gameanalyticsData[tostring(arg2.UserId)]
        end
        var181 = gameanalyticsData
    end
    local any_GetPlayerDataFromCache_result1_2 = Store_upvr:GetPlayerDataFromCache(arg2.UserId)
    if any_GetPlayerDataFromCache_result1_2 then
        if var181 then
            any_GetPlayerDataFromCache_result1_2.SessionID = var181.SessionID
            any_GetPlayerDataFromCache_result1_2.SessionStart = var181.SessionStart
        end
        any_GetPlayerDataFromCache_result1_2.PlayerTeleporting = false
    else
        local var185 = "unknown"
        local any_invokeClient_result1_3, any_invokeClient_result2 = Postie_upvr.invokeClient("getPlatform", arg2, 5)
        if any_invokeClient_result1_3 then
            var185 = any_invokeClient_result2
        end
        for i_4, v_4 in pairs(Store_upvr.BasePlayerData) do
            if not any_GetPlayerData_result1[i_4] then
                if typeof(v_4) == "table" then
                    any_GetPlayerData_result1[i_4] = Utilities_upvr:copyTable(v_4)
                else
                    any_GetPlayerData_result1[i_4] = v_4
                end
            end
        end
        local pcall_result1_2, pcall_result2 = pcall(function() -- Line 512
            return LocalizationService_upvr:GetCountryRegionForPlayerAsync(arg2)
        end)
        if pcall_result1_2 then
            any_GetPlayerData_result1.CountryCode = pcall_result2
        end
        local PlayerCache = Store_upvr.PlayerCache
        PlayerCache[arg2.UserId] = any_GetPlayerData_result1
        if var185 == "Console" then
            PlayerCache = "uwp_console"
        elseif var185 == "Mobile" then
            PlayerCache = "uwp_mobile"
        elseif var185 == "Desktop" then
            PlayerCache = "uwp_desktop"
        else
            PlayerCache = "uwp_desktop"
        end
        any_GetPlayerData_result1.Platform = PlayerCache
        any_GetPlayerData_result1.OS = any_GetPlayerData_result1.Platform.." 0.0.0"
        if not pcall_result1_2 then
            Events_upvr:addSdkErrorEvent(arg2.UserId, "event_validation", "player_joined", "string_empty_or_null", "country_code", "")
        end
        local var195 = ""
        if State_upvr.UseCustomUserId then
            local any_invokeClient_result1_4, any_invokeClient_result2_2 = Postie_upvr.invokeClient("getCustomUserId", arg2, 5)
            if any_invokeClient_result1_4 then
                var195 = any_invokeClient_result2_2
            end
        end
        if not Utilities_upvr:isStringNullOrEmpty(var195) then
            Logger_upvr:i("Using custom id: "..var195)
            any_GetPlayerData_result1.CustomUserId = var195
        end
        module_upvr:startNewSession(arg2, var181)
        local var198 = var69_upvw
        if not var198 then
            var198 = ReplicatedStorage_upvr:WaitForChild("OnPlayerReadyEvent")
        end
        var69_upvw = var198
        var69_upvw:Fire(arg2)
        if State_upvr.AutomaticSendBusinessEvents then
            if any_GetPlayerData_result1.OwnedGamepasses == nil then
                any_GetPlayerData_result1.OwnedGamepasses = {}
                for _, v_5 in ipairs(State_upvr._availableGamepasses) do
                    if MarketplaceService_upvr:UserOwnsGamePassAsync(arg2.UserId, v_5) then
                        table.insert(any_GetPlayerData_result1.OwnedGamepasses, v_5)
                    end
                end
                Store_upvr.PlayerCache[arg2.UserId] = any_GetPlayerData_result1
                Store_upvr:SavePlayerData(arg2)
            else
                local ipairs_result1_10, ipairs_result2_7, ipairs_result3 = ipairs(State_upvr._availableGamepasses)
                for _, v_6 in ipairs_result1_10, ipairs_result2_7, ipairs_result3 do
                    if MarketplaceService_upvr:UserOwnsGamePassAsync(arg2.UserId, v_6) then
                        table.insert({}, v_6)
                    end
                end
                ipairs_result3 = any_GetPlayerData_result1.OwnedGamepasses
                local ipairs_result1_12, ipairs_result2_6, ipairs_result3_6 = ipairs(ipairs_result3)
                for _, v_7 in ipairs_result1_12, ipairs_result2_6, ipairs_result3_6 do
                    ({})[v_7] = true
                    local var209
                end
                ipairs_result2_6 = {}
                local ipairs_result1_9, ipairs_result2_3, ipairs_result3_10 = ipairs(ipairs_result2_6)
                for _, v_8 in ipairs_result1_9, ipairs_result2_3, ipairs_result3_10 do
                    if not var209[v_8] then
                        table.insert(any_GetPlayerData_result1.OwnedGamepasses, v_8)
                        local var213 = tbl_6_upvr[v_8]
                        if not var213 then
                            var213 = MarketplaceService_upvr:GetProductInfo(v_8, Enum.InfoType.GamePass)
                            tbl_6_upvr[v_8] = var213
                        end
                        module_upvr:addBusinessEvent(arg2.UserId, {
                            amount = var213.PriceInRobux;
                            itemType = "Gamepass";
                            itemId = module_upvr:filterForBusinessEvent(var213.Name);
                            cartType = "Website";
                        })
                    end
                end
                ipairs_result2_3 = arg2.UserId
                Store_upvr.PlayerCache[ipairs_result2_3] = any_GetPlayerData_result1
                Store_upvr:SavePlayerData(arg2)
            end
        end
        local var215 = tbl_3_upvr[arg2.UserId]
        if var215 then
            tbl_3_upvr[arg2.UserId] = nil
            for _, v_9 in ipairs(var215) do
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                v_9.Func(unpack(v_9.Args))
            end
            Logger_upvr:i("Player initialization queue called #"..(#var215).." events")
        end
    end
end
function module_upvr.PlayerRemoved(arg1, arg2) -- Line 615
    Store_upvr:SavePlayerData(arg2)
    local any_GetPlayerDataFromCache_result1_3 = Store_upvr:GetPlayerDataFromCache(arg2.UserId)
    if any_GetPlayerDataFromCache_result1_3 then
        if not any_GetPlayerDataFromCache_result1_3.PlayerTeleporting then
            module_upvr:endSession(arg2.UserId)
            return
        end
        Store_upvr.PlayerCache[arg2.UserId] = nil
        Store_upvr.DataStoreQueue.RemoveKey(arg2.UserId)
    end
end
function module_upvr.isPlayerReady(arg1, arg2) -- Line 630
    if Store_upvr:GetPlayerDataFromCache(arg2) then
        return true
    end
    return false
end
function module_upvr.ProcessReceiptCallback(arg1, arg2) -- Line 638
    local var220_upvw = tbl_6_upvr[arg2.ProductId]
    if not var220_upvw then
        pcall(function() -- Line 645
            var220_upvw = MarketplaceService_upvr:GetProductInfo(arg2.ProductId, Enum.InfoType.Product)
            tbl_6_upvr[arg2.ProductId] = var220_upvw
        end)
    end
    if var220_upvw then
        module_upvr:addBusinessEvent(arg2.PlayerId, {
            amount = arg2.CurrencySpent;
            itemType = "DeveloperProduct";
            itemId = module_upvr:filterForBusinessEvent(var220_upvw.Name);
        })
    end
end
function module_upvr.GamepassPurchased(arg1, arg2, arg3, arg4) -- Line 661
    local var223
    if not var223 then
        var223 = MarketplaceService_upvr:GetProductInfo(arg3, Enum.InfoType.GamePass)
        tbl_6_upvr[arg3] = var223
    end
    local var224 = 0
    local var225 = "GamePass"
    if arg4 then
        var224 = arg4.PriceInRobux
        var225 = arg4.Name
    elseif var223 then
        var224 = var223.PriceInRobux
        var225 = var223.Name
    end
    local tbl_14 = {
        amount = var224 or 0;
        itemType = "Gamepass";
        itemId = module_upvr:filterForBusinessEvent(var225);
    }
    tbl_14.gamepassId = arg3
    module_upvr:addBusinessEvent(arg2.UserId, tbl_14)
end
local tbl_16_upvr = {"gameKey", "secretKey"}
function module_upvr.initServer(arg1, arg2, arg3) -- Line 692
    local tbl_15 = {}
    tbl_15.gameKey = arg2
    tbl_15.secretKey = arg3
    module_upvr:initialize(tbl_15)
end
function module_upvr.initialize(arg1, arg2) -- Line 699
    Threading_upvr:performTaskOnGAThread(function() -- Line 700
        for i_2, var243 in ipairs(tbl_16_upvr) do
            if arg2[var243] == nil then
                Logger_upvr:e("Initialize '"..var243.."' option missing")
                return
            end
        end
        if arg2.enableInfoLog ~= nil and arg2.enableInfoLog then
            module_upvr:setEnabledInfoLog(arg2.enableInfoLog)
        end
        if arg2.enableVerboseLog ~= nil and arg2.enableVerboseLog then
            module_upvr:setEnabledVerboseLog(arg2.enableVerboseLog)
        end
        if arg2.availableCustomDimensions01 ~= nil and 0 < #arg2.availableCustomDimensions01 then
            module_upvr:configureAvailableCustomDimensions01(arg2.availableCustomDimensions01)
        end
        if arg2.availableCustomDimensions02 ~= nil and 0 < #arg2.availableCustomDimensions02 then
            module_upvr:configureAvailableCustomDimensions02(arg2.availableCustomDimensions02)
        end
        if arg2.availableCustomDimensions03 ~= nil and 0 < #arg2.availableCustomDimensions03 then
            module_upvr:configureAvailableCustomDimensions03(arg2.availableCustomDimensions03)
        end
        if arg2.availableResourceCurrencies ~= nil and 0 < #arg2.availableResourceCurrencies then
            module_upvr:configureAvailableResourceCurrencies(arg2.availableResourceCurrencies)
        end
        if arg2.availableResourceItemTypes ~= nil and 0 < #arg2.availableResourceItemTypes then
            module_upvr:configureAvailableResourceItemTypes(arg2.availableResourceItemTypes)
        end
        if arg2.build ~= nil and 0 < #arg2.build then
            module_upvr:configureBuild(arg2.build)
        end
        if arg2.availableGamepasses ~= nil and 0 < #arg2.availableGamepasses then
            module_upvr:configureAvailableGamepasses(arg2.availableGamepasses)
        end
        if arg2.enableDebugLog ~= nil then
            module_upvr:setEnabledDebugLog(arg2.enableDebugLog)
        end
        if arg2.automaticSendBusinessEvents ~= nil then
            module_upvr:setEnabledAutomaticSendBusinessEvents(arg2.automaticSendBusinessEvents)
        end
        if arg2.reportErrors ~= nil then
            module_upvr:setEnabledReportErrors(arg2.reportErrors)
        end
        if arg2.useCustomUserId ~= nil then
            module_upvr:setEnabledCustomUserId(arg2.useCustomUserId)
        end
        if isSdkReady_upvr({
            needsInitialized = true;
            shouldWarn = false;
        }) then
            Logger_upvr:w("SDK already initialized. Can only be called once.")
        else
            local gameKey = arg2.gameKey
            local secretKey = arg2.secretKey
            var243 = gameKey
            if not Validation_upvr:validateKeys(var243, secretKey) then
                var243 = "SDK failed initialize. Game key or secret key is invalid. Can only contain characters A-z 0-9, gameKey is 32 length, secretKey is 40 length. Failed keys - gameKey: "..gameKey..", secretKey: "..secretKey
                Logger_upvr:w(var243)
                return
            end
            Events_upvr.GameKey = gameKey
            Events_upvr.SecretKey = secretKey
            i_2 = true
            State_upvr.Initialized = i_2
            function var243(arg1_2) -- Line 768
                module_upvr:PlayerJoined(arg1_2)
            end
            Players_upvr.PlayerAdded:Connect(var243)
            function var243(arg1_3) -- Line 773
                module_upvr:PlayerRemoved(arg1_3)
            end
            Players_upvr.PlayerRemoving:Connect(var243)
            i_2 = Players_upvr:GetPlayers()
            local ipairs_result1_5, ipairs_result2_2, ipairs_result3_11 = ipairs(i_2)
            for _, v_10 in ipairs_result1_5, ipairs_result2_2, ipairs_result3_11 do
                coroutine.wrap(module_upvr.PlayerJoined)(module_upvr, v_10)
            end
            ipairs_result2_2 = tbl_9_upvw
            local ipairs_result1_8, ipairs_result2_8, ipairs_result3_4 = ipairs(ipairs_result2_2)
            for _, v_11 in ipairs_result1_8, ipairs_result2_8, ipairs_result3_4 do
                task.spawn(v_11.Func, unpack(v_11.Args))
            end
            ipairs_result3_4 = "Server initialization queue called #"..(#tbl_9_upvw).." events"
            Logger_upvr:i(ipairs_result3_4)
            tbl_9_upvw = nil
            Events_upvr:processEventQueue()
        end
    end)
end
if not ReplicatedStorage_upvr:FindFirstChild("GameAnalyticsRemoteConfigs") then
    local RemoteEvent = Instance.new("RemoteEvent")
    RemoteEvent.Name = "GameAnalyticsRemoteConfigs"
    RemoteEvent.Parent = ReplicatedStorage_upvr
end
if not ReplicatedStorage_upvr:FindFirstChild("OnPlayerReadyEvent") then
    local BindableEvent = Instance.new("BindableEvent")
    BindableEvent.Name = "OnPlayerReadyEvent"
    BindableEvent.Parent = ReplicatedStorage_upvr
end
task.spawn(function() -- Line 808
    tbl_20_upvw = Store_upvr:GetErrorDataStore(math.floor(os.time() / 3600))
    while task.wait(3600) do
        tbl_20_upvw = Store_upvr:GetErrorDataStore(math.floor(os.time() / 3600))
        tbl_5_upvw = {}
        tbl_8_upvw = {}
    end
end)
task.spawn(function() -- Line 820
    while task.wait(Store_upvr.AutoSaveData) do
        for _, v_3 in pairs(tbl_8_upvw) do
            local var259 = tbl_5_upvw[v_3]
            tbl_5_upvw[v_3].countInDS = Store_upvr:IncrementErrorCount(tbl_20_upvw, v_3, var259.currentCount - var259.countInDS)
            tbl_5_upvw[v_3].currentCount = tbl_5_upvw[v_3].countInDS
        end
    end
end)
local function ErrorHandler_upvr(arg1, arg2, arg3, arg4) -- Line 831, Named "ErrorHandler"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var260 = "(null)"
    if arg3 ~= nil then
        var260 = arg3
    end
    local var261 = "(null)"
    if arg1 ~= nil then
        var261 = arg1
    end
    local var262 = "(null)"
    if arg2 ~= nil then
        var262 = arg2
    end
    local var263 = var260..": message="..var261..", trace="..var262
    if 8192 < #var263 then
    end
    local var264
    if arg4 then
        var264 = arg4.UserId
        local any_gsub_result1 = string.sub(var263, 1, 8192):gsub(arg4.Name, "[LocalPlayer]")
    end
    local var266 = any_gsub_result1
    if 50 < #var266 then
        var266 = string.sub(var266, 1, 50)
    end
    if tbl_5_upvw[var266] == nil then
        tbl_8_upvw[#tbl_8_upvw + 1] = var266
        tbl_5_upvw[var266] = {}
        tbl_5_upvw[var266].countInDS = 0
        tbl_5_upvw[var266].currentCount = 0
    end
    if 10 < tbl_5_upvw[var266].currentCount then
    else
        module_upvr:addErrorEvent(var264, {
            severity = module_upvr.EGAErrorSeverity.error;
            message = any_gsub_result1;
        })
        tbl_5_upvw[var266].currentCount = tbl_5_upvw[var266].currentCount + 1
    end
end
local function _(arg1, arg2, arg3, arg4) -- Line 903, Named "ErrorHandlerFromClient"
    if not State_upvr.ReportErrors then return end
    return ErrorHandler_upvr(arg1, arg2, arg3, arg4)
end
game:GetService("ScriptContext").Error:Connect(function(arg1, arg2, arg3) -- Line 882, Named "ErrorHandlerFromServer"
    if not State_upvr.ReportErrors then return end
    if not arg3 then return end
    local var268_upvw
    local pcall_result1_3, _ = pcall(function() -- Line 893
        var268_upvw = arg3:GetFullName()
    end)
    if not pcall_result1_3 then return end
    return ErrorHandler_upvr(arg1, arg2, var268_upvw)
end)
if not ReplicatedStorage_upvr:FindFirstChild("GameAnalyticsError") then
    local RemoteEvent_2 = Instance.new("RemoteEvent")
    RemoteEvent_2.Name = "GameAnalyticsError"
    RemoteEvent_2.Parent = ReplicatedStorage_upvr
end
ReplicatedStorage_upvr.GameAnalyticsError.OnServerEvent:Connect(function(arg1, arg2, arg3, arg4) -- Line 921
    if not State_upvr.ReportErrors then return end
end)
MarketplaceService_upvr.PromptGamePassPurchaseFinished:Connect(function(arg1, arg2, arg3) -- Line 927
    if not State_upvr.AutomaticSendBusinessEvents or not arg3 then
    else
        module_upvr:GamepassPurchased(arg1, arg2)
    end
end)
return module_upvr
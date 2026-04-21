local module_upvr = {
    ProcessEventsInterval = 8;
    GameKey = "";
    SecretKey = "";
    Build = "";
    _availableResourceCurrencies = {};
    _availableResourceItemTypes = {};
}
local Store_upvr = require(script.Parent.Store)
local Logger_upvr = require(script.Parent.Logger)
local Validation_upvr = require(script.Parent.Validation)
local Utilities_upvr = require(script.Parent.Utilities)
local HttpService_upvr = game:GetService("HttpService")
local function addDimensionsToEvent_upvr(arg1, arg2) -- Line 33, Named "addDimensionsToEvent"
    if not arg2 or not arg1 then
    else
        local any_GetPlayerDataFromCache_result1_5 = Store_upvr:GetPlayerDataFromCache(arg1)
        if any_GetPlayerDataFromCache_result1_5 and any_GetPlayerDataFromCache_result1_5.CurrentCustomDimension01 and 0 < #any_GetPlayerDataFromCache_result1_5.CurrentCustomDimension01 then
            arg2.custom_01 = any_GetPlayerDataFromCache_result1_5.CurrentCustomDimension01
        end
        if any_GetPlayerDataFromCache_result1_5 and any_GetPlayerDataFromCache_result1_5.CurrentCustomDimension02 and 0 < #any_GetPlayerDataFromCache_result1_5.CurrentCustomDimension02 then
            arg2.custom_02 = any_GetPlayerDataFromCache_result1_5.CurrentCustomDimension02
        end
        if any_GetPlayerDataFromCache_result1_5 and any_GetPlayerDataFromCache_result1_5.CurrentCustomDimension03 and 0 < #any_GetPlayerDataFromCache_result1_5.CurrentCustomDimension03 then
            arg2.custom_03 = any_GetPlayerDataFromCache_result1_5.CurrentCustomDimension03
        end
    end
end
local function _(arg1) -- Line 54, Named "getClientTsAdjusted"
    if not arg1 then
        return os.time()
    end
    local os_time_result1_2 = os.time()
    local var9 = os_time_result1_2 + Store_upvr:GetPlayerDataFromCache(arg1).ClientServerTimeOffset
    if Validation_upvr:validateClientTs(var9) then
        return var9
    end
    return os_time_result1_2
end
local function _(arg1) -- Line 71, Named "Length"
    local var14 = 0
    for _, _ in pairs(arg1) do
        var14 += 1
    end
    return var14
end
local any_lower_result1_upvr = HttpService_upvr:GenerateGUID(false):lower()
local Version_upvr = require(script.Parent.Version)
local function getEventAnnotations_upvr(arg1) -- Line 79, Named "getEventAnnotations"
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local var20
    local var21
    if arg1 then
        var21 = arg1
        var20 = Store_upvr:GetPlayerDataFromCache(arg1)
    else
        var21 = "DummyId"
        var20 = {
            OS = "uwp_desktop 0.0.0";
            Platform = "uwp_desktop";
            SessionID = any_lower_result1_upvr;
            Sessions = 1;
            CustomUserId = "Server";
        }
    end
    local _ = {
        v = 2;
        user_id = tostring(var21)..var20.CustomUserId;
    }
    if not arg1 then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if Validation_upvr:validateClientTs(os.time() + Store_upvr:GetPlayerDataFromCache(arg1).ClientServerTimeOffset) then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local function addEventToStore_upvr(arg1, arg2) -- Line 146, Named "addEventToStore"
    local getEventAnnotations_upvr_result1 = getEventAnnotations_upvr(arg1)
    for i_2 in pairs(arg2) do
        getEventAnnotations_upvr_result1[i_2] = arg2[i_2]
    end
    Logger_upvr:ii("Event added to queue: "..HttpService_upvr:JSONEncode(getEventAnnotations_upvr_result1))
    Store_upvr.EventsQueue[#Store_upvr.EventsQueue + 1] = getEventAnnotations_upvr_result1
end
local function dequeueMaxEvents_upvr() -- Line 165, Named "dequeueMaxEvents"
    if #Store_upvr.EventsQueue <= 500 then
        Store_upvr.EventsQueue = {}
        return Store_upvr.EventsQueue
    end
    Logger_upvr:w(string.format("More than %d events queued! Sending %d.", 500, 500));
    if 2000 < #Store_upvr.EventsQueue then
        Logger_upvr:w(string.format("DROPPING EVENTS: More than %d events queued!", 2000));
    end
    for i_3 = 1, 500 do
        table.create(500)[i_3] = Store_upvr.EventsQueue[i_3]
        local var37
    end
    local len = #Store_upvr.EventsQueue
    for i_4 = 1, math.min(2000, len) do
        Store_upvr.EventsQueue[i_4] = Store_upvr.EventsQueue[i_4 + 500]
    end
    for i_5 = 2001, len do
        Store_upvr.EventsQueue[i_5] = nil
    end
    return var37
end
local HttpApi_upvr = require(script.Parent.HttpApi)
local function processEvents_upvr() -- Line 198, Named "processEvents"
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local dequeueMaxEvents_result1 = dequeueMaxEvents_upvr()
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    Logger_upvr:i("Event queue: No events to send")
    do
        return
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    Logger_upvr:i("Event queue: Sending "..tostring(#dequeueMaxEvents_result1).." events.")
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local Threading_upvr = require(script.Parent.Threading)
function module_upvr.processEventQueue(arg1) -- Line 235
    processEvents_upvr()
    Threading_upvr:scheduleTimer(module_upvr.ProcessEventsInterval, function() -- Line 237
        module_upvr:processEventQueue()
    end)
end
function module_upvr.setBuild(arg1, arg2) -- Line 242
    if not Validation_upvr:validateBuild(arg2) then
        Logger_upvr:w("Validation fail - configure build: Cannot be null, empty or above 32 length. String: "..arg2)
    else
        arg1.Build = arg2
        Logger_upvr:i("Set build version: "..arg2)
    end
end
function module_upvr.setAvailableResourceCurrencies(arg1, arg2) -- Line 252
    if not Validation_upvr:validateResourceCurrencies(arg2) then
    else
        arg1._availableResourceCurrencies = arg2
        Logger_upvr:i("Set available resource currencies: ("..table.concat(arg2, ", ")..')')
    end
end
function module_upvr.setAvailableResourceItemTypes(arg1, arg2) -- Line 261
    if not Validation_upvr:validateResourceCurrencies(arg2) then
    else
        arg1._availableResourceItemTypes = arg2
        Logger_upvr:i("Set available resource item types: ("..table.concat(arg2, ", ")..')')
    end
end
function module_upvr.addSessionStartEvent(arg1, arg2, arg3) -- Line 270
    local any_GetPlayerDataFromCache_result1_4 = Store_upvr:GetPlayerDataFromCache(arg2)
    if arg3 then
        any_GetPlayerDataFromCache_result1_4.Sessions = arg3.Sessions
    else
        local tbl_5 = {
            category = "user";
        }
        any_GetPlayerDataFromCache_result1_4.Sessions += 1
        addDimensionsToEvent_upvr(arg2, tbl_5)
        addEventToStore_upvr(arg2, tbl_5)
        Logger_upvr:i("Add SESSION START event")
        processEvents_upvr()
    end
end
function module_upvr.addSessionEndEvent(arg1, arg2) -- Line 296
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local any_GetPlayerDataFromCache_result1_2 = Store_upvr:GetPlayerDataFromCache(arg2)
    local SessionStart = any_GetPlayerDataFromCache_result1_2.SessionStart
    local var48
    if not arg2 then
        var48 = os.time()
    else
        local os_time_result1 = os.time()
        local var50 = os_time_result1 + Store_upvr:GetPlayerDataFromCache(arg2).ClientServerTimeOffset
        if Validation_upvr:validateClientTs(var50) then
            var48 = var50
        else
            var48 = os_time_result1
        end
    end
    local var51
    if var48 ~= nil and SessionStart ~= nil then
        var51 = var48 - SessionStart
    end
    if var51 < 0 then
        Logger_upvr:w("Session length was calculated to be less then 0. Should not be possible. Resetting to 0.")
        var51 = 0
    end
    local tbl_8 = {
        category = "session_end";
        length = var51;
    }
    addDimensionsToEvent_upvr(arg2, tbl_8)
    addEventToStore_upvr(arg2, tbl_8)
    any_GetPlayerDataFromCache_result1_2.SessionStart = 0
    Logger_upvr:i("Add SESSION END event.")
    processEvents_upvr()
end
function module_upvr.addBusinessEvent(arg1, arg2, arg3, arg4, arg5, arg6, arg7) -- Line 330
    if not Validation_upvr:validateBusinessEvent(arg3, arg4, arg7, arg5, arg6) then
    else
        local tbl_2 = {}
        local any_GetPlayerDataFromCache_result1_3 = Store_upvr:GetPlayerDataFromCache(arg2)
        any_GetPlayerDataFromCache_result1_3.Transactions += 1
        tbl_2.event_id = arg5..':'..arg6
        tbl_2.category = "business"
        tbl_2.currency = arg3
        tbl_2.amount = arg4
        tbl_2.transaction_num = any_GetPlayerDataFromCache_result1_3.Transactions
        if not Utilities_upvr:isStringNullOrEmpty(arg7) then
            tbl_2.cart_type = arg7
        end
        addDimensionsToEvent_upvr(arg2, tbl_2)
        Logger_upvr:i("Add BUSINESS event: {currency:"..arg3..", amount:"..tostring(arg4)..", itemType:"..arg5..", itemId:"..arg6..", cartType:"..arg7..'}')
        addEventToStore_upvr(arg2, tbl_2)
    end
end
local GAResourceFlowType_upvr = require(script.Parent.GAResourceFlowType)
function module_upvr.addResourceEvent(arg1, arg2, arg3, arg4, arg5, arg6, arg7) -- Line 365
    local var56
    if not Validation_upvr:validateResourceEvent(GAResourceFlowType_upvr, arg3, arg4, arg5, arg6, arg7, arg1._availableResourceCurrencies, arg1._availableResourceItemTypes) then
    else
        if arg3 == GAResourceFlowType_upvr.Sink then
            var56 = -1 * var56
        end
        local tbl_7 = {
            event_id = GAResourceFlowType_upvr[arg3]..':'..arg4..':'..arg6..':'..arg7;
            category = "resource";
            amount = var56;
        }
        addDimensionsToEvent_upvr(arg2, tbl_7)
        Logger_upvr:i("Add RESOURCE event: {currency:"..arg4..", amount:"..tostring(var56)..", itemType:"..arg6..", itemId:"..arg7..'}')
        addEventToStore_upvr(arg2, tbl_7)
    end
end
local GAProgressionStatus_upvr = require(script.Parent.GAProgressionStatus)
function module_upvr.addProgressionEvent(arg1, arg2, arg3, arg4, arg5, arg6, arg7) -- Line 395
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local var59
    if not Validation_upvr:validateProgressionEvent(GAProgressionStatus_upvr, arg3, arg4, arg5, arg6) then
    else
        local tbl = {}
        var59 = nil
        if Utilities_upvr:isStringNullOrEmpty(arg5) then
            var59 = arg4
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        if Utilities_upvr:isStringNullOrEmpty(arg6) then
            var59 = arg4..':'..arg5
        else
            var59 = arg4..':'..arg5..':'..arg6
        end
        local var61 = GAProgressionStatus_upvr[arg3]
        tbl.category = "progression"
        tbl.event_id = var61..':'..var59
        local var62
        if arg7 ~= nil and arg3 ~= GAProgressionStatus_upvr.Start then
            tbl.score = arg7
        end
        local any_GetPlayerDataFromCache_result1 = Store_upvr:GetPlayerDataFromCache(arg2)
        if arg3 == GAProgressionStatus_upvr.Fail then
            any_GetPlayerDataFromCache_result1.ProgressionTries[var59] = (any_GetPlayerDataFromCache_result1.ProgressionTries[var59] or 0) + 1
        end
        if arg3 == GAProgressionStatus_upvr.Complete then
            any_GetPlayerDataFromCache_result1.ProgressionTries[var59] = (any_GetPlayerDataFromCache_result1.ProgressionTries[var59] or 0) + 1
            var62 = any_GetPlayerDataFromCache_result1.ProgressionTries[var59]
            tbl.attempt_num = var62
            any_GetPlayerDataFromCache_result1.ProgressionTries[var59] = 0
        end
        addDimensionsToEvent_upvr(arg2, tbl)
        local var64 = ""
        if not Utilities_upvr:isStringNullOrEmpty(arg5) then
            var64 = arg5
        end
        local var65 = ""
        if not Utilities_upvr:isStringNullOrEmpty(arg6) then
            var65 = arg6
        end
        Logger_upvr:i("Add PROGRESSION event: {status:"..var61..", progression01:"..arg4..", progression02:"..var64..", progression03:"..var65..", score:"..tostring(arg7)..", attempt:"..tostring(var62)..'}')
        addEventToStore_upvr(arg2, tbl)
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end
end
function module_upvr.addDesignEvent(arg1, arg2, arg3, arg4) -- Line 471
    if not Validation_upvr:validateDesignEvent(arg3) then
    else
        local tbl_6 = {
            category = "design";
        }
        tbl_6.event_id = arg3
        if arg4 ~= nil then
            tbl_6.value = arg4
        end
        addDimensionsToEvent_upvr(arg2, tbl_6)
        Logger_upvr:i("Add DESIGN event: {eventId:"..arg3..", value:"..tostring(arg4)..'}')
        addEventToStore_upvr(arg2, tbl_6)
    end
end
local GAErrorSeverity_upvr = require(script.Parent.GAErrorSeverity)
function module_upvr.addErrorEvent(arg1, arg2, arg3, arg4) -- Line 498
    if not Validation_upvr:validateErrorEvent(GAErrorSeverity_upvr, arg3, arg4) then
    else
        local tbl_4 = {}
        local var69 = GAErrorSeverity_upvr[arg3]
        tbl_4.category = "error"
        tbl_4.severity = var69
        tbl_4.message = arg4
        addDimensionsToEvent_upvr(arg2, tbl_4)
        local var70 = ""
        if not Utilities_upvr:isStringNullOrEmpty(arg4) then
            var70 = arg4
        end
        Logger_upvr:i("Add ERROR event: {severity:"..var69..", message:"..var70..'}')
        addEventToStore_upvr(arg2, tbl_4)
    end
end
function module_upvr.addSdkErrorEvent(arg1, arg2, arg3, arg4, arg5, arg6, arg7) -- Line 528
    local tbl_3 = {
        category = "sdk_error";
    }
    tbl_3.error_category = arg3
    tbl_3.error_area = arg4
    tbl_3.error_action = arg5
    if not Utilities_upvr:isStringNullOrEmpty(arg6) then
        tbl_3.error_parameter = arg6
    end
    if not Utilities_upvr:isStringNullOrEmpty(arg7) then
        tbl_3.reason = arg7
    end
    Logger_upvr:i("Add SDK ERROR event: {error_category:"..arg3..", error_area:"..arg4..", error_action:"..arg5..'}')
    addEventToStore_upvr(arg2, tbl_3)
end
return module_upvr
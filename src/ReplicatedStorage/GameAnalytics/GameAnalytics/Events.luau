local t = {
	ProcessEventsInterval = 8,
	GameKey = "",
	SecretKey = "",
	Build = "",
	_availableResourceCurrencies = {},
	_availableResourceItemTypes = {}
}
local Store = require(script.Parent.Store)
local Logger = require(script.Parent.Logger)
local Version = require(script.Parent.Version)
local Validation = require(script.Parent.Validation)
local Threading = require(script.Parent.Threading)
local HttpApi = require(script.Parent.HttpApi)
local Utilities = require(script.Parent.Utilities)
local GAResourceFlowType = require(script.Parent.GAResourceFlowType)
local GAProgressionStatus = require(script.Parent.GAProgressionStatus)
local GAErrorSeverity = require(script.Parent.GAErrorSeverity)
local HttpService = game:GetService("HttpService")
local function addDimensionsToEvent(p1, p2) --[[ Line: 33 | Upvalues: Store (copy) ]]
	if p2 and p1 then
		local v1 = Store:GetPlayerDataFromCache(p1)
		if v1 and (v1.CurrentCustomDimension01 and #v1.CurrentCustomDimension01 > 0) then
			p2.custom_01 = v1.CurrentCustomDimension01
		end
		if v1 and (v1.CurrentCustomDimension02 and #v1.CurrentCustomDimension02 > 0) then
			p2.custom_02 = v1.CurrentCustomDimension02
		end
		if v1 and (v1.CurrentCustomDimension03 and #v1.CurrentCustomDimension03 > 0) then
			p2.custom_03 = v1.CurrentCustomDimension03
		end
	end
end
local function getClientTsAdjusted(p1) --[[ Line: 54 | Upvalues: Store (copy), Validation (copy) ]]
	if p1 then
		local v1 = Store:GetPlayerDataFromCache(p1)
		local v2 = os.time()
		local v3 = v2 + v1.ClientServerTimeOffset
		if Validation:validateClientTs(v3) then
			return v3
		else
			return v2
		end
	else
		return os.time()
	end
end
local v1 = HttpService:GenerateGUID(false):lower()
local function Length(p1) --[[ Line: 71 ]]
	local count = 0
	for k, v in pairs(p1) do
		count = count + 1
	end
	return count
end
local function getEventAnnotations(p1) --[[ Line: 79 | Upvalues: Store (copy), v1 (copy), Validation (copy), Version (copy), Utilities (copy), t (copy) ]]
	local v12, v2
	if p1 then
		v12, v2 = p1, Store:GetPlayerDataFromCache(p1)
	else
		v12 = "DummyId"
		v2 = {
			OS = "uwp_desktop 0.0.0",
			Platform = "uwp_desktop",
			SessionID = v1,
			Sessions = 1,
			CustomUserId = "Server"
		}
	end
	local t2 = {
		v = 2,
		user_id = tostring(v12) .. v2.CustomUserId
	}
	local v4
	if p1 then
		local v5 = Store:GetPlayerDataFromCache(p1)
		local v6 = os.time()
		local v7 = v6 + v5.ClientServerTimeOffset
		v4 = if Validation:validateClientTs(v7) then v7 else v6
	else
		v4 = os.time()
	end
	t2.client_ts = v4
	t2.sdk_version = "roblox " .. Version.SdkVersion
	t2.os_version = v2.OS
	t2.manufacturer = "unknown"
	t2.device = "unknown"
	t2.platform = v2.Platform
	t2.session_id = v2.SessionID
	t2.session_num = v2.Sessions
	if Utilities:isStringNullOrEmpty(v2.CountryCode) then
		t2.country_code = "unknown"
	else
		t2.country_code = v2.CountryCode
	end
	if Validation:validateBuild(t.Build) then
		t2.build = t.Build
	end
	if v2.Configurations then
		local count = 0
		for k, v in pairs(v2.Configurations) do
			count = count + 1
		end
		if count > 0 then
			t2.configurations = v2.Configurations
		end
	end
	if not Utilities:isStringNullOrEmpty(v2.AbId) then
		t2.ab_id = v2.AbId
	end
	if not Utilities:isStringNullOrEmpty(v2.AbVariantId) then
		t2.ab_variant_id = v2.AbVariantId
	end
	return t2
end
local function addEventToStore(p1, p2) --[[ Line: 146 | Upvalues: getEventAnnotations (copy), HttpService (copy), Logger (copy), Store (copy) ]]
	local v1 = getEventAnnotations(p1)
	for k in pairs(p2) do
		v1[k] = p2[k]
	end
	Logger:ii("Event added to queue: " .. HttpService:JSONEncode(v1))
	Store.EventsQueue[#Store.EventsQueue + 1] = v1
end
local function dequeueMaxEvents() --[[ Line: 165 | Upvalues: Store (copy), Logger (copy) ]]
	if #Store.EventsQueue <= 500 then
		local EventsQueue = Store.EventsQueue
		Store.EventsQueue = {}
		return EventsQueue
	else
		Logger:w(("More than %d events queued! Sending %d."):format(500, 500))
		if #Store.EventsQueue > 2000 then
			Logger:w(("DROPPING EVENTS: More than %d events queued!"):format(2000))
		end
		local v1 = table.create(500)
		for i = 1, 500 do
			v1[i] = Store.EventsQueue[i]
		end
		local v2 = #Store.EventsQueue
		for j = 1, math.min(2000, v2) do
			Store.EventsQueue[j] = Store.EventsQueue[j + 500]
		end
		for k = 2001, v2 do
			Store.EventsQueue[k] = nil
		end
		return v1
	end
end
local function processEvents() --[[ Line: 198 | Upvalues: dequeueMaxEvents (copy), Logger (copy), HttpApi (copy), t (copy), Store (copy) ]]
	local v1 = dequeueMaxEvents()
	if #v1 == 0 then
		Logger:i("Event queue: No events to send")
		return
	end
	Logger:i("Event queue: Sending " .. tostring(#v1) .. " events.")
	local v2 = HttpApi:sendEventsInArray(t.GameKey, t.SecretKey, v1)
	local statusCode = v2.statusCode
	local body = v2.body
	if statusCode == HttpApi.EGAHTTPApiResponse.Ok and body then
		Logger:i("Event queue: " .. tostring(#v1) .. " events sent.")
		return
	end
	if statusCode == HttpApi.EGAHTTPApiResponse.NoResponse then
		Logger:w("Event queue: Failed to send events to collector - Retrying next time")
		for k, v in pairs(v1) do
			if not (#Store.EventsQueue < 2000) then
				break
			end
			Store.EventsQueue[#Store.EventsQueue + 1] = v
		end
	else
		if statusCode == HttpApi.EGAHTTPApiResponse.BadRequest and body then
			Logger:w("Event queue: " .. tostring(#v1) .. " events sent. " .. tostring(#body) .. " events failed GA server validation.")
			return
		end
		Logger:w("Event queue: Failed to send events.")
	end
end
function t.processEventQueue(p1) --[[ Line: 235 | Upvalues: processEvents (copy), Threading (copy), t (copy) ]]
	processEvents()
	Threading:scheduleTimer(t.ProcessEventsInterval, function() --[[ Line: 237 | Upvalues: t (ref) ]]
		t:processEventQueue()
	end)
end
function t.setBuild(p1, p2) --[[ Line: 242 | Upvalues: Validation (copy), Logger (copy) ]]
	if Validation:validateBuild(p2) then
		p1.Build = p2
		Logger:i("Set build version: " .. p2)
	else
		Logger:w("Validation fail - configure build: Cannot be null, empty or above 32 length. String: " .. p2)
	end
end
function t.setAvailableResourceCurrencies(p1, p2) --[[ Line: 252 | Upvalues: Validation (copy), Logger (copy) ]]
	if Validation:validateResourceCurrencies(p2) then
		p1._availableResourceCurrencies = p2
		Logger:i("Set available resource currencies: (" .. table.concat(p2, ", ") .. ")")
	end
end
function t.setAvailableResourceItemTypes(p1, p2) --[[ Line: 261 | Upvalues: Validation (copy), Logger (copy) ]]
	if Validation:validateResourceCurrencies(p2) then
		p1._availableResourceItemTypes = p2
		Logger:i("Set available resource item types: (" .. table.concat(p2, ", ") .. ")")
	end
end
function t.addSessionStartEvent(p1, p2, p3) --[[ Line: 270 | Upvalues: Store (copy), addDimensionsToEvent (copy), addEventToStore (copy), Logger (copy), processEvents (copy) ]]
	local v1 = Store:GetPlayerDataFromCache(p2)
	if p3 then
		v1.Sessions = p3.Sessions
	else
		local t = {
			category = "user"
		}
		v1.Sessions = v1.Sessions + 1
		addDimensionsToEvent(p2, t)
		addEventToStore(p2, t)
		Logger:i("Add SESSION START event")
		processEvents()
	end
end
function t.addSessionEndEvent(p1, p2) --[[ Line: 296 | Upvalues: Store (copy), Validation (copy), Logger (copy), addDimensionsToEvent (copy), addEventToStore (copy), processEvents (copy) ]]
	local v1 = Store:GetPlayerDataFromCache(p2)
	local SessionStart = v1.SessionStart
	local v2
	if p2 then
		local v3 = Store:GetPlayerDataFromCache(p2)
		local v4 = os.time()
		local v5 = v4 + v3.ClientServerTimeOffset
		v2 = if Validation:validateClientTs(v5) then v5 else v4
	else
		v2 = os.time()
	end
	local v6 = if v2 == nil or SessionStart == nil then 0 else v2 - SessionStart
	if v6 < 0 then
		Logger:w("Session length was calculated to be less then 0. Should not be possible. Resetting to 0.")
		v6 = 0
	end
	local t = {
		category = "session_end",
		length = v6
	}
	addDimensionsToEvent(p2, t)
	addEventToStore(p2, t)
	v1.SessionStart = 0
	Logger:i("Add SESSION END event.")
	processEvents()
end
function t.addBusinessEvent(p1, p2, p3, p4, p5, p6, p7) --[[ Line: 330 | Upvalues: Validation (copy), Store (copy), Utilities (copy), addDimensionsToEvent (copy), Logger (copy), addEventToStore (copy) ]]
	if Validation:validateBusinessEvent(p3, p4, p7, p5, p6) then
		local t = {}
		local v1 = Store:GetPlayerDataFromCache(p2)
		v1.Transactions = v1.Transactions + 1
		t.event_id = p5 .. ":" .. p6
		t.category = "business"
		t.currency = p3
		t.amount = p4
		t.transaction_num = v1.Transactions
		if not Utilities:isStringNullOrEmpty(p7) then
			t.cart_type = p7
		end
		addDimensionsToEvent(p2, t)
		Logger:i("Add BUSINESS event: {currency:" .. p3 .. ", amount:" .. tostring(p4) .. ", itemType:" .. p5 .. ", itemId:" .. p6 .. ", cartType:" .. p7 .. "}")
		addEventToStore(p2, t)
	end
end
function t.addResourceEvent(p1, p2, p3, p4, p5, p6, p7) --[[ Line: 365 | Upvalues: Validation (copy), GAResourceFlowType (copy), addDimensionsToEvent (copy), Logger (copy), addEventToStore (copy) ]]
	if Validation:validateResourceEvent(GAResourceFlowType, p3, p4, p5, p6, p7, p1._availableResourceCurrencies, p1._availableResourceItemTypes) then
		if p3 == GAResourceFlowType.Sink then
			p5 = -1 * p5
		end
		local t = {
			event_id = GAResourceFlowType[p3] .. ":" .. p4 .. ":" .. p6 .. ":" .. p7,
			category = "resource",
			amount = p5
		}
		addDimensionsToEvent(p2, t)
		Logger:i("Add RESOURCE event: {currency:" .. p4 .. ", amount:" .. tostring(p5) .. ", itemType:" .. p6 .. ", itemId:" .. p7 .. "}")
		addEventToStore(p2, t)
	end
end
function t.addProgressionEvent(p1, p2, p3, p4, p5, p6, p7) --[[ Line: 395 | Upvalues: Validation (copy), GAProgressionStatus (copy), Utilities (copy), Store (copy), addDimensionsToEvent (copy), Logger (copy), addEventToStore (copy) ]]
	if Validation:validateProgressionEvent(GAProgressionStatus, p3, p4, p5, p6) then
		local t = {}
		local v1 = if Utilities:isStringNullOrEmpty(p5) then p4 elseif Utilities:isStringNullOrEmpty(p6) then p4 .. ":" .. p5 else p4 .. ":" .. p5 .. ":" .. p6
		local v2 = GAProgressionStatus[p3]
		t.category = "progression"
		t.event_id = v2 .. ":" .. v1
		local v3 = 0
		if p7 ~= nil and p3 ~= GAProgressionStatus.Start then
			t.score = p7
		end
		local v4 = Store:GetPlayerDataFromCache(p2)
		if p3 == GAProgressionStatus.Fail then
			v4.ProgressionTries[v1] = (v4.ProgressionTries[v1] or 0) + 1
		end
		if p3 == GAProgressionStatus.Complete then
			v4.ProgressionTries[v1] = (v4.ProgressionTries[v1] or 0) + 1
			v3 = v4.ProgressionTries[v1]
			t.attempt_num = v3
			v4.ProgressionTries[v1] = 0
		end
		addDimensionsToEvent(p2, t)
		local v7 = if Utilities:isStringNullOrEmpty(p5) then "" else p5
		local v8 = if Utilities:isStringNullOrEmpty(p6) then "" else p6
		Logger:i("Add PROGRESSION event: {status:" .. v2 .. ", progression01:" .. p4 .. ", progression02:" .. v7 .. ", progression03:" .. v8 .. ", score:" .. tostring(p7) .. ", attempt:" .. tostring(v3) .. "}")
		addEventToStore(p2, t)
	end
end
function t.addDesignEvent(p1, p2, p3, p4) --[[ Line: 471 | Upvalues: Validation (copy), addDimensionsToEvent (copy), Logger (copy), addEventToStore (copy) ]]
	if Validation:validateDesignEvent(p3) then
		local t = {
			category = "design",
			event_id = p3
		}
		if p4 ~= nil then
			t.value = p4
		end
		addDimensionsToEvent(p2, t)
		Logger:i("Add DESIGN event: {eventId:" .. p3 .. ", value:" .. tostring(p4) .. "}")
		addEventToStore(p2, t)
	end
end
function t.addErrorEvent(p1, p2, p3, p4) --[[ Line: 498 | Upvalues: Validation (copy), GAErrorSeverity (copy), addDimensionsToEvent (copy), Utilities (copy), Logger (copy), addEventToStore (copy) ]]
	if Validation:validateErrorEvent(GAErrorSeverity, p3, p4) then
		local t = {}
		local v1 = GAErrorSeverity[p3]
		t.category = "error"
		t.severity = v1
		t.message = p4
		addDimensionsToEvent(p2, t)
		Logger:i("Add ERROR event: {severity:" .. v1 .. ", message:" .. if Utilities:isStringNullOrEmpty(p4) then "" else p4 .. "}")
		addEventToStore(p2, t)
	end
end
function t.addSdkErrorEvent(p1, p2, p3, p4, p5, p6, p7) --[[ Line: 528 | Upvalues: Utilities (copy), Logger (copy), addEventToStore (copy) ]]
	local t = {
		category = "sdk_error",
		error_category = p3,
		error_area = p4,
		error_action = p5
	}
	if not Utilities:isStringNullOrEmpty(p6) then
		t.error_parameter = p6
	end
	if not Utilities:isStringNullOrEmpty(p7) then
		t.reason = p7
	end
	Logger:i("Add SDK ERROR event: {error_category:" .. p3 .. ", error_area:" .. p4 .. ", error_action:" .. p5 .. "}")
	addEventToStore(p2, t)
end
return t
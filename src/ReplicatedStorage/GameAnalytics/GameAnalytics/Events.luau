local Events = {
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
local function addDimensionsToEvent(player, eventData)
	if eventData and player then
		local playerData = Store:GetPlayerDataFromCache(player)
		if playerData and (playerData.CurrentCustomDimension01 and #playerData.CurrentCustomDimension01 > 0) then
			eventData.custom_01 = playerData.CurrentCustomDimension01
		end
		if playerData and (playerData.CurrentCustomDimension02 and #playerData.CurrentCustomDimension02 > 0) then
			eventData.custom_02 = playerData.CurrentCustomDimension02
		end
		if playerData and (playerData.CurrentCustomDimension03 and #playerData.CurrentCustomDimension03 > 0) then
			eventData.custom_03 = playerData.CurrentCustomDimension03
		end
	end
end
local function getClientTsAdjusted(player)
	if player then
		local playerData = Store:GetPlayerDataFromCache(player)
		local currentTime = os.time()
		local adjustedTime = currentTime + playerData.ClientServerTimeOffset
		if Validation:validateClientTs(adjustedTime) then
			return adjustedTime
		else
			return currentTime
		end
	else
		return os.time()
	end
end
local sessionId = HttpService:GenerateGUID(false):lower()
local function Length(table)
	local count = 0
	for k, v in pairs(table) do
		count = count + 1
	end
	return count
end
local function getEventAnnotations(player)
	local playerId, playerData
	if player then
		playerId, playerData = player, Store:GetPlayerDataFromCache(player)
	else
		playerId = "DummyId"
		playerData = {
			OS = "uwp_desktop 0.0.0",
			Platform = "uwp_desktop",
			SessionID = sessionId,
			Sessions = 1,
			CustomUserId = "Server"
		}
	end
	local eventAnnotations = {
		version = 2,
		user_id = tostring(playerId) .. playerData.CustomUserId
	}
	local clientTimestamp
	if player then
		local playerDataTS = Store:GetPlayerDataFromCache(player)
		local currentTime = os.time()
		local adjustedTime = currentTime + playerDataTS.ClientServerTimeOffset
		clientTimestamp = if Validation:validateClientTs(adjustedTime) then adjustedTime else currentTime
	else
		clientTimestamp = os.time()
	end
	eventAnnotations.client_ts = clientTimestamp
	eventAnnotations.sdk_version = "roblox " .. Version.SdkVersion
	eventAnnotations.os_version = playerData.OS
	eventAnnotations.manufacturer = "unknown"
	eventAnnotations.device = "unknown"
	eventAnnotations.platform = playerData.Platform
	eventAnnotations.session_id = playerData.SessionID
	eventAnnotations.session_num = playerData.Sessions
	if Utilities:isStringNullOrEmpty(playerData.CountryCode) then
		eventAnnotations.country_code = "unknown"
	else
		eventAnnotations.country_code = playerData.CountryCode
	end
	if Validation:validateBuild(Events.Build) then
		eventAnnotations.build = Events.Build
	end
	if playerData.Configurations then
		local count = 0
		for k, v in pairs(playerData.Configurations) do
			count = count + 1
		end
		if count > 0 then
			eventAnnotations.configurations = playerData.Configurations
		end
	end
	if not Utilities:isStringNullOrEmpty(playerData.AbId) then
		eventAnnotations.ab_id = playerData.AbId
	end
	if not Utilities:isStringNullOrEmpty(playerData.AbVariantId) then
		eventAnnotations.ab_variant_id = playerData.AbVariantId
	end
	return eventAnnotations
end
local function addEventToStore(player, eventData)
	local eventAnnotations = getEventAnnotations(player)
	for k in pairs(eventData) do
		eventAnnotations[k] = eventData[k]
	end
	Logger:ii("Event added to queue: " .. HttpService:JSONEncode(eventAnnotations))
	Store.EventsQueue[#Store.EventsQueue + 1] = eventAnnotations
end
local function dequeueMaxEvents()
	if #Store.EventsQueue <= 500 then
		local EventsQueue = Store.EventsQueue
		Store.EventsQueue = {}
		return EventsQueue
	else
		Logger:w(("More than %d events queued! Sending %d."):format(500, 500))
		if #Store.EventsQueue > 2000 then
			Logger:w(("DROPPING EVENTS: More than %d events queued!"):format(2000))
		end
		local dequeuedEvents = table.create(500)
		for i = 1, 500 do
			dequeuedEvents[i] = Store.EventsQueue[i]
		end
		local originalQueueLength = #Store.EventsQueue
		for j = 1, math.min(2000, originalQueueLength) do
			Store.EventsQueue[j] = Store.EventsQueue[j + 500]
		end
		for k = 2001, originalQueueLength do
			Store.EventsQueue[k] = nil
		end
		return dequeuedEvents
	end
end
local function processEvents()
	local queuedEvents = dequeueMaxEvents()
	if #queuedEvents == 0 then
		Logger:i("Event queue: No events to send")
		return
	end
	Logger:i("Event queue: Sending " .. tostring(#queuedEvents) .. " events.")
	local response = HttpApi:sendEventsInArray(Events.GameKey, Events.SecretKey, queuedEvents)
	local statusCode = response.statusCode
	local body = response.body
	if statusCode == HttpApi.EGAHTTPApiResponse.Ok and body then
		Logger:i("Event queue: " .. tostring(#queuedEvents) .. " events sent.")
		return
	end
	if statusCode == HttpApi.EGAHTTPApiResponse.NoResponse then
		Logger:w("Event queue: Failed to send events to collector - Retrying next time")
		for k, v in pairs(queuedEvents) do
			if not (#Store.EventsQueue < 2000) then
				break
			end
			Store.EventsQueue[#Store.EventsQueue + 1] = v
		end
	else
		if statusCode == HttpApi.EGAHTTPApiResponse.BadRequest and body then
			Logger:w("Event queue: " .. tostring(#queuedEvents) .. " events sent. " .. tostring(#body) .. " events failed GA server validation.")
			return
		end
		Logger:w("Event queue: Failed to send events.")
	end
end
function Events.processEventQueue(self)
	processEvents()
	Threading:scheduleTimer(Events.ProcessEventsInterval, function()
		Events:processEventQueue()
	end)
end
function Events.setBuild(self, buildVersion)
	if Validation:validateBuild(buildVersion) then
		self.Build = buildVersion
		Logger:i("Set build version: " .. buildVersion)
	else
		Logger:w("Validation fail - configure build: Cannot be null, empty or above 32 length. String: " .. buildVersion)
	end
end
function Events.setAvailableResourceCurrencies(self, currenciesList)
	if Validation:validateResourceCurrencies(currenciesList) then
		self._availableResourceCurrencies = currenciesList
		Logger:i("Set available resource currencies: (" .. table.concat(currenciesList, ", ") .. ")")
	end
end
function Events.setAvailableResourceItemTypes(self, itemTypesList)
	if Validation:validateResourceCurrencies(itemTypesList) then
		self._availableResourceItemTypes = itemTypesList
		Logger:i("Set available resource item types: (" .. table.concat(itemTypesList, ", ") .. ")")
	end
end
function Events.addSessionStartEvent(self, player, options)
	local playerData = Store:GetPlayerDataFromCache(player)
	if options then
		playerData.Sessions = options.Sessions
	else
		local sessionEvent = {
			category = "user"
		}
		playerData.Sessions = playerData.Sessions + 1
		addDimensionsToEvent(player, sessionEvent)
		addEventToStore(player, sessionEvent)
		Logger:i("Add SESSION START event")
		processEvents()
	end
end
function Events.addSessionEndEvent(self, player)
	local playerData = Store:GetPlayerDataFromCache(player)
	local SessionStart = playerData.SessionStart
	local currentTimestamp
	if player then
		local playerDataTS = Store:GetPlayerDataFromCache(player)
		local currentTime = os.time()
		local adjustedTime = currentTime + playerDataTS.ClientServerTimeOffset
		currentTimestamp = if Validation:validateClientTs(adjustedTime) then adjustedTime else currentTime
	else
		currentTimestamp = os.time()
	end
	local sessionLength = if currentTimestamp == nil or SessionStart == nil then 0 else currentTimestamp - SessionStart
	if sessionLength < 0 then
		Logger:w("Session length was calculated to be less then 0. Should not be possible. Resetting to 0.")
		sessionLength = 0
	end
	local sessionEndEvent = {
		category = "session_end",
		length = sessionLength
	}
	addDimensionsToEvent(player, sessionEndEvent)
	addEventToStore(player, sessionEndEvent)
	playerData.SessionStart = 0
	Logger:i("Add SESSION END event.")
	processEvents()
end
function Events.addBusinessEvent(self, player, currency, amount, itemType, itemId, cartType)
	if Validation:validateBusinessEvent(currency, amount, cartType, itemType, itemId) then
		local businessEvent = {}
		local playerData = Store:GetPlayerDataFromCache(player)
		playerData.Transactions = playerData.Transactions + 1
		businessEvent.event_id = itemType .. ":" .. itemId
		businessEvent.category = "business"
		businessEvent.currency = currency
		businessEvent.amount = amount
		businessEvent.transaction_num = playerData.Transactions
		if not Utilities:isStringNullOrEmpty(cartType) then
			businessEvent.cart_type = cartType
		end
		addDimensionsToEvent(player, businessEvent)
		Logger:i("Add BUSINESS event: {currency:" .. currency .. ", amount:" .. tostring(amount) .. ", itemType:" .. itemType .. ", itemId:" .. itemId .. ", cartType:" .. cartType .. "}")
		addEventToStore(player, businessEvent)
	end
end
function Events.addResourceEvent(self, player, flowType, currency, amount, itemType, itemId)
	if Validation:validateResourceEvent(GAResourceFlowType, flowType, currency, amount, itemType, itemId, self._availableResourceCurrencies, self._availableResourceItemTypes) then
		if flowType == GAResourceFlowType.Sink then
			amount = -1 * amount
		end
		local resourceEvent = {
			event_id = GAResourceFlowType[flowType] .. ":" .. currency .. ":" .. itemType .. ":" .. itemId,
			category = "resource",
			amount = amount
		}
		addDimensionsToEvent(player, resourceEvent)
		Logger:i("Add RESOURCE event: {currency:" .. currency .. ", amount:" .. tostring(amount) .. ", itemType:" .. itemType .. ", itemId:" .. itemId .. "}")
		addEventToStore(player, resourceEvent)
	end
end
function Events.addProgressionEvent(self, player, status, progression01, progression02, progression03, score)
	if Validation:validateProgressionEvent(GAProgressionStatus, status, progression01, progression02, progression03) then
		local progressionEvent = {}
		local progressionId = if Utilities:isStringNullOrEmpty(progression02) then progression01 elseif Utilities:isStringNullOrEmpty(progression03) then progression01 .. ":" .. progression02 else progression01 .. ":" .. progression02 .. ":" .. progression03
		local progressionStatus = GAProgressionStatus[status]
		progressionEvent.category = "progression"
		progressionEvent.event_id = progressionStatus .. ":" .. progressionId
		local attemptNumber = 0
		if score ~= nil and status ~= GAProgressionStatus.Start then
			progressionEvent.score = score
		end
		local playerDataProgression = Store:GetPlayerDataFromCache(player)
		if status == GAProgressionStatus.Fail then
			playerDataProgression.ProgressionTries[progressionId] = (playerDataProgression.ProgressionTries[progressionId] or 0) + 1
		end
		if status == GAProgressionStatus.Complete then
			playerDataProgression.ProgressionTries[progressionId] = (playerDataProgression.ProgressionTries[progressionId] or 0) + 1
			attemptNumber = playerDataProgression.ProgressionTries[progressionId]
			progressionEvent.attempt_num = attemptNumber
			playerDataProgression.ProgressionTries[progressionId] = 0
		end
		addDimensionsToEvent(player, progressionEvent)
		local progression02Display = if Utilities:isStringNullOrEmpty(progression02) then "" else progression02
		local progression03Display = if Utilities:isStringNullOrEmpty(progression03) then "" else progression03
		Logger:i("Add PROGRESSION event: {status:" .. progressionStatus .. ", progression01:" .. progression01 .. ", progression02:" .. progression02Display .. ", progression03:" .. progression03Display .. ", score:" .. tostring(score) .. ", attempt:" .. tostring(attemptNumber) .. "}")
		addEventToStore(player, progressionEvent)
	end
end
function Events.addDesignEvent(self, player, eventId, eventValue)
	if Validation:validateDesignEvent(eventId) then
		local designEvent = {
			category = "design",
			event_id = eventId
		}
		if eventValue ~= nil then
			designEvent.value = eventValue
		end
		addDimensionsToEvent(player, designEvent)
		Logger:i("Add DESIGN event: {eventId:" .. eventId .. ", value:" .. tostring(eventValue) .. "}")
		addEventToStore(player, designEvent)
	end
end
function Events.addErrorEvent(self, player, severity, message)
	if Validation:validateErrorEvent(GAErrorSeverity, severity, message) then
		local errorEvent = {}
		local errorSeverity = GAErrorSeverity[severity]
		errorEvent.category = "error"
		errorEvent.severity = errorSeverity
		errorEvent.message = message
		addDimensionsToEvent(player, errorEvent)
		Logger:i("Add ERROR event: {severity:" .. errorSeverity .. ", message:" .. if Utilities:isStringNullOrEmpty(message) then "" else message .. "}")
		addEventToStore(player, errorEvent)
	end
end
function Events.addSdkErrorEvent(self, player, errorCategory, errorArea, errorAction, errorParameter, reason)
	local sdkErrorEvent = {
		category = "sdk_error",
		error_category = errorCategory,
		error_area = errorArea,
		error_action = errorAction
	}
	if not Utilities:isStringNullOrEmpty(errorParameter) then
		sdkErrorEvent.error_parameter = errorParameter
	end
	if not Utilities:isStringNullOrEmpty(reason) then
		sdkErrorEvent.reason = reason
	end
	Logger:i("Add SDK ERROR event: {error_category:" .. errorCategory .. ", error_area:" .. errorArea .. ", error_action:" .. errorAction .. "}")
	addEventToStore(player, sdkErrorEvent)
end
return Events

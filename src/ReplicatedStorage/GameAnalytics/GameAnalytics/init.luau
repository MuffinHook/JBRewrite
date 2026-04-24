-- Reviewed by Claude
local t = {
	EGAResourceFlowType = require(script.GAResourceFlowType),
	EGAProgressionStatus = require(script.GAProgressionStatus),
	EGAErrorSeverity = require(script.GAErrorSeverity)
}
local Logger = require(script.Logger)
local Threading = require(script.Threading)
local State = require(script.State)
local Validation = require(script.Validation)
local Store = require(script.Store)
local Events = require(script.Events)
local Utilities = require(script.Utilities)
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalizationService = game:GetService("LocalizationService")
local ScriptContext = game:GetService("ScriptContext")
local Postie = require(script.Postie)
local onPlayerReadyEvent = nil
local cachedProductInfo = {}
local errorDataStore = {}
local errorCounts = {}
local errorCountsChanged = {}
local initializationQueue = {}
local playerInitializationQueues = {}
local function addToInitializationQueue(func, ...)
	if initializationQueue == nil then
		Logger:w("Initialization queue already cleared.")
	else
		table.insert(initializationQueue, {
			Func = func,
			Args = { ... }
		})
		Logger:i("Added event to initialization queue")
	end
end
local function addToInitializationQueueByUserId(userId, func, ...)
	if t:isPlayerReady(userId) then
		Logger:w("Player initialization queue already cleared.")
	else
		if playerInitializationQueues[userId] == nil then
			playerInitializationQueues[userId] = {}
		end
		table.insert(playerInitializationQueues[userId], {
			Func = func,
			Args = { ... }
		})
		Logger:i("Added event to player initialization queue")
	end
end
local function isSdkReady(options)
	local playerId = options.playerId or nil
	local needsInitialized = options.needsInitialized or true
	local shouldWarn = options.shouldWarn or false
	local message = options.message or ""
	if needsInitialized and not State.Initialized then
		if shouldWarn then
			Logger:w(message .. " SDK is not initialized")
		end
	elseif needsInitialized and (playerId and not State:isEnabled(playerId)) then
		if shouldWarn then
			Logger:w(message .. " SDK is disabled")
		end
	elseif needsInitialized and (playerId and not State:sessionIsStarted(playerId)) then
		if shouldWarn then
			Logger:w(message .. " Session has not started yet")
		end
	else
		return true
	end
	return false
end
function t.configureAvailableCustomDimensions01(_, dimensions)
	if isSdkReady({
		needsInitialized = true,
		shouldWarn = false
	}) then
		Logger:w("Available custom dimensions must be set before SDK is initialized")
	else
		State:setAvailableCustomDimensions01(dimensions)
	end
end
function t.configureAvailableCustomDimensions02(_, dimensions)
	if isSdkReady({
		needsInitialized = true,
		shouldWarn = false
	}) then
		Logger:w("Available custom dimensions must be set before SDK is initialized")
	else
		State:setAvailableCustomDimensions02(dimensions)
	end
end
function t.configureAvailableCustomDimensions03(_, dimensions)
	if isSdkReady({
		needsInitialized = true,
		shouldWarn = false
	}) then
		Logger:w("Available custom dimensions must be set before SDK is initialized")
	else
		State:setAvailableCustomDimensions03(dimensions)
	end
end
function t.configureAvailableResourceCurrencies(_, currencies)
	if isSdkReady({
		needsInitialized = true,
		shouldWarn = false
	}) then
		Logger:w("Available resource currencies must be set before SDK is initialized")
	else
		Events:setAvailableResourceCurrencies(currencies)
	end
end
function t.configureAvailableResourceItemTypes(_, itemTypes)
	if isSdkReady({
		needsInitialized = true,
		shouldWarn = false
	}) then
		Logger:w("Available resource item types must be set before SDK is initialized")
	else
		Events:setAvailableResourceItemTypes(itemTypes)
	end
end
function t.configureBuild(_, build)
	if isSdkReady({
		needsInitialized = true,
		shouldWarn = false
	}) then
		Logger:w("Build version must be set before SDK is initialized.")
	else
		Events:setBuild(build)
	end
end
function t.configureAvailableGamepasses(_, gamepasses)
	if isSdkReady({
		needsInitialized = true,
		shouldWarn = false
	}) then
		Logger:w("Available gamepasses must be set before SDK is initialized.")
	else
		State:setAvailableGamepasses(gamepasses)
	end
end
function t.startNewSession(_, userId, sessionData)
	Threading:performTaskOnGAThread(function()
		if State:isEventSubmissionEnabled() then
			if State.Initialized then
				State:startNewSession(userId, sessionData)
			else
				Logger:w("Cannot start new session. SDK is not initialized yet.")
			end
		end
	end)
end
function t.endSession(_, userId)
	Threading:performTaskOnGAThread(function()
		if State:isEventSubmissionEnabled() then
			State:endSession(userId)
		end
	end)
end
function t.filterForBusinessEvent(_, text)
	return string.gsub(text, "[^A-Za-z0-9%s%-_%.%(%)!%?]", "")
end
function t.addBusinessEvent(_, userId, eventData)
	Threading:performTaskOnGAThread(function()
		if State:isEventSubmissionEnabled() then
			if isSdkReady({
				playerId = userId,
				needsInitialized = true,
				shouldWarn = false,
				message = "Could not add business event"
			}) then
				local itemType = eventData.itemType or ""
				local cartType = eventData.cartType or ""
				local amount = math.floor((eventData.amount or 0) * 0.7 * 0.35)
				local gamepassId = eventData.gamepassId or nil
				Events:addBusinessEvent(userId, "USD", amount, itemType, eventData.itemId or "", cartType)
				if itemType == "Gamepass" and cartType ~= "Website" then
					local player = Players:GetPlayerByUserId(userId)
					local playerData = Store:GetPlayerDataFromCache(userId)
					if not playerData.OwnedGamepasses then
						playerData.OwnedGamepasses = {}
					end
					table.insert(playerData.OwnedGamepasses, gamepassId)
					Store.PlayerCache[userId] = playerData
					Store:SavePlayerData(player)
				end
			elseif userId then
				addToInitializationQueueByUserId(userId, t.addBusinessEvent, t, userId, eventData)
			else
				addToInitializationQueue(t.addBusinessEvent, t, userId, eventData)
			end
		end
	end)
end
function t.addResourceEvent(_, userId, eventData)
	Threading:performTaskOnGAThread(function()
		if State:isEventSubmissionEnabled() then
			if isSdkReady({
				playerId = userId,
				needsInitialized = true,
				shouldWarn = false,
				message = "Could not add resource event"
			}) then
				Events:addResourceEvent(userId, eventData.flowType or 0, eventData.currency or "", eventData.amount or 0, eventData.itemType or "", eventData.itemId or "")
			elseif userId then
				addToInitializationQueueByUserId(userId, t.addResourceEvent, t, userId, eventData)
			else
				addToInitializationQueue(t.addResourceEvent, t, userId, eventData)
			end
		end
	end)
end
function t.addProgressionEvent(_, userId, eventData)
	Threading:performTaskOnGAThread(function()
		if State:isEventSubmissionEnabled() then
			if isSdkReady({
				playerId = userId,
				needsInitialized = true,
				shouldWarn = false,
				message = "Could not add progression event"
			}) then
				Events:addProgressionEvent(userId, eventData.progressionStatus or 0, eventData.progression01 or "", eventData.progression02 or nil, eventData.progression03 or nil, eventData.score or nil)
			elseif userId then
				addToInitializationQueueByUserId(userId, t.addProgressionEvent, t, userId, eventData)
			else
				addToInitializationQueue(t.addProgressionEvent, t, userId, eventData)
			end
		end
	end)
end
function t.addDesignEvent(_, userId, eventData)
	Threading:performTaskOnGAThread(function()
		if State:isEventSubmissionEnabled() then
			if isSdkReady({
				playerId = userId,
				needsInitialized = true,
				shouldWarn = false,
				message = "Could not add design event"
			}) then
				Events:addDesignEvent(userId, eventData.eventId or "", eventData.value or nil)
			elseif userId then
				addToInitializationQueueByUserId(userId, t.addDesignEvent, t, userId, eventData)
			else
				addToInitializationQueue(t.addDesignEvent, t, userId, eventData)
			end
		end
	end)
end
function t.addErrorEvent(_, userId, eventData)
	Threading:performTaskOnGAThread(function()
		if State:isEventSubmissionEnabled() then
			if isSdkReady({
				playerId = userId,
				needsInitialized = true,
				shouldWarn = false,
				message = "Could not add error event"
			}) then
				Events:addErrorEvent(userId, eventData.severity or 0, eventData.message or "")
			elseif userId then
				addToInitializationQueueByUserId(userId, t.addErrorEvent, t, userId, eventData)
			else
				addToInitializationQueue(t.addErrorEvent, t, userId, eventData)
			end
		end
	end)
end
function t.setEnabledDebugLog(_, enabled)
	if RunService:IsStudio() then
		if enabled then
			Logger:setDebugLog(enabled)
			Logger:i("Debug logging enabled")
		else
			Logger:i("Debug logging disabled")
			Logger:setDebugLog(enabled)
		end
	else
		Logger:i("setEnabledDebugLog can only be used in studio")
	end
end
function t.setEnabledInfoLog(_, enabled)
	if enabled then
		Logger:setInfoLog(enabled)
		Logger:i("Info logging enabled")
	else
		Logger:i("Info logging disabled")
		Logger:setInfoLog(enabled)
	end
end
function t.setEnabledVerboseLog(_, enabled)
	if enabled then
		Logger:setVerboseLog(enabled)
		Logger:ii("Verbose logging enabled")
	else
		Logger:ii("Verbose logging disabled")
		Logger:setVerboseLog(enabled)
	end
end
function t.setEnabledEventSubmission(_, enabled)
	Threading:performTaskOnGAThread(function()
		if enabled then
			State:setEventSubmission(enabled)
			Logger:i("Event submission enabled")
		else
			Logger:i("Event submission disabled")
			State:setEventSubmission(enabled)
		end
	end)
end
function t.setCustomDimension01(_, userId, dimensionValue)
	Threading:performTaskOnGAThread(function()
		if Validation:validateDimension(State._availableCustomDimensions01, dimensionValue) then
			if isSdkReady({
				playerId = userId,
				needsInitialized = true,
				shouldWarn = true,
				message = "Could not set custom01 dimension"
			}) then
				State:setCustomDimension01(userId, dimensionValue)
			end
		else
			Logger:w("Could not set custom01 dimension value to \'" .. dimensionValue .. "\'. Value not found in available custom01 dimension values")
		end
	end)
end
function t.setCustomDimension02(_, userId, dimensionValue)
	Threading:performTaskOnGAThread(function()
		if Validation:validateDimension(State._availableCustomDimensions02, dimensionValue) then
			if isSdkReady({
				playerId = userId,
				needsInitialized = true,
				shouldWarn = true,
				message = "Could not set custom02 dimension"
			}) then
				State:setCustomDimension02(userId, dimensionValue)
			end
		else
			Logger:w("Could not set custom02 dimension value to \'" .. dimensionValue .. "\'. Value not found in available custom02 dimension values")
		end
	end)
end
function t.setCustomDimension03(_, userId, dimensionValue)
	Threading:performTaskOnGAThread(function()
		if Validation:validateDimension(State._availableCustomDimensions03, dimensionValue) then
			if isSdkReady({
				playerId = userId,
				needsInitialized = true,
				shouldWarn = true,
				message = "Could not set custom03 dimension"
			}) then
				State:setCustomDimension03(userId, dimensionValue)
			end
		else
			Logger:w("Could not set custom03 dimension value to \'" .. dimensionValue .. "\'. Value not found in available custom03 dimension values")
		end
	end)
end
function t.setEnabledReportErrors(_, enabled)
	Threading:performTaskOnGAThread(function()
		State.ReportErrors = enabled
	end)
end
function t.setEnabledCustomUserId(_, enabled)
	Threading:performTaskOnGAThread(function()
		State.UseCustomUserId = enabled
	end)
end
function t.setEnabledAutomaticSendBusinessEvents(_, enabled)
	Threading:performTaskOnGAThread(function()
		State.AutomaticSendBusinessEvents = enabled
	end)
end
function t.addGameAnalyticsTeleportData(_, userIds, teleportData)
	local gameAnalyticsData = {}
	for i, userId in ipairs(userIds) do
		local playerData = Store:GetPlayerDataFromCache(userId)
		playerData.PlayerTeleporting = true
		gameAnalyticsData[tostring(userId)] = {
			SessionID = playerData.SessionID,
			Sessions = playerData.Sessions,
			SessionStart = playerData.SessionStart
		}
	end
	teleportData.gameanalyticsData = gameAnalyticsData
	return teleportData
end
function t.getRemoteConfigsValueAsString(_, userId, configOptions)
	return State:getRemoteConfigsStringValue(userId, configOptions.key or "", configOptions.defaultValue or nil)
end
function t.isRemoteConfigsReady(_, userId)
	return State:isRemoteConfigsReady(userId)
end
function t.getRemoteConfigsContentAsString(_, userId)
	return State:getRemoteConfigsContentAsString(userId)
end
function t.PlayerJoined(_, player)
	local TeleportData = player:GetJoinData().TeleportData
	local playerData = Store:GetPlayerData(player)
	local teleportGameAnalyticsData
	if TeleportData then
		local gameanalyticsData = TeleportData.gameanalyticsData
		if gameanalyticsData then
			gameanalyticsData = TeleportData.gameanalyticsData[tostring(player.UserId)]
		end
		teleportGameAnalyticsData = gameanalyticsData
	else
		teleportGameAnalyticsData = nil
	end
	local cachedPlayerData = Store:GetPlayerDataFromCache(player.UserId)
	if cachedPlayerData then
		if teleportGameAnalyticsData then
			cachedPlayerData.SessionID = teleportGameAnalyticsData.SessionID
			cachedPlayerData.SessionStart = teleportGameAnalyticsData.SessionStart
		end
		cachedPlayerData.PlayerTeleporting = false
	else
		local platformSuccess, platform = Postie.invokeClient("getPlatform", player, 5)
		local platformName = if platformSuccess then platform else "unknown"
		for k, v in pairs(Store.BasePlayerData) do
			if not playerData[k] then
				if typeof(v) == "table" then
					playerData[k] = Utilities:copyTable(v)
				else
					playerData[k] = v
				end
			end
		end
		local countrySuccess, countryCode = pcall(function()
			return LocalizationService:GetCountryRegionForPlayerAsync(player)
		end)
		if countrySuccess then
			playerData.CountryCode = countryCode
		end
		Store.PlayerCache[player.UserId] = playerData
		playerData.Platform = if platformName == "Console" then "uwp_console" elseif platformName == "Mobile" then "uwp_mobile" else "uwp_desktop"
		playerData.OS = playerData.Platform .. " 0.0.0"
		if not countrySuccess then
			Events:addSdkErrorEvent(player.UserId, "event_validation", "player_joined", "string_empty_or_null", "country_code", "")
		end
		local customUserId = ""
		if State.UseCustomUserId then
			local customIdSuccess, customIdValue = Postie.invokeClient("getCustomUserId", player, 5)
			if customIdSuccess then
				customUserId = customIdValue
			end
		end
		if not Utilities:isStringNullOrEmpty(customUserId) then
			Logger:i("Using custom id: " .. customUserId)
			playerData.CustomUserId = customUserId
		end
		t:startNewSession(player, teleportGameAnalyticsData)
		onPlayerReadyEvent = onPlayerReadyEvent or ReplicatedStorage:WaitForChild("OnPlayerReadyEvent")
		onPlayerReadyEvent:Fire(player)
		if State.AutomaticSendBusinessEvents then
			if playerData.OwnedGamepasses == nil then
				playerData.OwnedGamepasses = {}
				for i, gamepassId in ipairs(State._availableGamepasses) do
					if MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamepassId) then
						table.insert(playerData.OwnedGamepasses, gamepassId)
					end
				end
			else
				local newGamepassList = {}
				for i, gamepassId in ipairs(State._availableGamepasses) do
					if MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamepassId) then
						table.insert(newGamepassList, gamepassId)
					end
				end
				local ownedGamepassSet = {}
				for i, gamepassId in ipairs(playerData.OwnedGamepasses) do
					ownedGamepassSet[gamepassId] = true
				end
				for i, gamepassId in ipairs(newGamepassList) do
					if not ownedGamepassSet[gamepassId] then
						table.insert(playerData.OwnedGamepasses, gamepassId)
						local gamepassInfo = cachedProductInfo[gamepassId]
						if not gamepassInfo then
							local productInfo = MarketplaceService:GetProductInfo(gamepassId, Enum.InfoType.GamePass)
							cachedProductInfo[gamepassId] = productInfo
							gamepassInfo = productInfo
						end
						t:addBusinessEvent(player.UserId, {
							amount = gamepassInfo.PriceInRobux,
							itemType = "Gamepass",
							itemId = t:filterForBusinessEvent(gamepassInfo.Name),
							cartType = "Website"
						})
					end
				end
			end
			Store.PlayerCache[player.UserId] = playerData
			Store:SavePlayerData(player)
		end
		local playerQueuedEvents = playerInitializationQueues[player.UserId]
		if playerQueuedEvents then
			playerInitializationQueues[player.UserId] = nil
			for i, queuedEvent in ipairs(playerQueuedEvents) do
				queuedEvent.Func(unpack(queuedEvent.Args))
			end
			Logger:i("Player initialization queue called #" .. #playerQueuedEvents .. " events")
		end
	end
end
function t.PlayerRemoved(_, player)
	Store:SavePlayerData(player)
	local playerData = Store:GetPlayerDataFromCache(player.UserId)
	if playerData and playerData.PlayerTeleporting then
		Store.PlayerCache[player.UserId] = nil
		Store.DataStoreQueue.RemoveKey(player.UserId)
	elseif playerData then
		t:endSession(player.UserId)
	end
end
function t.isPlayerReady(_, userId)
	return Store:GetPlayerDataFromCache(userId) and true or false
end
function t.ProcessReceiptCallback(_, receiptData)
	local productInfo = cachedProductInfo[receiptData.ProductId]
	if not productInfo then
		pcall(function()
			productInfo = MarketplaceService:GetProductInfo(receiptData.ProductId, Enum.InfoType.Product)
			cachedProductInfo[receiptData.ProductId] = productInfo
		end)
	end
	if productInfo then
		t:addBusinessEvent(receiptData.PlayerId, {
			amount = receiptData.CurrencySpent,
			itemType = "DeveloperProduct",
			itemId = t:filterForBusinessEvent(productInfo.Name)
		})
	end
end
function t.GamepassPurchased(_, player, gamepassId, gamepassInfo)
	local cachedInfo = cachedProductInfo[gamepassId]
	if not cachedInfo then
		local productInfo = MarketplaceService:GetProductInfo(gamepassId, Enum.InfoType.GamePass)
		cachedProductInfo[gamepassId] = productInfo
		cachedInfo = productInfo
	end
	local amount = 0
	local gamepassName = "GamePass"
	if gamepassInfo then
		amount = gamepassInfo.PriceInRobux
		gamepassName = gamepassInfo.Name
	elseif cachedInfo then
		amount = cachedInfo.PriceInRobux
		gamepassName = cachedInfo.Name
	end
	t:addBusinessEvent(player.UserId, {
		amount = amount or 0,
		itemType = "Gamepass",
		itemId = t:filterForBusinessEvent(gamepassName),
		gamepassId = gamepassId
	})
end
local requiredInitKeys = { "gameKey", "secretKey" }
function t.initServer(_, gameKey, secretKey)
	t:initialize({
		gameKey = gameKey,
		secretKey = secretKey
	})
end
function t.initialize(_, config)
	Threading:performTaskOnGAThread(function()
		for i, requiredKey in ipairs(requiredInitKeys) do
			if config[requiredKey] == nil then
				Logger:e("Initialize \'" .. requiredKey .. "\' option missing")
				return
			end
		end
		if config.enableInfoLog ~= nil and config.enableInfoLog then
			t:setEnabledInfoLog(config.enableInfoLog)
		end
		if config.enableVerboseLog ~= nil and config.enableVerboseLog then
			t:setEnabledVerboseLog(config.enableVerboseLog)
		end
		if config.availableCustomDimensions01 ~= nil and #config.availableCustomDimensions01 > 0 then
			t:configureAvailableCustomDimensions01(config.availableCustomDimensions01)
		end
		if config.availableCustomDimensions02 ~= nil and #config.availableCustomDimensions02 > 0 then
			t:configureAvailableCustomDimensions02(config.availableCustomDimensions02)
		end
		if config.availableCustomDimensions03 ~= nil and #config.availableCustomDimensions03 > 0 then
			t:configureAvailableCustomDimensions03(config.availableCustomDimensions03)
		end
		if config.availableResourceCurrencies ~= nil and #config.availableResourceCurrencies > 0 then
			t:configureAvailableResourceCurrencies(config.availableResourceCurrencies)
		end
		if config.availableResourceItemTypes ~= nil and #config.availableResourceItemTypes > 0 then
			t:configureAvailableResourceItemTypes(config.availableResourceItemTypes)
		end
		if config.build ~= nil and #config.build > 0 then
			t:configureBuild(config.build)
		end
		if config.availableGamepasses ~= nil and #config.availableGamepasses > 0 then
			t:configureAvailableGamepasses(config.availableGamepasses)
		end
		if config.enableDebugLog ~= nil then
			t:setEnabledDebugLog(config.enableDebugLog)
		end
		if config.automaticSendBusinessEvents ~= nil then
			t:setEnabledAutomaticSendBusinessEvents(config.automaticSendBusinessEvents)
		end
		if config.reportErrors ~= nil then
			t:setEnabledReportErrors(config.reportErrors)
		end
		if config.useCustomUserId ~= nil then
			t:setEnabledCustomUserId(config.useCustomUserId)
		end
		if isSdkReady({
			needsInitialized = true,
			shouldWarn = false
		}) then
			Logger:w("SDK already initialized. Can only be called once.")
			return
		end
		local gameKey = config.gameKey
		local secretKey = config.secretKey
		if Validation:validateKeys(gameKey, secretKey) then
			Events.GameKey = gameKey
			Events.SecretKey = secretKey
			State.Initialized = true
			Players.PlayerAdded:Connect(function(joinedPlayer)
				t:PlayerJoined(joinedPlayer)
			end)
			Players.PlayerRemoving:Connect(function(leavingPlayer)
				t:PlayerRemoved(leavingPlayer)
			end)
			for i, joinedPlayer in ipairs(Players:GetPlayers()) do
				coroutine.wrap(t.PlayerJoined)(t, joinedPlayer)
			end
			for i, queuedEvent in ipairs(initializationQueue) do
				task.spawn(queuedEvent.Func, unpack(queuedEvent.Args))
			end
			Logger:i("Server initialization queue called #" .. #initializationQueue .. " events")
			initializationQueue = nil
			Events:processEventQueue()
		else
			Logger:w("SDK failed initialize. Game key or secret key is invalid. Can only contain characters A-z 0-9, gameKey is 32 length, secretKey is 40 length. Failed keys - gameKey: " .. gameKey .. ", secretKey: " .. secretKey)
		end
	end)
end
if not ReplicatedStorage:FindFirstChild("GameAnalyticsRemoteConfigs") then
	local GameAnalyticsRemoteConfigs = Instance.new("RemoteEvent")
	GameAnalyticsRemoteConfigs.Name = "GameAnalyticsRemoteConfigs"
	GameAnalyticsRemoteConfigs.Parent = ReplicatedStorage
end
if not ReplicatedStorage:FindFirstChild("OnPlayerReadyEvent") then
	local OnPlayerReadyEvent = Instance.new("BindableEvent")
	OnPlayerReadyEvent.Name = "OnPlayerReadyEvent"
	OnPlayerReadyEvent.Parent = ReplicatedStorage
end
task.spawn(function()
	errorDataStore = Store:GetErrorDataStore((math.floor(os.time() / 3600)))
	while task.wait(3600) do
		errorDataStore = Store:GetErrorDataStore((math.floor(os.time() / 3600)))
		errorCounts = {}
		errorCountsChanged = {}
	end
end)
task.spawn(function()
	while task.wait(Store.AutoSaveData) do
		for errorKey, errorSignature in pairs(errorCountsChanged) do
			local errorCount = errorCounts[errorSignature]
			errorCounts[errorSignature].countInDS = Store:IncrementErrorCount(errorDataStore, errorSignature, errorCount.currentCount - errorCount.countInDS)
			errorCounts[errorSignature].currentCount = errorCounts[errorSignature].countInDS
		end
	end
end)
local function ErrorHandler(message, traceback, scriptName, player)
	local fullErrorMessage = if scriptName == nil then "(null)" else scriptName .. ": message=" .. if message == nil then "(null)" else message .. ", trace=" .. if traceback == nil then "(null)" else traceback
	if #fullErrorMessage > 8192 then
		fullErrorMessage = string.sub(fullErrorMessage, 1, 8192)
	end
	local userId
	if player then
		userId = player.UserId
		fullErrorMessage = fullErrorMessage:gsub(player.Name, "[LocalPlayer]")
	else
		userId = nil
	end
	local errorSignature = if #fullErrorMessage > 50 then string.sub(fullErrorMessage, 1, 50) else fullErrorMessage
	if errorCounts[errorSignature] == nil then
		errorCountsChanged[#errorCountsChanged + 1] = errorSignature
		errorCounts[errorSignature] = {}
		errorCounts[errorSignature].countInDS = 0
		errorCounts[errorSignature].currentCount = 0
	end
	if not (errorCounts[errorSignature].currentCount > 10) then
		t:addErrorEvent(userId, {
			severity = t.EGAErrorSeverity.error,
			message = fullErrorMessage
		})
		errorCounts[errorSignature].currentCount = errorCounts[errorSignature].currentCount + 1
	end
end
local function ErrorHandlerFromServer(message, traceback, scriptInstance)
	if State.ReportErrors then
		if scriptInstance then
			local scriptName = nil
			local success, _ = pcall(function()
				scriptName = scriptInstance:GetFullName()
			end)
			if success then
				return ErrorHandler(message, traceback, scriptName)
			end
		end
	end
end
local function ErrorHandlerFromClient(message, traceback, scriptName, player)
	if State.ReportErrors then
		return ErrorHandler(message, traceback, scriptName, player)
	end
end
ScriptContext.Error:Connect(ErrorHandlerFromServer)
if not ReplicatedStorage:FindFirstChild("GameAnalyticsError") then
	local GameAnalyticsError = Instance.new("RemoteEvent")
	GameAnalyticsError.Name = "GameAnalyticsError"
	GameAnalyticsError.Parent = ReplicatedStorage
end
ReplicatedStorage.GameAnalyticsError.OnServerEvent:Connect(function(player, message, traceback, scriptName)
	if State.ReportErrors then
		ErrorHandler(message, traceback, scriptName, player)
	end
end)
MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, gamepassId, purchased)
	if State.AutomaticSendBusinessEvents and purchased then
		t:GamepassPurchased(player, gamepassId)
	end
end)
return t

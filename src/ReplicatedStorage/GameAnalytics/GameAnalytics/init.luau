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
local v1 = nil
local t2 = {}
local t3 = {}
local t4 = {}
local t5 = {}
local t6 = {}
local t7 = {}
local function addToInitializationQueue(p1, ...)
	if t6 == nil then
		Logger:w("Initialization queue already cleared.")
	else
		table.insert(t6, {
			Func = p1,
			Args = { ... }
		})
		Logger:i("Added event to initialization queue")
	end
end
local function addToInitializationQueueByUserId(p1, p2, ...)
	if t:isPlayerReady(p1) then
		Logger:w("Player initialization queue already cleared.")
	else
		if t7[p1] == nil then
			t7[p1] = {}
		end
		table.insert(t7[p1], {
			Func = p2,
			Args = { ... }
		})
		Logger:i("Added event to player initialization queue")
	end
end
local function isSdkReady(p1)
	local v1 = p1.playerId or nil
	local v2 = p1.needsInitialized or true
	local v3 = p1.shouldWarn or false
	local v4 = p1.message or ""
	if v2 and not State.Initialized then
		if v3 then
			Logger:w(v4 .. " SDK is not initialized")
		end
	elseif v2 and (v1 and not State:isEnabled(v1)) then
		if v3 then
			Logger:w(v4 .. " SDK is disabled")
		end
	elseif v2 and (v1 and not State:sessionIsStarted(v1)) then
		if v3 then
			Logger:w(v4 .. " Session has not started yet")
		end
	else
		return true
	end
	return false
end
function t.configureAvailableCustomDimensions01(p1, p2)
	if isSdkReady({
		needsInitialized = true,
		shouldWarn = false
	}) then
		Logger:w("Available custom dimensions must be set before SDK is initialized")
	else
		State:setAvailableCustomDimensions01(p2)
	end
end
function t.configureAvailableCustomDimensions02(p1, p2)
	if isSdkReady({
		needsInitialized = true,
		shouldWarn = false
	}) then
		Logger:w("Available custom dimensions must be set before SDK is initialized")
	else
		State:setAvailableCustomDimensions02(p2)
	end
end
function t.configureAvailableCustomDimensions03(p1, p2)
	if isSdkReady({
		needsInitialized = true,
		shouldWarn = false
	}) then
		Logger:w("Available custom dimensions must be set before SDK is initialized")
	else
		State:setAvailableCustomDimensions03(p2)
	end
end
function t.configureAvailableResourceCurrencies(p1, p2)
	if isSdkReady({
		needsInitialized = true,
		shouldWarn = false
	}) then
		Logger:w("Available resource currencies must be set before SDK is initialized")
	else
		Events:setAvailableResourceCurrencies(p2)
	end
end
function t.configureAvailableResourceItemTypes(p1, p2)
	if isSdkReady({
		needsInitialized = true,
		shouldWarn = false
	}) then
		Logger:w("Available resource item types must be set before SDK is initialized")
	else
		Events:setAvailableResourceItemTypes(p2)
	end
end
function t.configureBuild(p1, p2)
	if isSdkReady({
		needsInitialized = true,
		shouldWarn = false
	}) then
		Logger:w("Build version must be set before SDK is initialized.")
	else
		Events:setBuild(p2)
	end
end
function t.configureAvailableGamepasses(p1, p2)
	if isSdkReady({
		needsInitialized = true,
		shouldWarn = false
	}) then
		Logger:w("Available gamepasses must be set before SDK is initialized.")
	else
		State:setAvailableGamepasses(p2)
	end
end
function t.startNewSession(p1, p2, p3)
	Threading:performTaskOnGAThread(function()
		if State:isEventSubmissionEnabled() then
			if State.Initialized then
				State:startNewSession(p2, p3)
			else
				Logger:w("Cannot start new session. SDK is not initialized yet.")
			end
		end
	end)
end
function t.endSession(p1, p2)
	Threading:performTaskOnGAThread(function()
		if State:isEventSubmissionEnabled() then
			State:endSession(p2)
		end
	end)
end
function t.filterForBusinessEvent(p1, p2)
	return string.gsub(p2, "[^A-Za-z0-9%s%-_%.%(%)!%?]", "")
end
function t.addBusinessEvent(p1, p2, p3)
	Threading:performTaskOnGAThread(function()
		if State:isEventSubmissionEnabled() then
			if isSdkReady({
				playerId = p2,
				needsInitialized = true,
				shouldWarn = false,
				message = "Could not add business event"
			}) then
				local v2 = p3.itemType or ""
				local v4 = p3.cartType or ""
				local v5 = math.floor((p3.amount or 0) * 0.7 * 0.35)
				local v6 = p3.gamepassId or nil
				Events:addBusinessEvent(p2, "USD", v5, v2, p3.itemId or "", v4)
				if v2 == "Gamepass" and v4 ~= "Website" then
					local v7 = Players:GetPlayerByUserId(p2)
					local v8 = Store:GetPlayerDataFromCache(p2)
					if not v8.OwnedGamepasses then
						v8.OwnedGamepasses = {}
					end
					table.insert(v8.OwnedGamepasses, v6)
					Store.PlayerCache[p2] = v8
					Store:SavePlayerData(v7)
				end
			elseif p2 then
				addToInitializationQueueByUserId(p2, t.addBusinessEvent, t, p2, p3)
			else
				addToInitializationQueue(t.addBusinessEvent, t, p2, p3)
			end
		end
	end)
end
function t.addResourceEvent(p1, p2, p3)
	Threading:performTaskOnGAThread(function()
		if State:isEventSubmissionEnabled() then
			if isSdkReady({
				playerId = p2,
				needsInitialized = true,
				shouldWarn = false,
				message = "Could not add resource event"
			}) then
				Events:addResourceEvent(p2, p3.flowType or 0, p3.currency or "", p3.amount or 0, p3.itemType or "", p3.itemId or "")
			elseif p2 then
				addToInitializationQueueByUserId(p2, t.addResourceEvent, t, p2, p3)
			else
				addToInitializationQueue(t.addResourceEvent, t, p2, p3)
			end
		end
	end)
end
function t.addProgressionEvent(p1, p2, p3)
	Threading:performTaskOnGAThread(function()
		if State:isEventSubmissionEnabled() then
			if isSdkReady({
				playerId = p2,
				needsInitialized = true,
				shouldWarn = false,
				message = "Could not add progression event"
			}) then
				Events:addProgressionEvent(p2, p3.progressionStatus or 0, p3.progression01 or "", p3.progression02 or nil, p3.progression03 or nil, p3.score or nil)
			elseif p2 then
				addToInitializationQueueByUserId(p2, t.addProgressionEvent, t, p2, p3)
			else
				addToInitializationQueue(t.addProgressionEvent, t, p2, p3)
			end
		end
	end)
end
function t.addDesignEvent(p1, p2, p3)
	Threading:performTaskOnGAThread(function()
		if State:isEventSubmissionEnabled() then
			if isSdkReady({
				playerId = p2,
				needsInitialized = true,
				shouldWarn = false,
				message = "Could not add design event"
			}) then
				Events:addDesignEvent(p2, p3.eventId or "", p3.value or nil)
			elseif p2 then
				addToInitializationQueueByUserId(p2, t.addDesignEvent, t, p2, p3)
			else
				addToInitializationQueue(t.addDesignEvent, t, p2, p3)
			end
		end
	end)
end
function t.addErrorEvent(p1, p2, p3)
	Threading:performTaskOnGAThread(function()
		if State:isEventSubmissionEnabled() then
			if isSdkReady({
				playerId = p2,
				needsInitialized = true,
				shouldWarn = false,
				message = "Could not add error event"
			}) then
				Events:addErrorEvent(p2, p3.severity or 0, p3.message or "")
			elseif p2 then
				addToInitializationQueueByUserId(p2, t.addErrorEvent, t, p2, p3)
			else
				addToInitializationQueue(t.addErrorEvent, t, p2, p3)
			end
		end
	end)
end
function t.setEnabledDebugLog(p1, p2)
	if RunService:IsStudio() then
		if p2 then
			Logger:setDebugLog(p2)
			Logger:i("Debug logging enabled")
		else
			Logger:i("Debug logging disabled")
			Logger:setDebugLog(p2)
		end
	else
		Logger:i("setEnabledDebugLog can only be used in studio")
	end
end
function t.setEnabledInfoLog(p1, p2)
	if p2 then
		Logger:setInfoLog(p2)
		Logger:i("Info logging enabled")
	else
		Logger:i("Info logging disabled")
		Logger:setInfoLog(p2)
	end
end
function t.setEnabledVerboseLog(p1, p2)
	if p2 then
		Logger:setVerboseLog(p2)
		Logger:ii("Verbose logging enabled")
	else
		Logger:ii("Verbose logging disabled")
		Logger:setVerboseLog(p2)
	end
end
function t.setEnabledEventSubmission(p1, p2)
	Threading:performTaskOnGAThread(function()
		if p2 then
			State:setEventSubmission(p2)
			Logger:i("Event submission enabled")
		else
			Logger:i("Event submission disabled")
			State:setEventSubmission(p2)
		end
	end)
end
function t.setCustomDimension01(p1, p2, p3)
	Threading:performTaskOnGAThread(function()
		if Validation:validateDimension(State._availableCustomDimensions01, p3) then
			if isSdkReady({
				playerId = p2,
				needsInitialized = true,
				shouldWarn = true,
				message = "Could not set custom01 dimension"
			}) then
				State:setCustomDimension01(p2, p3)
			end
		else
			Logger:w("Could not set custom01 dimension value to \'" .. p3 .. "\'. Value not found in available custom01 dimension values")
		end
	end)
end
function t.setCustomDimension02(p1, p2, p3)
	Threading:performTaskOnGAThread(function()
		if Validation:validateDimension(State._availableCustomDimensions02, p3) then
			if isSdkReady({
				playerId = p2,
				needsInitialized = true,
				shouldWarn = true,
				message = "Could not set custom02 dimension"
			}) then
				State:setCustomDimension02(p2, p3)
			end
		else
			Logger:w("Could not set custom02 dimension value to \'" .. p3 .. "\'. Value not found in available custom02 dimension values")
		end
	end)
end
function t.setCustomDimension03(p1, p2, p3)
	Threading:performTaskOnGAThread(function()
		if Validation:validateDimension(State._availableCustomDimensions03, p3) then
			if isSdkReady({
				playerId = p2,
				needsInitialized = true,
				shouldWarn = true,
				message = "Could not set custom03 dimension"
			}) then
				State:setCustomDimension03(p2, p3)
			end
		else
			Logger:w("Could not set custom03 dimension value to \'" .. p3 .. "\'. Value not found in available custom03 dimension values")
		end
	end)
end
function t.setEnabledReportErrors(p1, p2)
	Threading:performTaskOnGAThread(function()
		State.ReportErrors = p2
	end)
end
function t.setEnabledCustomUserId(p1, p2)
	Threading:performTaskOnGAThread(function()
		State.UseCustomUserId = p2
	end)
end
function t.setEnabledAutomaticSendBusinessEvents(p1, p2)
	Threading:performTaskOnGAThread(function()
		State.AutomaticSendBusinessEvents = p2
	end)
end
function t.addGameAnalyticsTeleportData(p1, p2, p3)
	local t = {}
	for i, v in ipairs(p2) do
		local v1 = Store:GetPlayerDataFromCache(v)
		v1.PlayerTeleporting = true
		t[tostring(v)] = {
			SessionID = v1.SessionID,
			Sessions = v1.Sessions,
			SessionStart = v1.SessionStart
		}
	end
	p3.gameanalyticsData = t
	return p3
end
function t.getRemoteConfigsValueAsString(p1, p2, p3)
	return State:getRemoteConfigsStringValue(p2, p3.key or "", p3.defaultValue or nil)
end
function t.isRemoteConfigsReady(p1, p2)
	return State:isRemoteConfigsReady(p2)
end
function t.getRemoteConfigsContentAsString(p1, p2)
	return State:getRemoteConfigsContentAsString(p2)
end
function t.PlayerJoined(self, player)
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
		v1 = v1 or ReplicatedStorage:WaitForChild("OnPlayerReadyEvent")
		v1:Fire(p2)
		if State.AutomaticSendBusinessEvents then
			if v12.OwnedGamepasses == nil then
				v12.OwnedGamepasses = {}
				for i, v in ipairs(State._availableGamepasses) do
					if MarketplaceService:UserOwnsGamePassAsync(p2.UserId, v) then
						table.insert(v12.OwnedGamepasses, v)
					end
				end
			else
				local list = {}
				for i, v in ipairs(State._availableGamepasses) do
					if MarketplaceService:UserOwnsGamePassAsync(p2.UserId, v) then
						table.insert(list, v)
					end
				end
				local t3 = {}
				for i, v in ipairs(v12.OwnedGamepasses) do
					t3[v] = true
				end
				for i, v in ipairs(list) do
					if not t3[v] then
						table.insert(v12.OwnedGamepasses, v)
						local v14 = t2[v]
						if not v14 then
							local v15 = MarketplaceService:GetProductInfo(v, Enum.InfoType.GamePass)
							t2[v] = v15
							v14 = v15
						end
						t:addBusinessEvent(p2.UserId, {
							amount = v14.PriceInRobux,
							itemType = "Gamepass",
							itemId = t:filterForBusinessEvent(v14.Name),
							cartType = "Website"
						})
					end
				end
			end
			Store.PlayerCache[p2.UserId] = v12
			Store:SavePlayerData(p2)
		end
		local v16 = t7[p2.UserId]
		if v16 then
			t7[p2.UserId] = nil
			for i, v in ipairs(v16) do
				v.Func(unpack(v.Args))
			end
			Logger:i("Player initialization queue called #" .. #v16 .. " events")
		end
	end
end
function t.PlayerRemoved(p1, p2)
	Store:SavePlayerData(p2)
	local v1 = Store:GetPlayerDataFromCache(p2.UserId)
	if v1 and v1.PlayerTeleporting then
		Store.PlayerCache[p2.UserId] = nil
		Store.DataStoreQueue.RemoveKey(p2.UserId)
	elseif v1 then
		t:endSession(p2.UserId)
	end
end
function t.isPlayerReady(p1, p2)
	return Store:GetPlayerDataFromCache(p2) and true or false
end
function t.ProcessReceiptCallback(p1, p2)
	local v1 = t2[p2.ProductId]
	if not v1 then
		pcall(function()
			v1 = MarketplaceService:GetProductInfo(p2.ProductId, Enum.InfoType.Product)
			t2[p2.ProductId] = v1
		end)
	end
	if v1 then
		t:addBusinessEvent(p2.PlayerId, {
			amount = p2.CurrencySpent,
			itemType = "DeveloperProduct",
			itemId = t:filterForBusinessEvent(v1.Name)
		})
	end
end
function t.GamepassPurchased(p1, p2, p3, p4)
	local v1 = t2[p3]
	if not v1 then
		local v2 = MarketplaceService:GetProductInfo(p3, Enum.InfoType.GamePass)
		t2[p3] = v2
		v1 = v2
	end
	local v3 = 0
	local v4 = "GamePass"
	if p4 then
		v3 = p4.PriceInRobux
		v4 = p4.Name
	elseif v1 then
		v3 = v1.PriceInRobux
		v4 = v1.Name
	end
	t:addBusinessEvent(p2.UserId, {
		amount = v3 or 0,
		itemType = "Gamepass",
		itemId = t:filterForBusinessEvent(v4),
		gamepassId = p3
	})
end
local t8 = { "gameKey", "secretKey" }
function t.initServer(p1, p2, p3)
	t:initialize({
		gameKey = p2,
		secretKey = p3
	})
end
function t.initialize(p1, p2)
	Threading:performTaskOnGAThread(function()
		for i, v in ipairs(t8) do
			if p2[v] == nil then
				Logger:e("Initialize \'" .. v .. "\' option missing")
				return
			end
		end
		if p2.enableInfoLog ~= nil and p2.enableInfoLog then
			t:setEnabledInfoLog(p2.enableInfoLog)
		end
		if p2.enableVerboseLog ~= nil and p2.enableVerboseLog then
			t:setEnabledVerboseLog(p2.enableVerboseLog)
		end
		if p2.availableCustomDimensions01 ~= nil and #p2.availableCustomDimensions01 > 0 then
			t:configureAvailableCustomDimensions01(p2.availableCustomDimensions01)
		end
		if p2.availableCustomDimensions02 ~= nil and #p2.availableCustomDimensions02 > 0 then
			t:configureAvailableCustomDimensions02(p2.availableCustomDimensions02)
		end
		if p2.availableCustomDimensions03 ~= nil and #p2.availableCustomDimensions03 > 0 then
			t:configureAvailableCustomDimensions03(p2.availableCustomDimensions03)
		end
		if p2.availableResourceCurrencies ~= nil and #p2.availableResourceCurrencies > 0 then
			t:configureAvailableResourceCurrencies(p2.availableResourceCurrencies)
		end
		if p2.availableResourceItemTypes ~= nil and #p2.availableResourceItemTypes > 0 then
			t:configureAvailableResourceItemTypes(p2.availableResourceItemTypes)
		end
		if p2.build ~= nil and #p2.build > 0 then
			t:configureBuild(p2.build)
		end
		if p2.availableGamepasses ~= nil and #p2.availableGamepasses > 0 then
			t:configureAvailableGamepasses(p2.availableGamepasses)
		end
		if p2.enableDebugLog ~= nil then
			t:setEnabledDebugLog(p2.enableDebugLog)
		end
		if p2.automaticSendBusinessEvents ~= nil then
			t:setEnabledAutomaticSendBusinessEvents(p2.automaticSendBusinessEvents)
		end
		if p2.reportErrors ~= nil then
			t:setEnabledReportErrors(p2.reportErrors)
		end
		if p2.useCustomUserId ~= nil then
			t:setEnabledCustomUserId(p2.useCustomUserId)
		end
		if isSdkReady({
			needsInitialized = true,
			shouldWarn = false
		}) then
			Logger:w("SDK already initialized. Can only be called once.")
			return
		end
		local gameKey = p2.gameKey
		local secretKey = p2.secretKey
		if Validation:validateKeys(gameKey, secretKey) then
			Events.GameKey = gameKey
			Events.SecretKey = secretKey
			State.Initialized = true
			Players.PlayerAdded:Connect(function(p1)
				t:PlayerJoined(p1)
			end)
			Players.PlayerRemoving:Connect(function(p1)
				t:PlayerRemoved(p1)
			end)
			for i, v in ipairs(Players:GetPlayers()) do
				coroutine.wrap(t.PlayerJoined)(t, v)
			end
			for i, v in ipairs(t6) do
				task.spawn(v.Func, unpack(v.Args))
			end
			Logger:i("Server initialization queue called #" .. #t6 .. " events")
			t6 = nil
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
	t3 = Store:GetErrorDataStore((math.floor(os.time() / 3600)))
	while task.wait(3600) do
		t3 = Store:GetErrorDataStore((math.floor(os.time() / 3600)))
		t4 = {}
		t5 = {}
	end
end)
task.spawn(function()
	while task.wait(Store.AutoSaveData) do
		for k, v in pairs(t5) do
			local v1 = t4[v]
			t4[v].countInDS = Store:IncrementErrorCount(t3, v, v1.currentCount - v1.countInDS)
			t4[v].currentCount = t4[v].countInDS
		end
	end
end)
local function ErrorHandler(p1, p2, p3, p4)
	local v4 = if p3 == nil then "(null)" else p3 .. ": message=" .. if p1 == nil then "(null)" else p1 .. ", trace=" .. if p2 == nil then "(null)" else p2
	if #v4 > 8192 then
		v4 = string.sub(v4, 1, 8192)
	end
	local v6
	if p4 then
		v6 = p4.UserId
		v4 = v4:gsub(p4.Name, "[LocalPlayer]")
	else
		v6 = nil
	end
	local v8 = if #v4 > 50 then string.sub(v4, 1, 50) else v4
	if t4[v8] == nil then
		t5[#t5 + 1] = v8
		t4[v8] = {}
		t4[v8].countInDS = 0
		t4[v8].currentCount = 0
	end
	if not (t4[v8].currentCount > 10) then
		t:addErrorEvent(v6, {
			severity = t.EGAErrorSeverity.error,
			message = v4
		})
		t4[v8].currentCount = t4[v8].currentCount + 1
	end
end
local function ErrorHandlerFromServer(p1, p2, p3)
	if State.ReportErrors then
		if p3 then
			local v1 = nil
			local v2, _ = pcall(function()
				v1 = p3:GetFullName()
			end)
			if v2 then
				return ErrorHandler(p1, p2, v1)
			end
		end
	end
end
local function ErrorHandlerFromClient(p1, p2, p3, p4)
	if State.ReportErrors then
		return ErrorHandler(p1, p2, p3, p4)
	end
end
ScriptContext.Error:Connect(ErrorHandlerFromServer)
if not ReplicatedStorage:FindFirstChild("GameAnalyticsError") then
	local GameAnalyticsError = Instance.new("RemoteEvent")
	GameAnalyticsError.Name = "GameAnalyticsError"
	GameAnalyticsError.Parent = ReplicatedStorage
end
ReplicatedStorage.GameAnalyticsError.OnServerEvent:Connect(function(p1, p2, p3, p4)
	if State.ReportErrors then
		ErrorHandler(p2, p3, p4, p1)
	end
end)
MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(p1, p2, p3)
	if State.AutomaticSendBusinessEvents and p3 then
		t:GamepassPurchased(p1, p2)
	end
end)
return t

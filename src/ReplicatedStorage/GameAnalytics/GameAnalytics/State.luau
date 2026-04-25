-- Reviewed by Claude
-- variables reassigned
local Validation = require(script.Parent.Validation)
local Logger = require(script.Parent.Logger)
local HttpApi = require(script.Parent.HttpApi)
local Store = require(script.Parent.Store)
local Events = require(script.Parent.Events)
local HttpService = game:GetService("HttpService")
local StateModule = {
	_availableCustomDimensions01 = {},
	_availableCustomDimensions02 = {},
	_availableCustomDimensions03 = {},
	_availableGamepasses = {},
	_enableEventSubmission = true,
	Initialized = false,
	ReportErrors = true,
	UseCustomUserId = false,
	AutomaticSendBusinessEvents = true,
	ConfigsHash = ""
}
local remoteConfigsSignal = nil
local function getClientTsAdjusted(userId)
	local playerData = Store:GetPlayerDataFromCache(userId)
	if playerData then
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
local function populateConfigurations(player)
	local playerData = Store:GetPlayerDataFromCache(player.UserId)
	local SdkConfig = playerData.SdkConfig
	if SdkConfig.configs then
		for k, v in pairs(SdkConfig.configs) do
			local validatedTs
			if v then
				local configKey = v.key or ""
				local playerData2 = Store:GetPlayerDataFromCache(player.UserId)
				if playerData2 then
					local currentTime = os.time()
					local adjustedTime = currentTime + playerData2.ClientServerTimeOffset
					validatedTs = if Validation:validateClientTs(adjustedTime) then adjustedTime else currentTime
				else
					validatedTs = os.time()
				end
				if #configKey > 0 and (v.value and ((v.start_ts or 0) < validatedTs and validatedTs < (v.end_ts or (1 / 0)))) then
					playerData.Configurations[configKey] = v.value
					Logger:d("configuration added: key=" .. v.key .. ", value=" .. v.value)
				end
			end
		end
	end
	Logger:i("Remote configs populated")
	playerData.RemoteConfigsIsReady = true
	remoteConfigsSignal = remoteConfigsSignal or game:GetService("ReplicatedStorage"):WaitForChild("GameAnalyticsRemoteConfigs")
	remoteConfigsSignal:FireClient(player, playerData.Configurations)
end
function StateModule.sessionIsStarted(self, userId)
	local playerData = Store:GetPlayerDataFromCache(userId)
	if playerData then
		return playerData.SessionStart ~= 0
	else
		return false
	end
end
function StateModule.isEnabled(self, userId)
	local playerData = Store:GetPlayerDataFromCache(userId)
	if playerData then
		return playerData.InitAuthorized and true or false
	else
		return false
	end
end
function StateModule.validateAndFixCurrentDimensions(self, userId)
	local playerData = Store:GetPlayerDataFromCache(userId)
	if not Validation:validateDimension(self._availableCustomDimensions01, playerData.CurrentCustomDimension01) then
		Logger:d("Invalid dimension01 found in variable. Setting to nil. Invalid dimension: " .. playerData.CurrentCustomDimension01)
	end
	if not Validation:validateDimension(self._availableCustomDimensions02, playerData.CurrentCustomDimension02) then
		Logger:d("Invalid dimension02 found in variable. Setting to nil. Invalid dimension: " .. playerData.CurrentCustomDimension02)
	end
	if not Validation:validateDimension(self._availableCustomDimensions03, playerData.CurrentCustomDimension03) then
		Logger:d("Invalid dimension03 found in variable. Setting to nil. Invalid dimension: " .. playerData.CurrentCustomDimension03)
	end
end
function StateModule.setAvailableCustomDimensions01(self, dimensions)
	if Validation:validateCustomDimensions(dimensions) then
		self._availableCustomDimensions01 = dimensions
		Logger:i("Set available custom01 dimension values: (" .. table.concat(dimensions, ", ") .. ")")
	end
end
function StateModule.setAvailableCustomDimensions02(self, dimensions)
	if Validation:validateCustomDimensions(dimensions) then
		self._availableCustomDimensions02 = dimensions
		Logger:i("Set available custom02 dimension values: (" .. table.concat(dimensions, ", ") .. ")")
	end
end
function StateModule.setAvailableCustomDimensions03(self, dimensions)
	if Validation:validateCustomDimensions(dimensions) then
		self._availableCustomDimensions03 = dimensions
		Logger:i("Set available custom03 dimension values: (" .. table.concat(dimensions, ", ") .. ")")
	end
end
function StateModule.setAvailableGamepasses(self, gamepasses)
	self._availableGamepasses = gamepasses
	Logger:i("Set available game passes: (" .. table.concat(gamepasses, ", ") .. ")")
end
function StateModule.setEventSubmission(self, enabled)
	self._enableEventSubmission = enabled
end
function StateModule.isEventSubmissionEnabled(self)
	return self._enableEventSubmission
end
function StateModule.setCustomDimension01(self, userId, dimensionValue)
	Store:GetPlayerDataFromCache(userId).CurrentCustomDimension01 = dimensionValue
end
function StateModule.setCustomDimension02(self, userId, dimensionValue)
	Store:GetPlayerDataFromCache(userId).CurrentCustomDimension02 = dimensionValue
end
function StateModule.setCustomDimension03(self, userId, dimensionValue)
	Store:GetPlayerDataFromCache(userId).CurrentCustomDimension03 = dimensionValue
end
function StateModule.startNewSession(self, player, sessionData)
	if StateModule:isEventSubmissionEnabled() and sessionData == nil then
		Logger:i("Starting a new session.")
	end
	local playerData = Store:GetPlayerDataFromCache(player.UserId)
	StateModule:validateAndFixCurrentDimensions(player.UserId)
	local httpResponse = HttpApi:initRequest(Events.GameKey, Events.SecretKey, Events.Build, playerData, player.UserId)
	local statusCode = httpResponse.statusCode
	local body = httpResponse.body
	if (statusCode == HttpApi.EGAHTTPApiResponse.Ok or statusCode == HttpApi.EGAHTTPApiResponse.Created) and body then
		local serverTs = body.server_ts or -1
		body.time_offset = if serverTs > 0 then serverTs - os.time() else 0
		if statusCode ~= HttpApi.EGAHTTPApiResponse.Created then
			local SdkConfig = playerData.SdkConfig
			if SdkConfig.configs then
				body.configs = SdkConfig.configs
			end
			if SdkConfig.ab_id then
				body.ab_id = SdkConfig.ab_id
			end
			if SdkConfig.ab_variant_id then
				body.ab_variant_id = SdkConfig.ab_variant_id
			end
		end
		playerData.SdkConfig = body
		playerData.InitAuthorized = true
	elseif statusCode == HttpApi.EGAHTTPApiResponse.Unauthorized then
		Logger:w("Initialize SDK failed - Unauthorized")
		playerData.InitAuthorized = false
	else
		if statusCode == HttpApi.EGAHTTPApiResponse.NoResponse or statusCode == HttpApi.EGAHTTPApiResponse.RequestTimeout then
			Logger:i("Init call (session start) failed - no response. Could be offline or timeout.")
		elseif statusCode == HttpApi.EGAHTTPApiResponse.BadResponse or (statusCode == HttpApi.EGAHTTPApiResponse.JsonEncodeFailed or statusCode == HttpApi.EGAHTTPApiResponse.JsonDecodeFailed) then
			Logger:i("Init call (session start) failed - bad response. Could be bad response from proxy or GA servers.")
		elseif statusCode == HttpApi.EGAHTTPApiResponse.BadRequest or statusCode == HttpApi.EGAHTTPApiResponse.UnknownResponseCode then
			Logger:i("Init call (session start) failed - bad request or unknown response.")
		end
		playerData.InitAuthorized = true
	end
	playerData.ClientServerTimeOffset = playerData.SdkConfig.time_offset or 0
	playerData.ConfigsHash = playerData.SdkConfig.configs_hash or ""
	playerData.AbId = playerData.SdkConfig.ab_id or ""
	playerData.AbVariantId = playerData.SdkConfig.ab_variant_id or ""
	populateConfigurations(player)
	if StateModule:isEnabled(player.UserId) then
		if sessionData then
			playerData.SessionID = sessionData.SessionID
			playerData.SessionStart = sessionData.SessionStart
		else
			playerData.SessionID = string.lower(HttpService:GenerateGUID(false))
			local playerData2 = Store:GetPlayerDataFromCache(player.UserId)
			local validatedSessionStart
			if playerData2 then
				local currentTime = os.time()
				local adjustedTime = currentTime + playerData2.ClientServerTimeOffset
				validatedSessionStart = if Validation:validateClientTs(adjustedTime) then adjustedTime else currentTime
			else
				validatedSessionStart = os.time()
			end
			playerData.SessionStart = validatedSessionStart
		end
		if StateModule:isEventSubmissionEnabled() then
			Events:addSessionStartEvent(player.UserId, sessionData)
		end
	else
		Logger:w("Could not start session: SDK is disabled.")
	end
end
function StateModule.endSession(self, userId)
	if StateModule.Initialized and StateModule:isEventSubmissionEnabled() then
		Logger:i("Ending session.")
		if StateModule:isEnabled(userId) and StateModule:sessionIsStarted(userId) then
			Events:addSessionEndEvent(userId)
			Store.PlayerCache[userId] = nil
		end
	end
end
function StateModule.getRemoteConfigsStringValue(self, userId, configKey, defaultValue)
	return Store:GetPlayerDataFromCache(userId).Configurations[configKey] or defaultValue
end
function StateModule.isRemoteConfigsReady(self, userId)
	return Store:GetPlayerDataFromCache(userId).RemoteConfigsIsReady
end
function StateModule.getRemoteConfigsContentAsString(self, userId)
	return HttpService:JSONEncode(Store:GetPlayerDataFromCache(userId).Configurations)
end
return StateModule

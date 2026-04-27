local DataStoreService = game:GetService("DataStoreService")
local RunService = game:GetService("RunService")
local DataStoreQueue = require(script.DataStoreQueue)
local Store = {}
Store.PlayerDS = RunService:IsStudio() and {} or DataStoreService:GetDataStore("GA_PlayerDS_1.0.0")
Store.AutoSaveData = 180
Store.BasePlayerData = {
	Sessions = 0,
	Transactions = 0,
	ProgressionTries = {},
	CurrentCustomDimension01 = "",
	CurrentCustomDimension02 = "",
	CurrentCustomDimension03 = "",
	ConfigsHash = "",
	AbId = "",
	AbVariantId = "",
	InitAuthorized = false,
	SdkConfig = {},
	ClientServerTimeOffset = 0,
	Configurations = {},
	RemoteConfigsIsReady = false,
	PlayerTeleporting = false,
	OwnedGamepasses = nil,
	CountryCode = "",
	CustomUserId = ""
}
Store.DataToSave = { "Sessions", "Transactions", "ProgressionTries", "CurrentCustomDimension01", "CurrentCustomDimension02", "CurrentCustomDimension03", "OwnedGamepasses" }
Store.PlayerCache = {}
Store.EventsQueue = {}
Store.DataStoreQueue = DataStoreQueue
function Store.GetPlayerData(self, player)
	local UserId = player.UserId
	local success, data = DataStoreQueue.AddRequest(UserId, function()
		return RunService:IsStudio() and ({} or (Store.PlayerDS:GetAsync(UserId) or {})) or (Store.PlayerDS:GetAsync(UserId) or {})
	end, 7)
	if not success then
		data = {}
	end
	return data
end
function Store.GetPlayerDataFromCache(self, player)
	local cachedPlayerData = Store.PlayerCache[tonumber(player)]
	if cachedPlayerData then
		return cachedPlayerData
	else
		return Store.PlayerCache[tostring(player)]
	end
end
function Store.GetErrorDataStore(self, player)
	local errorStore = nil
	if not pcall(function()
		errorStore = RunService:IsStudio() and {} or DataStoreService:GetDataStore("GA_ErrorDS_1.0.0", player)
	end) then
		errorStore = {}
	end
	return errorStore
end
function Store.SavePlayerData(self, player)
	local playerData = Store:GetPlayerDataFromCache(player.UserId)
	local dataToSave = {}
	if playerData then
		for index, fieldName in pairs(Store.DataToSave) do
			dataToSave[fieldName] = playerData[fieldName]
		end
		local UserId = player.UserId
		if not RunService:IsStudio() then
			DataStoreQueue.AddRequest(UserId, function()
				return Store.PlayerDS:SetAsync(UserId, dataToSave)
			end, 7)
		end
	end
end
function Store.IncrementErrorCount(self, errorStoreKey, errorDataStore, incrementAmount)
	if errorDataStore then
		local errorCount
		if RunService:IsStudio() then
			errorCount = 0
		else
			local _success, incrementResult = DataStoreQueue.AddRequest(errorStoreKey, function()
				return errorDataStore:IncrementAsync(errorStoreKey, incrementAmount)
			end, 7)
			--_ = success
			errorCount = incrementResult
		end
		return errorCount
	end
end
return Store

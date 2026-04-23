local DataStoreService = game:GetService("DataStoreService")
local RunService = game:GetService("RunService")
local DataStoreQueue = require(script.DataStoreQueue)
local t = {}
t.PlayerDS = RunService:IsStudio() and {} or DataStoreService:GetDataStore("GA_PlayerDS_1.0.0")
t.AutoSaveData = 180
t.BasePlayerData = {
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
t.DataToSave = { "Sessions", "Transactions", "ProgressionTries", "CurrentCustomDimension01", "CurrentCustomDimension02", "CurrentCustomDimension03", "OwnedGamepasses" }
t.PlayerCache = {}
t.EventsQueue = {}
t.DataStoreQueue = DataStoreQueue
function t.GetPlayerData(p1, p2) --[[ Line: 45 | Upvalues: DataStoreQueue (copy), RunService (copy), t (copy) ]]
	local UserId = p2.UserId
	local v1, v2 = DataStoreQueue.AddRequest(UserId, function() --[[ Line: 47 | Upvalues: RunService (ref), t (ref), UserId (copy) ]]
		return RunService:IsStudio() and ({} or (t.PlayerDS:GetAsync(UserId) or {})) or (t.PlayerDS:GetAsync(UserId) or {})
	end, 7)
	if not v1 then
		v2 = {}
	end
	return v2
end
function t.GetPlayerDataFromCache(p1, p2) --[[ Line: 57 | Upvalues: t (copy) ]]
	local v1 = t.PlayerCache[tonumber(p2)]
	if v1 then
		return v1
	else
		return t.PlayerCache[tostring(p2)]
	end
end
function t.GetErrorDataStore(p1, p2) --[[ Line: 66 | Upvalues: RunService (copy), DataStoreService (copy) ]]
	local v1 = nil
	if not pcall(function() --[[ Line: 68 | Upvalues: v1 (ref), RunService (ref), DataStoreService (ref), p2 (copy) ]]
		v1 = RunService:IsStudio() and {} or DataStoreService:GetDataStore("GA_ErrorDS_1.0.0", p2)
	end) then
		v1 = {}
	end
	return v1
end
function t.SavePlayerData(p1, p2) --[[ Line: 79 | Upvalues: t (copy), RunService (copy), DataStoreQueue (copy) ]]
	local v1 = t:GetPlayerDataFromCache(p2.UserId)
	local t2 = {}
	if v1 then
		for k, v in pairs(t.DataToSave) do
			t2[v] = v1[v]
		end
		local UserId = p2.UserId
		if not RunService:IsStudio() then
			DataStoreQueue.AddRequest(UserId, function() --[[ Line: 96 | Upvalues: t (ref), UserId (copy), t2 (copy) ]]
				return t.PlayerDS:SetAsync(UserId, t2)
			end, 7)
		end
	end
end
function t.IncrementErrorCount(p1, p2, p3, p4) --[[ Line: 102 | Upvalues: RunService (copy), DataStoreQueue (copy) ]]
	if p3 then
		local v1
		if RunService:IsStudio() then
			v1 = 0
		else
			local v2, v3 = DataStoreQueue.AddRequest(p3, function() --[[ Line: 111 | Upvalues: p2 (copy), p3 (copy), p4 (copy) ]]
				return p2:IncrementAsync(p3, p4)
			end, 7)
			_ = v2
			v1 = v3
		end
		return v1
	end
end
return t
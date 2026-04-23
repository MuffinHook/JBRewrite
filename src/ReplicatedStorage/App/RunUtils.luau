game:GetService("MaterialService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunConsts = require(ReplicatedStorage.App.RunConsts)
require(ReplicatedStorage.PrivateServer.PrivateServerConsts)
local t = {}
local MAIN_WORLD_NAME = RunConsts.MAIN_WORLD_NAME
function t.isStudio() --[[ Line: 14 | Upvalues: RunService (copy) ]]
	return RunService:IsStudio() and true
end
local function getPlaceId() --[[ Line: 17 | Upvalues: RunService (copy), RunConsts (copy), MAIN_WORLD_NAME (copy) ]]
	if RunService:IsStudio() and game.PlaceId == 0 then
		return RunConsts.ENV_TO_WORLD_TO_PLACE_IDS_MAP[RunConsts.STUDIO_NAME][MAIN_WORLD_NAME].Default
	else
		return game.PlaceId
	end
end
t.isStudio()
function t.getBuildCommit() --[[ Line: 31 ]]
	local v1 = "0ec1e2e"
	if v1 == string.reverse("TIMMOC_DLIUB__") then
		v1 = "UNKNOWN"
	end
	return v1
end
function t.isTradeWorld() --[[ Line: 39 | Upvalues: RunService (copy), MAIN_WORLD_NAME (copy), RunConsts (copy) ]]
	if RunService:IsStudio() then
		return MAIN_WORLD_NAME == RunConsts.TRADE_WORLD_NAME
	else
		local isTRADE_WORLD_NAME = RunConsts.PLACE_ID_TO_WORLD_MAP[if RunService:IsStudio() and game.PlaceId == 0 then RunConsts.ENV_TO_WORLD_TO_PLACE_IDS_MAP[RunConsts.STUDIO_NAME][MAIN_WORLD_NAME].Default else game.PlaceId] == RunConsts.TRADE_WORLD_NAME
		return isTRADE_WORLD_NAME
	end
end
function t.isTradingEnabled() --[[ Line: 46 | Upvalues: t (copy) ]]
	return t.isTradeWorld()
end
function t.isMainWorld() --[[ Line: 49 | Upvalues: RunService (copy), MAIN_WORLD_NAME (copy), RunConsts (copy) ]]
	if RunService:IsStudio() then
		return MAIN_WORLD_NAME == RunConsts.MAIN_WORLD_NAME
	else
		local isMAIN_WORLD_NAME = RunConsts.PLACE_ID_TO_WORLD_MAP[if RunService:IsStudio() and game.PlaceId == 0 then RunConsts.ENV_TO_WORLD_TO_PLACE_IDS_MAP[RunConsts.STUDIO_NAME][MAIN_WORLD_NAME].Default else game.PlaceId] == RunConsts.MAIN_WORLD_NAME
		return isMAIN_WORLD_NAME
	end
end
function t.getEnv() --[[ Line: 56 | Upvalues: RunConsts (copy), RunService (copy), MAIN_WORLD_NAME (copy) ]]
	return RunConsts.PLACE_ID_TO_ENV_MAP[if RunService:IsStudio() and game.PlaceId == 0 then RunConsts.ENV_TO_WORLD_TO_PLACE_IDS_MAP[RunConsts.STUDIO_NAME][MAIN_WORLD_NAME].Default else game.PlaceId]
end
function t.getWorld() --[[ Line: 59 | Upvalues: RunService (copy), MAIN_WORLD_NAME (copy), RunConsts (copy) ]]
	if RunService:IsStudio() then
		return MAIN_WORLD_NAME
	else
		return RunConsts.PLACE_ID_TO_WORLD_MAP[if RunService:IsStudio() and game.PlaceId == 0 then RunConsts.ENV_TO_WORLD_TO_PLACE_IDS_MAP[RunConsts.STUDIO_NAME][MAIN_WORLD_NAME].Default else game.PlaceId]
	end
end
function t.getPlaceType() --[[ Line: 65 | Upvalues: RunService (copy), RunConsts (copy), MAIN_WORLD_NAME (copy) ]]
	if RunService:IsStudio() then
		return "Default"
	else
		return RunConsts.PLACE_ID_TO_PLACE_TYPE_MAP[if RunService:IsStudio() and game.PlaceId == 0 then RunConsts.ENV_TO_WORLD_TO_PLACE_IDS_MAP[RunConsts.STUDIO_NAME][MAIN_WORLD_NAME].Default else game.PlaceId]
	end
end
function t.getPlaceIdFromEnvWorld(p1, p2, p3) --[[ Line: 71 | Upvalues: RunConsts (copy) ]]
	local v1 = RunConsts.ENV_TO_WORLD_TO_PLACE_IDS_MAP[p1]
	assert(v1, "Invalid env given")
	local v2 = p3 or "Default"
	assert(v2 == "Default" or (v2 == "VoiceChat" or v2 == "Hang") or v2 == "Pro", "Invalid place type: " .. tostring(v2))
	local v5 = v1[p2][v2]
	assert(v5, "Invalid world or no place id")
	return v5
end
if RunService:IsServer() then
	function t.isVIPServer() --[[ Line: 84 ]]
		return game.PrivateServerId ~= "" and game.PrivateServerOwnerId ~= 0
	end
end
return t
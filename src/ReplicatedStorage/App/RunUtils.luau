-- Reviewed by Claude
-- variables reassigned
game:GetService("MaterialService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunConsts = require(ReplicatedStorage.App.RunConsts)
require(ReplicatedStorage.PrivateServer.PrivateServerConsts)
local module = {}
local MAIN_WORLD_NAME = RunConsts.MAIN_WORLD_NAME
function module.isStudio()
	return RunService:IsStudio() and true
end
local function getPlaceId()
	if RunService:IsStudio() and game.PlaceId == 0 then
		return RunConsts.ENV_TO_WORLD_TO_PLACE_IDS_MAP[RunConsts.STUDIO_NAME][MAIN_WORLD_NAME].Default
	else
		return game.PlaceId
	end
end
module.isStudio()
function module.getBuildCommit()
	local buildCommit = "0ec1e2e"
	if buildCommit == string.reverse("TIMMOC_DLIUB__") then
		buildCommit = "UNKNOWN"
	end
	return buildCommit
end
function module.isTradeWorld()
	if RunService:IsStudio() then
		return MAIN_WORLD_NAME == RunConsts.TRADE_WORLD_NAME
	else
		local isTRADE_WORLD_NAME = RunConsts.PLACE_ID_TO_WORLD_MAP[if RunService:IsStudio() and game.PlaceId == 0 then RunConsts.ENV_TO_WORLD_TO_PLACE_IDS_MAP[RunConsts.STUDIO_NAME][MAIN_WORLD_NAME].Default else game.PlaceId] == RunConsts.TRADE_WORLD_NAME
		return isTRADE_WORLD_NAME
	end
end
function module.isTradingEnabled()
	return module.isTradeWorld()
end
function module.isMainWorld()
	if RunService:IsStudio() then
		return MAIN_WORLD_NAME == RunConsts.MAIN_WORLD_NAME
	else
		local isMAIN_WORLD_NAME = RunConsts.PLACE_ID_TO_WORLD_MAP[if RunService:IsStudio() and game.PlaceId == 0 then RunConsts.ENV_TO_WORLD_TO_PLACE_IDS_MAP[RunConsts.STUDIO_NAME][MAIN_WORLD_NAME].Default else game.PlaceId] == RunConsts.MAIN_WORLD_NAME
		return isMAIN_WORLD_NAME
	end
end
function module.getEnv()
	return RunConsts.PLACE_ID_TO_ENV_MAP[if RunService:IsStudio() and game.PlaceId == 0 then RunConsts.ENV_TO_WORLD_TO_PLACE_IDS_MAP[RunConsts.STUDIO_NAME][MAIN_WORLD_NAME].Default else game.PlaceId]
end
function module.getWorld()
	if RunService:IsStudio() then
		return MAIN_WORLD_NAME
	else
		return RunConsts.PLACE_ID_TO_WORLD_MAP[if RunService:IsStudio() and game.PlaceId == 0 then RunConsts.ENV_TO_WORLD_TO_PLACE_IDS_MAP[RunConsts.STUDIO_NAME][MAIN_WORLD_NAME].Default else game.PlaceId]
	end
end
function module.getPlaceType()
	if RunService:IsStudio() then
		return "Default"
	else
		return RunConsts.PLACE_ID_TO_PLACE_TYPE_MAP[if RunService:IsStudio() and game.PlaceId == 0 then RunConsts.ENV_TO_WORLD_TO_PLACE_IDS_MAP[RunConsts.STUDIO_NAME][MAIN_WORLD_NAME].Default else game.PlaceId]
	end
end
function module.getPlaceIdFromEnvWorld(p1, p2, p3)
	local envMap = RunConsts.ENV_TO_WORLD_TO_PLACE_IDS_MAP[p1]
	assert(envMap, "Invalid env given")
	local placeType = p3 or "Default"
	assert(placeType == "Default" or (placeType == "VoiceChat" or placeType == "Hang") or placeType == "Pro", "Invalid place type: " .. tostring(placeType))
	local placeId = envMap[p2][placeType]
	assert(placeId, "Invalid world or no place id")
	return placeId
end
if RunService:IsServer() then
	function module.isVIPServer()
		return game.PrivateServerId ~= "" and game.PrivateServerOwnerId ~= 0
	end
end
return module

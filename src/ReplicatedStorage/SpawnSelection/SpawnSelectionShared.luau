-- Reviewed by Claude
-- variables reassigned
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerUtils = require(ReplicatedStorage.Game.PlayerUtils)
local Settings = require(ReplicatedStorage.Resource.Settings)
local SpawnSelectionConsts = require(ReplicatedStorage.SpawnSelection.SpawnSelectionConsts)
local GamepassSystem = require(ReplicatedStorage.Gamepass.GamepassSystem)
local GamepassUtils = require(ReplicatedStorage.Gamepass.GamepassUtils)
local t = {}
local function encodeSpawnName(spawnName)
	return spawnName:gsub("[^%w]", "")
end
function t.getPlayerLastSpawnedAt(player, spawnData)
	local encodedName = spawnData.name:gsub("[^%w]", "")
	local spawnTimeHolder = player:FindFirstChild(SpawnSelectionConsts.SPAWN_TIME_HOLDER_OBJ_NAME)
	if spawnTimeHolder then
		return spawnTimeHolder:GetAttribute(encodedName) or 0
	else
		return 0
	end
end
function t.recordPlayerSpawnedAt(player, spawnData)
	local encodedName = spawnData.name:gsub("[^%w]", "")
	local spawnTimeHolder = player:FindFirstChild(SpawnSelectionConsts.SPAWN_TIME_HOLDER_OBJ_NAME)
	if not spawnTimeHolder then
		local newHolder = Instance.new("BoolValue")
		newHolder.Name = SpawnSelectionConsts.SPAWN_TIME_HOLDER_OBJ_NAME
		newHolder.Parent = player
		spawnTimeHolder = newHolder
	end
	spawnTimeHolder:SetAttribute(encodedName, (workspace:GetServerTimeNow()))
	return true
end
function t.canPlayerSpawnAt(player, spawnData)
	if spawnData.exclusiveTeamId and not t.isTeamIdSame(PlayerUtils.getTeamId(player), spawnData.exclusiveTeamId) then
		return false
	elseif spawnData.exclusiveBoss and not GamepassSystem.doesPlayerOwnCached(player, GamepassUtils.EnumGamepass.BOSS) then
		return false, {
			gamepassRequired = GamepassUtils.EnumGamepass.BOSS
		}
	elseif spawnData.exclusiveSWAT and not GamepassSystem.doesPlayerOwnCached(player, GamepassUtils.EnumGamepass.SWAT) then
		return false, {
			gamepassRequired = GamepassUtils.EnumGamepass.SWAT
		}
	elseif spawnData.exclusiveVIP and not GamepassSystem.doesPlayerOwnCached(player, GamepassUtils.EnumGamepass.VIP) then
		return false, {
			gamepassRequired = GamepassUtils.EnumGamepass.VIP
		}
	else
		local lastDeathPos = player:GetAttribute("LastDeathPosition")
		local nowTime, timeDiff
		if lastDeathPos and typeof(lastDeathPos) == "Vector3" then
			local Magnitude = ((lastDeathPos - spawnData.position) * Vector3.new(1, 0, 1)).Magnitude
			if Magnitude < 900 then
				return false, {
					distance = Magnitude
				}
			else
				nowTime = workspace:GetServerTimeNow()
				timeDiff = SpawnSelectionConsts.SPAWN_COOLDOWN_TIME - (nowTime - t.getPlayerLastSpawnedAt(player, spawnData))
				if timeDiff > 0 then
					return false, {
						timeLeft = timeDiff
					}
				else
					return true
				end
			end
		else
			nowTime = workspace:GetServerTimeNow()
			timeDiff = SpawnSelectionConsts.SPAWN_COOLDOWN_TIME - (nowTime - t.getPlayerLastSpawnedAt(player, spawnData))
			if timeDiff > 0 then
				return false, {
					timeLeft = timeDiff
				}
			else
				return true
			end
		end
	end
end
function t.isTeamIdSame(playerTeamId, spawnTeamId)
	if spawnTeamId == Settings.EnumTeam.Police and playerTeamId ~= Settings.EnumTeam.Police then
		return false
	else
		return spawnTeamId ~= Settings.EnumTeam.Prisoner and spawnTeamId ~= Settings.EnumTeam.Criminal or (playerTeamId == Settings.EnumTeam.Prisoner or playerTeamId == Settings.EnumTeam.Criminal)
	end
end
function t.getSpawnDataFromSpawnPart(spawnPart)
	local teamNameAttr = spawnPart:GetAttribute(SpawnSelectionConsts.SPAWN_EXCLUSIVE_TEAM_NAME_ATTR_NAME)
	local exclusiveTeamId
	if teamNameAttr then
		if teamNameAttr then
			exclusiveTeamId = Settings.EnumTeam[teamNameAttr]
		else
			error(("Blank attribute SPAWN_EXCLUSIVE_TEAM_NAME_ATTR_NAME for %s"):format(spawnPart:GetFullName()))
		end
	else
		exclusiveTeamId = nil
	end
	local spawnDataTable = {
		name = spawnPart.Name,
		position = spawnPart.Position,
		exclusiveTeamId = exclusiveTeamId
	}
	spawnDataTable.exclusiveBoss = spawnPart:GetAttribute(SpawnSelectionConsts.SPAWN_EXCLUSIVE_BOSS_ATTR_NAME) == true
	spawnDataTable.exclusiveSWAT = spawnPart:GetAttribute(SpawnSelectionConsts.SPAWN_EXCLUSIVE_SWAT_ATTR_NAME) == true
	spawnDataTable.exclusiveVIP = spawnPart:GetAttribute(SpawnSelectionConsts.SPAWN_EXCLUSIVE_VIP_ATTR_NAME) == true
	spawnDataTable.useParachute = spawnPart:GetAttribute(SpawnSelectionConsts.SPAWN_USE_PARACHUTE_ATTR_NAME) == true
	return spawnDataTable
end
function t.getSpawnPartFromName(spawnName)
	for index, spawnPart in CollectionService:GetTagged(SpawnSelectionConsts.SPAWN_TAG_NAME) do
		if spawnPart.Name == spawnName then
			return spawnPart
		end
	end
end
function t.getAllSpawnData()
	local allSpawnsData = {}
	for index, spawnPart in CollectionService:GetTagged(SpawnSelectionConsts.SPAWN_TAG_NAME) do
		table.insert(allSpawnsData, t.getSpawnDataFromSpawnPart(spawnPart))
	end
	return allSpawnsData
end
return t

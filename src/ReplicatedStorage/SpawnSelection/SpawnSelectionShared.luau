-- Reviewed by Claude
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerUtils = require(ReplicatedStorage.Game.PlayerUtils)
local Settings = require(ReplicatedStorage.Resource.Settings)
local SpawnSelectionConsts = require(ReplicatedStorage.SpawnSelection.SpawnSelectionConsts)
local GamepassSystem = require(ReplicatedStorage.Gamepass.GamepassSystem)
local GamepassUtils = require(ReplicatedStorage.Gamepass.GamepassUtils)
local t = {}
local function encodeSpawnName(p1)
	return p1:gsub("[^%w]", "")
end
function t.getPlayerLastSpawnedAt(p1, p2)
	local v1 = p2.name:gsub("[^%w]", "")
	local v2 = p1:FindFirstChild(SpawnSelectionConsts.SPAWN_TIME_HOLDER_OBJ_NAME)
	if v2 then
		return v2:GetAttribute(v1) or 0
	else
		return 0
	end
end
function t.recordPlayerSpawnedAt(p1, p2)
	local v1 = p2.name:gsub("[^%w]", "")
	local v2 = p1:FindFirstChild(SpawnSelectionConsts.SPAWN_TIME_HOLDER_OBJ_NAME)
	if not v2 then
		local v3 = Instance.new("BoolValue")
		v3.Name = SpawnSelectionConsts.SPAWN_TIME_HOLDER_OBJ_NAME
		v3.Parent = p1
		v2 = v3
	end
	v2:SetAttribute(v1, (workspace:GetServerTimeNow()))
	return true
end
function t.canPlayerSpawnAt(p1, p2)
	if p2.exclusiveTeamId and not t.isTeamIdSame(PlayerUtils.getTeamId(p1), p2.exclusiveTeamId) then
		return false
	elseif p2.exclusiveBoss and not GamepassSystem.doesPlayerOwnCached(p1, GamepassUtils.EnumGamepass.BOSS) then
		return false, {
			gamepassRequired = GamepassUtils.EnumGamepass.BOSS
		}
	elseif p2.exclusiveSWAT and not GamepassSystem.doesPlayerOwnCached(p1, GamepassUtils.EnumGamepass.SWAT) then
		return false, {
			gamepassRequired = GamepassUtils.EnumGamepass.SWAT
		}
	elseif p2.exclusiveVIP and not GamepassSystem.doesPlayerOwnCached(p1, GamepassUtils.EnumGamepass.VIP) then
		return false, {
			gamepassRequired = GamepassUtils.EnumGamepass.VIP
		}
	else
		local v2 = p1:GetAttribute("LastDeathPosition")
		local v3, v4
		if v2 and typeof(v2) == "Vector3" then
			local Magnitude = ((v2 - p2.position) * Vector3.new(1, 0, 1)).Magnitude
			if Magnitude < 900 then
				return false, {
					distance = Magnitude
				}
			else
				v3 = workspace:GetServerTimeNow()
				v4 = SpawnSelectionConsts.SPAWN_COOLDOWN_TIME - (v3 - t.getPlayerLastSpawnedAt(p1, p2))
				if v4 > 0 then
					return false, {
						timeLeft = v4
					}
				else
					return true
				end
			end
		else
			v3 = workspace:GetServerTimeNow()
			v4 = SpawnSelectionConsts.SPAWN_COOLDOWN_TIME - (v3 - t.getPlayerLastSpawnedAt(p1, p2))
			if v4 > 0 then
				return false, {
					timeLeft = v4
				}
			else
				return true
			end
		end
	end
end
function t.isTeamIdSame(p1, p2)
	if p2 == Settings.EnumTeam.Police and p1 ~= Settings.EnumTeam.Police then
		return false
	else
		return p2 ~= Settings.EnumTeam.Prisoner and p2 ~= Settings.EnumTeam.Criminal or (p1 == Settings.EnumTeam.Prisoner or p1 == Settings.EnumTeam.Criminal)
	end
end
function t.getSpawnDataFromSpawnPart(p1)
	local v1 = p1:GetAttribute(SpawnSelectionConsts.SPAWN_EXCLUSIVE_TEAM_NAME_ATTR_NAME)
	local v2
	if v1 then
		if v1 then
			v2 = Settings.EnumTeam[v1]
		else
			error(("Blank attribute SPAWN_EXCLUSIVE_TEAM_NAME_ATTR_NAME for %s"):format(p1:GetFullName()))
		end
	else
		v2 = nil
	end
	local t = {
		name = p1.Name,
		position = p1.Position,
		exclusiveTeamId = v2
	}
	t.exclusiveBoss = p1:GetAttribute(SpawnSelectionConsts.SPAWN_EXCLUSIVE_BOSS_ATTR_NAME) == true
	t.exclusiveSWAT = p1:GetAttribute(SpawnSelectionConsts.SPAWN_EXCLUSIVE_SWAT_ATTR_NAME) == true
	t.exclusiveVIP = p1:GetAttribute(SpawnSelectionConsts.SPAWN_EXCLUSIVE_VIP_ATTR_NAME) == true
	t.useParachute = p1:GetAttribute(SpawnSelectionConsts.SPAWN_USE_PARACHUTE_ATTR_NAME) == true
	return t
end
function t.getSpawnPartFromName(p1)
	for v1, v2 in CollectionService:GetTagged(SpawnSelectionConsts.SPAWN_TAG_NAME) do
		if v2.Name == p1 then
			return v2
		end
	end
end
function t.getAllSpawnData()
	local t2 = {}
	for v1, v2 in CollectionService:GetTagged(SpawnSelectionConsts.SPAWN_TAG_NAME) do
		table.insert(t2, t.getSpawnDataFromSpawnPart(v2))
	end
	return t2
end
return t

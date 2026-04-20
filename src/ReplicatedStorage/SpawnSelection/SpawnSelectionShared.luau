local CollectionService_upvr = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Settings_upvr = require(ReplicatedStorage.Resource.Settings)
local SpawnSelectionConsts_upvr = require(ReplicatedStorage.SpawnSelection.SpawnSelectionConsts)
local module_5_upvr = {}
local function _(arg1) -- Line 10, Named "encodeSpawnName"
    return arg1:gsub("[^%w]", "")
end
function module_5_upvr.getPlayerLastSpawnedAt(arg1, arg2) -- Line 13
    local SOME = arg1:FindFirstChild(SpawnSelectionConsts_upvr.SPAWN_TIME_HOLDER_OBJ_NAME)
    if not SOME then
        return 0
    end
    return SOME:GetAttribute(arg2.name:gsub("[^%w]", "")) or 0
end
function module_5_upvr.recordPlayerSpawnedAt(arg1, arg2) -- Line 21
    if not arg1:FindFirstChild(SpawnSelectionConsts_upvr.SPAWN_TIME_HOLDER_OBJ_NAME) then
        local BoolValue = Instance.new("BoolValue")
        BoolValue.Name = SpawnSelectionConsts_upvr.SPAWN_TIME_HOLDER_OBJ_NAME
        BoolValue.Parent = arg1
    end
    BoolValue:SetAttribute(arg2.name:gsub("[^%w]", ""), workspace:GetServerTimeNow())
    return true
end
local PlayerUtils_upvr = require(ReplicatedStorage.Game.PlayerUtils)
local GamepassSystem_upvr = require(ReplicatedStorage.Gamepass.GamepassSystem)
local GamepassUtils_upvr = require(ReplicatedStorage.Gamepass.GamepassUtils)
function module_5_upvr.canPlayerSpawnAt(arg1, arg2) -- Line 33
    if arg2.exclusiveTeamId and not module_5_upvr.isTeamIdSame(PlayerUtils_upvr.getTeamId(arg1), arg2.exclusiveTeamId) then
        return false
    end
    if arg2.exclusiveBoss and not GamepassSystem_upvr.doesPlayerOwnCached(arg1, GamepassUtils_upvr.EnumGamepass.BOSS) then
        return false, {
            gamepassRequired = GamepassUtils_upvr.EnumGamepass.BOSS;
        }
    end
    if arg2.exclusiveSWAT and not GamepassSystem_upvr.doesPlayerOwnCached(arg1, GamepassUtils_upvr.EnumGamepass.SWAT) then
        return false, {
            gamepassRequired = GamepassUtils_upvr.EnumGamepass.SWAT;
        }
    end
    if arg2.exclusiveVIP and not GamepassSystem_upvr.doesPlayerOwnCached(arg1, GamepassUtils_upvr.EnumGamepass.VIP) then
        return false, {
            gamepassRequired = GamepassUtils_upvr.EnumGamepass.VIP;
        }
    end
    local LastDeathPosition = arg1:GetAttribute("LastDeathPosition")
    if LastDeathPosition then
        if typeof(LastDeathPosition) == "Vector3" then
            local Magnitude = ((LastDeathPosition - arg2.position) * Vector3.new(1, 0, 1)).Magnitude
            if Magnitude < 900 then
                return false, {
                    distance = Magnitude;
                }
            end
        end
    end
    local var25 = (SpawnSelectionConsts_upvr.SPAWN_COOLDOWN_TIME) - (workspace:GetServerTimeNow() - module_5_upvr.getPlayerLastSpawnedAt(arg1, arg2))
    if 0 < var25 then
        return false, {
            timeLeft = var25;
        }
    end
    return true
end
function module_5_upvr.isTeamIdSame(arg1, arg2) -- Line 70
    if arg2 == Settings_upvr.EnumTeam.Police and arg1 ~= Settings_upvr.EnumTeam.Police then
        return false
    end
    if arg2 == Settings_upvr.EnumTeam.Prisoner or arg2 == Settings_upvr.EnumTeam.Criminal then
        if arg1 ~= Settings_upvr.EnumTeam.Prisoner and arg1 ~= Settings_upvr.EnumTeam.Criminal then
            return false
        end
    end
    return true
end
function module_5_upvr.getSpawnDataFromSpawnPart(arg1) -- Line 83
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local attribute = arg1:GetAttribute(SpawnSelectionConsts_upvr.SPAWN_EXCLUSIVE_TEAM_NAME_ATTR_NAME)
    local var28
    if attribute then
        if not attribute then
            error("Blank attribute SPAWN_EXCLUSIVE_TEAM_NAME_ATTR_NAME for %s":format(arg1:GetFullName()))
            return false
        end
        var28 = Settings_upvr.EnumTeam[attribute]
    end
    local tbl = {
        name = arg1.Name;
    }
    local Position = arg1.Position
    tbl.position = Position
    tbl.exclusiveTeamId = var28
    if arg1:GetAttribute(SpawnSelectionConsts_upvr.SPAWN_EXCLUSIVE_BOSS_ATTR_NAME) ~= true then
        Position = false
    else
        Position = true
    end
    tbl.exclusiveBoss = Position
    if arg1:GetAttribute(SpawnSelectionConsts_upvr.SPAWN_EXCLUSIVE_SWAT_ATTR_NAME) ~= true then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    tbl.exclusiveSWAT = true
    if arg1:GetAttribute(SpawnSelectionConsts_upvr.SPAWN_EXCLUSIVE_VIP_ATTR_NAME) ~= true then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_5_upvr.getSpawnPartFromName(arg1) -- Line 103
    for _, v in CollectionService_upvr:GetTagged(SpawnSelectionConsts_upvr.SPAWN_TAG_NAME) do
        if v.Name == arg1 then
            return v
        end
    end
end
function module_5_upvr.getAllSpawnData() -- Line 111
    local module_4 = {}
    for _, v_2 in CollectionService_upvr:GetTagged(SpawnSelectionConsts_upvr.SPAWN_TAG_NAME) do
        table.insert(module_4, module_5_upvr.getSpawnDataFromSpawnPart(v_2))
    end
    return module_4
end
return module_5_upvr
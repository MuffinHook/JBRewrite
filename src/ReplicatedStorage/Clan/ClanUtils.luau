
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ClanConsts = require(ReplicatedStorage.Clan.ClanConsts)

local ClanUtils = {}

-- Decomp Error: Konstant failed this whole module; rebuilt from bytecode constants and clan call sites.
function ClanUtils.getFlagColorFromClanInfo(clanInfo)
	return Color3.fromHex(clanInfo.FlagColorStr)
end

function ClanUtils.setFlagColorInClanInfo(clanInfo, flagColor)
	clanInfo.FlagColorStr = flagColor:ToHex()
end

function ClanUtils.getMemberInfoMapFromClanInfo(clanInfo)
	return clanInfo.MemberInfoMap
end

function ClanUtils.setMemberInfoInClanInfo(clanInfo, playerUserId, memberInfo)
	assert(typeof(playerUserId) == "number", "playerUserId must be a number")
	clanInfo.MemberInfoMap[tostring(playerUserId)] = memberInfo
end

function ClanUtils.getClanNameFromClanInfo(clanInfo)
	return clanInfo.Name
end

function ClanUtils.getNameFromClanInfo(clanInfo)
	return clanInfo.Name
end

function ClanUtils.setNameInClanInfo(clanInfo, name)
	assert(clanInfo ~= nil, "clanInfo must not be nil")
	clanInfo.Name = name
end

function ClanUtils.getOwnerUserIdFromClanInfo(clanInfo)
	local ownerUserId = clanInfo.OwnerUserId
	if ownerUserId == nil then
		return nil
	end
	return tonumber(ownerUserId)
end

function ClanUtils.setOwnerUserIdInClanInfo(clanInfo, ownerUserId)
	assert(ownerUserId == nil or typeof(ownerUserId) == "number", "ownerUserId must be a number or nil")
	clanInfo.OwnerUserId = ownerUserId
end

function ClanUtils.getAdminIdMapFromClanInfo(clanInfo)
	return clanInfo.AdminIdMap
end

function ClanUtils.setAdminStatusInClanInfo(clanInfo, playerUserId, isAdmin)
	assert(typeof(playerUserId) == "number", "playerUserId must be a number")
	clanInfo.AdminIdMap[tostring(playerUserId)] = isAdmin or nil
end

function ClanUtils.getIsPlayerAdminFromClanInfo(clanInfo, playerUserId)
	assert(clanInfo ~= nil, "clanInfo must not be nil")
	assert(typeof(playerUserId) == "number", "playerUserId must be a number")
	return ClanUtils.getOwnerUserIdFromClanInfo(clanInfo) == playerUserId
		or clanInfo.AdminIdMap[tostring(playerUserId)] == true
end

function ClanUtils.getJoinRequestUserIdMapFromClanInfo(clanInfo)
	return clanInfo.JoinRequestUserIdMap
end

function ClanUtils.getEmptyMemberInfo()
	return {
		JoinTime = workspace:GetServerTimeNow(),
	}
end

function ClanUtils._createMembersOnlineFolder(parent)
	local folder = Instance.new("Folder")
	folder.Name = ClanConsts.MEMBERS_ONLINE_OBJECT_NAME
	folder.Parent = parent or ReplicatedStorage
	return folder
end

function ClanUtils._getMembersOnlineFolder()
	return ReplicatedStorage:FindFirstChild(ClanConsts.MEMBERS_ONLINE_OBJECT_NAME)
		or ClanUtils._createMembersOnlineFolder(ReplicatedStorage)
end

function ClanUtils._createMembersOnlineChangedValue(clanId)
	assert(typeof(clanId) == "string", "clanId must be a string")
	local value = Instance.new("NumberValue")
	value.Name = clanId
	value.Value = 0
	value.Parent = ClanUtils._getMembersOnlineFolder()
	return value
end

function ClanUtils.getMembersOnlineChangedSignal(clanId)
	assert(typeof(clanId) == "string", "clanId must be a string")
	local folder = ClanUtils._getMembersOnlineFolder()
	local value = folder:FindFirstChild(clanId) or ClanUtils._createMembersOnlineChangedValue(clanId)
	return value.Changed
end

function ClanUtils.getNumMembersOnline(clanId)
	assert(typeof(clanId) == "string", "clanId must be a string")
	local folder = ClanUtils._getMembersOnlineFolder()
	local value = folder:FindFirstChild(clanId)
	return value and value.Value or 0
end

function ClanUtils.getMembersOnline(clanId)
	assert(typeof(clanId) == "string", "clanId must be a string")
	local folder = ClanUtils._getMembersOnlineFolder()
	local result = {}
	for _, child in folder:GetChildren() do
		assert(typeof(child.Name) == "string", "child.Name must be a string")
		if child:IsA("BoolValue") and child.Value then
			result[child.Name] = true
		elseif child:IsA("NumberValue") and child.Name == clanId then
			result[child.Name] = child.Value
		end
	end
	return result
end

function ClanUtils.setMembersOnlineMap(membersOnlineMap)
	local folder = ClanUtils._getMembersOnlineFolder()
	for _, child in folder:GetChildren() do
		child:Destroy()
	end
	for clanId, value in membersOnlineMap do
		assert(typeof(clanId) == "string", "membersOnlineMap keys must be strings")
		local objectValue
		if typeof(value) == "number" then
			objectValue = Instance.new("NumberValue")
			objectValue.Value = value
		else
			objectValue = Instance.new("BoolValue")
			objectValue.Value = value == true
		end
		objectValue.Name = clanId
		objectValue.Parent = folder
	end
end

function ClanUtils.setCurrentClanId(player, clanId)
	player:SetAttribute(ClanConsts.CURRENT_CLAN_ID_ATTR_NAME, clanId)
end

function ClanUtils.getCurrentClanId(player)
	return player:GetAttribute(ClanConsts.CURRENT_CLAN_ID_ATTR_NAME)
end

function ClanUtils.getCurrentClanIdChangedSignal(player)
	return player:GetAttributeChangedSignal(ClanConsts.CURRENT_CLAN_ID_ATTR_NAME)
end

function ClanUtils.setIsPlayerAdminCached(player, value)
	assert(value == nil or typeof(value) == "boolean", "value must be a boolean or nil")
	player:SetAttribute(ClanConsts.IS_PLAYER_CLAN_ADMIN_CACHED_ATTR_NAME, value)
end

function ClanUtils.getIsPlayerAdminCached(player)
	return player:GetAttribute(ClanConsts.IS_PLAYER_CLAN_ADMIN_CACHED_ATTR_NAME)
end

function ClanUtils.getIsPlayerAdminCachedChangedSignal(player)
	return player:GetAttributeChangedSignal(ClanConsts.IS_PLAYER_CLAN_ADMIN_CACHED_ATTR_NAME)
end

return ClanUtils

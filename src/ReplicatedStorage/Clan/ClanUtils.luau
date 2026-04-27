local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ClanConsts = require(ReplicatedStorage.Clan.ClanConsts)
local ClanUtils = {
	getFlagColorFromClanInfo = function(clanInfo)
		if clanInfo.FlagColorStr == nil then
			return nil
		else
			return Color3.fromHex(clanInfo.FlagColorStr)
		end
	end,
	setFlagColorInClanInfo = function(clanInfo, color)
		clanInfo.FlagColorStr = color:ToHex()
	end,
	getMemberInfoMapFromClanInfo = function(clanInfo)
		return clanInfo.MemberInfoMap
	end,
	setMemberInfoInClanInfo = function(clanInfo, playerUserId, memberInfo)
		assert(typeof(playerUserId) == "number", "playerUserId must be a number")
		if memberInfo then
			clanInfo.MemberInfoMap[tostring(playerUserId)] = memberInfo
		else
			clanInfo.MemberInfoMap[tostring(playerUserId)] = nil
		end
	end,
	getClanNameFromClanInfo = function(clanInfo)
		return clanInfo.Name
	end,
	getOwnerUserIdFromClanInfo = function(clanInfo)
		return tonumber(clanInfo.OwnerUserId)
	end,
	setOwnerUserIdInClanInfo = function(clanInfo, ownerUserId)
		assert(typeof(ownerUserId) == "number" or ownerUserId == nil, "ownerUserId must be a number or nil")
		clanInfo.OwnerUserId = ownerUserId
	end,
	setAdminStatusInClanInfo = function(clanInfo, playerUserId, isAdmin)
		assert(typeof(playerUserId) == "number", "playerUserId must be a number")
		clanInfo.AdminIdMap[tostring(playerUserId)] = isAdmin
	end,
	getAdminIdMapFromClanInfo = function(clanInfo)
		return clanInfo.AdminIdMap
	end,
	getNameFromClanInfo = function(clanInfo)
		return clanInfo.Name
	end,
	setNameInClanInfo = function(clanInfo, newName)
		clanInfo.Name = newName
	end
}
function ClanUtils.getIsPlayerAdminFromClanInfo(clanInfo, playerUserId)
	assert(clanInfo ~= nil, "clanInfo must not be nil")
	assert(typeof(playerUserId) == "number", "playerUserId must be a number")
	return ClanUtils.getAdminIdMapFromClanInfo(clanInfo)[tostring(playerUserId)] == true
end
function ClanUtils.getJoinRequestUserIdMapFromClanInfo(clanInfo)
	return clanInfo.JoinRequestUserIdMap
end
function ClanUtils._createMembersOnlineFolder()
	local membersOnlineFolder = Instance.new("Folder")
	membersOnlineFolder.Name = ClanConsts.MEMBERS_ONLINE_OBJECT_NAME
	membersOnlineFolder.Parent = ReplicatedStorage
	return membersOnlineFolder
end
function ClanUtils._createMembersOnlineChangedVal(parentFolder, clanId)
	assert(typeof(clanId) == "string", "clanId must be a string")
	local membersOnlineValue = Instance.new("NumberValue")
	membersOnlineValue.Name = clanId
	membersOnlineValue.Value = 0
	membersOnlineValue.Parent = parentFolder
	return membersOnlineValue
end
function ClanUtils.getNumMembersOnlineChangedSignal(clanId)
	return ClanUtils.getMembersOnlineChangedSignal(clanId)
end
function ClanUtils.getNumMembersOnline(clanId)
	assert(typeof(clanId) == "string", "clanId must be a string")
	local membersOnline = ClanUtils.getMembersOnline(clanId)
	if membersOnline then
		local count = 0
		for _, _ in membersOnline do
			count = count + 1
		end
		return count
	else
		return 0
	end
end
function ClanUtils.getMembersOnlineChangedSignal(clanId)
	assert(typeof(clanId) == "string", "clanId must be a string")
	local membersOnlineFolder = ReplicatedStorage:FindFirstChild(ClanConsts.MEMBERS_ONLINE_OBJECT_NAME)
	if membersOnlineFolder then
		local clanMembersValue = membersOnlineFolder:FindFirstChild(clanId)
		if clanMembersValue then
			return clanMembersValue.Changed
		end
	end
end
function ClanUtils.getMembersOnline(clanId)
	assert(typeof(clanId) == "string", "clanId must be a string")
	local membersOnlineFolder = ReplicatedStorage:FindFirstChild(ClanConsts.MEMBERS_ONLINE_OBJECT_NAME)
	if membersOnlineFolder then
		local clanMembersValue = membersOnlineFolder:FindFirstChild(clanId)
		if clanMembersValue then
			local membersMap = {}
			for _, memberValue in clanMembersValue:GetChildren() do
				membersMap[memberValue.Name] = true
			end
			return membersMap
		end
	end
end
function ClanUtils.setMembersOnlineMap(clanId, membersOnlineMap)
	assert(typeof(clanId) == "string", "clanId must be a string")
	local membersOnlineFolder = ReplicatedStorage:FindFirstChild(ClanConsts.MEMBERS_ONLINE_OBJECT_NAME)
	if not membersOnlineFolder then
		membersOnlineFolder = ClanUtils._createMembersOnlineFolder()
	end
	local clanMembersValue = membersOnlineFolder:FindFirstChild(clanId)
	if not clanMembersValue then
		clanMembersValue = ClanUtils._createMembersOnlineChangedVal(membersOnlineFolder, clanId)
	end
	local newMembersMap = membersOnlineMap or {}
	for _, memberValue in clanMembersValue:GetChildren() do
		local memberName = typeof(memberValue.Name) == "string"
		assert(memberName, "child.Name must be a string")
		if not newMembersMap[memberValue.Name] then
			memberValue:Destroy()
		end
	end
	for memberUserId, _ in newMembersMap do
		assert(typeof(memberUserId) == "string", "membersOnlineMap keys must be strings")
	end
	for memberUserId, _ in newMembersMap do
		if not clanMembersValue:FindFirstChild(memberUserId) then
			local memberBoolValue = Instance.new("BoolValue")
			memberBoolValue.Name = memberUserId
			memberBoolValue.Value = true
			memberBoolValue.Parent = clanMembersValue
		end
	end
	clanMembersValue.Value = clanMembersValue.Value + 1
end
function ClanUtils.getCurrentClanIdChangedSignal(player)
	return player:GetAttributeChangedSignal(ClanConsts.CURRENT_CLAN_ID_ATTR_NAME)
end
function ClanUtils.setCurrentClanId(player, clanId)
	assert(typeof(clanId) == "string" or clanId == nil, "clanId must be a string")
	player:SetAttribute(ClanConsts.CURRENT_CLAN_ID_ATTR_NAME, clanId)
end
function ClanUtils.getCurrentClanId(player)
	return player:GetAttribute(ClanConsts.CURRENT_CLAN_ID_ATTR_NAME)
end
function ClanUtils.setIsPlayerAdminCached(player, value)
	assert(typeof(value) == "boolean" or value == nil, "value must be a boolean or nil")
	player:SetAttribute(ClanConsts.IS_PLAYER_CLAN_ADMIN_CACHED_ATTR_NAME, value)
end
function ClanUtils.getIsPlayerAdminCached(player)
	return player:GetAttribute(ClanConsts.IS_PLAYER_CLAN_ADMIN_CACHED_ATTR_NAME)
end
function ClanUtils.getIsPlayerAdminCachedChangedSignal(player)
	return player:GetAttributeChangedSignal(ClanConsts.IS_PLAYER_CLAN_ADMIN_CACHED_ATTR_NAME)
end
function ClanUtils.getEmptyMemberInfo()
	return {
		JoinTime = workspace:GetServerTimeNow()
	}
end
return ClanUtils

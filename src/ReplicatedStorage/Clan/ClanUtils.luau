local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ClanConsts = require(ReplicatedStorage.Clan.ClanConsts)
local t = {
	getFlagColorFromClanInfo = function(p1) --[[ Name: getFlagColorFromClanInfo | Line: 6 ]]
		if p1.FlagColorStr == nil then
			return nil
		else
			return Color3.fromHex(p1.FlagColorStr)
		end
	end,
	setFlagColorInClanInfo = function(p1, p2) --[[ Name: setFlagColorInClanInfo | Line: 9 ]]
		p1.FlagColorStr = p2:ToHex()
	end,
	getMemberInfoMapFromClanInfo = function(p1) --[[ Name: getMemberInfoMapFromClanInfo | Line: 12 ]]
		return p1.MemberInfoMap
	end,
	setMemberInfoInClanInfo = function(p1, p2, p3) --[[ Name: setMemberInfoInClanInfo | Line: 15 ]]
		assert(typeof(p2) == "number", "playerUserId must be a number")
		if p3 then
			p1.MemberInfoMap[tostring(p2)] = p3
		else
			p1.MemberInfoMap[tostring(p2)] = nil
		end
	end,
	getClanNameFromClanInfo = function(p1) --[[ Name: getClanNameFromClanInfo | Line: 27 ]]
		return p1.Name
	end,
	getOwnerUserIdFromClanInfo = function(p1) --[[ Name: getOwnerUserIdFromClanInfo | Line: 30 ]]
		return tonumber(p1.OwnerUserId)
	end,
	setOwnerUserIdInClanInfo = function(p1, p2) --[[ Name: setOwnerUserIdInClanInfo | Line: 33 ]]
		assert(typeof(p2) == "number" or p2 == nil, "ownerUserId must be a number or nil")
		p1.OwnerUserId = p2
	end,
	setAdminStatusInClanInfo = function(p1, p2, p3) --[[ Name: setAdminStatusInClanInfo | Line: 39 ]]
		assert(typeof(p2) == "number", "playerUserId must be a number")
		p1.AdminIdMap[tostring(p2)] = p3
	end,
	getAdminIdMapFromClanInfo = function(p1) --[[ Name: getAdminIdMapFromClanInfo | Line: 44 ]]
		return p1.AdminIdMap
	end,
	getNameFromClanInfo = function(p1) --[[ Name: getNameFromClanInfo | Line: 47 ]]
		return p1.Name
	end,
	setNameInClanInfo = function(p1, p2) --[[ Name: setNameInClanInfo | Line: 50 ]]
		p1.Name = p2
	end
}
function t.getIsPlayerAdminFromClanInfo(p1, p2) --[[ Line: 53 | Upvalues: t (copy) ]]
	assert(p1 ~= nil, "clanInfo must not be nil")
	assert(typeof(p2) == "number", "playerUserId must be a number")
	return t.getAdminIdMapFromClanInfo(p1)[tostring(p2)] == true
end
function t.getJoinRequestUserIdMapFromClanInfo(p1) --[[ Line: 58 ]]
	return p1.JoinRequestUserIdMap
end
function t._createMembersOnlineFolder() --[[ Line: 61 | Upvalues: ClanConsts (copy), ReplicatedStorage (copy) ]]
	local v1 = Instance.new("Folder")
	v1.Name = ClanConsts.MEMBERS_ONLINE_OBJECT_NAME
	v1.Parent = ReplicatedStorage
	return v1
end
function t._createMembersOnlineChangedVal(p1, p2) --[[ Line: 67 ]]
	assert(typeof(p2) == "string", "clanId must be a string")
	local v2 = Instance.new("NumberValue")
	v2.Name = p2
	v2.Value = 0
	v2.Parent = p1
	return v2
end
function t.getNumMembersOnlineChangedSignal(p1) --[[ Line: 76 | Upvalues: t (copy) ]]
	return t.getMembersOnlineChangedSignal(p1)
end
function t.getNumMembersOnline(p1) --[[ Line: 79 | Upvalues: t (copy) ]]
	assert(typeof(p1) == "string", "clanId must be a string")
	local v2 = t.getMembersOnline(p1)
	if v2 then
		local count = 0
		for v3, v4 in v2 do
			count = count + 1
		end
		return count
	else
		return 0
	end
end
function t.getMembersOnlineChangedSignal(p1) --[[ Line: 91 | Upvalues: ReplicatedStorage (copy), ClanConsts (copy) ]]
	assert(typeof(p1) == "string", "clanId must be a string")
	local v2 = ReplicatedStorage:FindFirstChild(ClanConsts.MEMBERS_ONLINE_OBJECT_NAME)
	if v2 then
		local v3 = v2:FindFirstChild(p1)
		if v3 then
			return v3.Changed
		end
	end
end
function t.getMembersOnline(p1) --[[ Line: 104 | Upvalues: ReplicatedStorage (copy), ClanConsts (copy) ]]
	assert(typeof(p1) == "string", "clanId must be a string")
	local v2 = ReplicatedStorage:FindFirstChild(ClanConsts.MEMBERS_ONLINE_OBJECT_NAME)
	if v2 then
		local v3 = v2:FindFirstChild(p1)
		if v3 then
			local t = {}
			for v4, v5 in v3:GetChildren() do
				t[v5.Name] = true
			end
			return t
		end
	end
end
function t.setMembersOnlineMap(p1, p2) --[[ Line: 121 | Upvalues: ReplicatedStorage (copy), ClanConsts (copy), t (copy) ]]
	assert(typeof(p1) == "string", "clanId must be a string")
	local v2 = ReplicatedStorage:FindFirstChild(ClanConsts.MEMBERS_ONLINE_OBJECT_NAME)
	if not v2 then
		v2 = t._createMembersOnlineFolder()
	end
	local v4 = v2:FindFirstChild(p1)
	if not v4 then
		v4 = t._createMembersOnlineChangedVal(v2, p1)
	end
	local v7 = p2 or {}
	for v9, v10 in v4:GetChildren() do
		local v8
		v8 = typeof(v10.Name) == "string"
		assert(v8, "child.Name must be a string")
		if not v7[v10.Name] then
			v10:Destroy()
		end
	end
	for v12, v13 in v7 do
		assert(typeof(v12) == "string", "membersOnlineMap keys must be strings")
	end
	for v15, v16 in v7 do
		if not v4:FindFirstChild(v15) then
			local v17 = Instance.new("BoolValue")
			v17.Name = v15
			v17.Value = true
			v17.Parent = v4
		end
	end
	v4.Value = v4.Value + 1
end
function t.getCurrentClanIdChangedSignal(p1) --[[ Line: 155 | Upvalues: ClanConsts (copy) ]]
	return p1:GetAttributeChangedSignal(ClanConsts.CURRENT_CLAN_ID_ATTR_NAME)
end
function t.setCurrentClanId(p1, p2) --[[ Line: 158 | Upvalues: ClanConsts (copy) ]]
	assert(typeof(p2) == "string" or p2 == nil, "clanId must be a string")
	p1:SetAttribute(ClanConsts.CURRENT_CLAN_ID_ATTR_NAME, p2)
end
function t.getCurrentClanId(p1) --[[ Line: 163 | Upvalues: ClanConsts (copy) ]]
	return p1:GetAttribute(ClanConsts.CURRENT_CLAN_ID_ATTR_NAME)
end
function t.setIsPlayerAdminCached(p1, p2) --[[ Line: 166 | Upvalues: ClanConsts (copy) ]]
	assert(typeof(p2) == "boolean" or p2 == nil, "value must be a boolean or nil")
	p1:SetAttribute(ClanConsts.IS_PLAYER_CLAN_ADMIN_CACHED_ATTR_NAME, p2)
end
function t.getIsPlayerAdminCached(p1) --[[ Line: 171 | Upvalues: ClanConsts (copy) ]]
	return p1:GetAttribute(ClanConsts.IS_PLAYER_CLAN_ADMIN_CACHED_ATTR_NAME)
end
function t.getIsPlayerAdminCachedChangedSignal(p1) --[[ Line: 174 | Upvalues: ClanConsts (copy) ]]
	return p1:GetAttributeChangedSignal(ClanConsts.IS_PLAYER_CLAN_ADMIN_CACHED_ATTR_NAME)
end
function t.getEmptyMemberInfo() --[[ Line: 177 ]]
	return {
		JoinTime = workspace:GetServerTimeNow()
	}
end
return t
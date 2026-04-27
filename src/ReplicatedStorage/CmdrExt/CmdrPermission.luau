local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local RunConsts = require(ReplicatedStorage.App.RunConsts)
local adminUserIds = { 606723718, 2837719, 2025110 }
local vipOpUserIds = { 174178041, 5613127327, 820499, 75308445, 55124844, 2235908458, 391034465 }
local permissionsTable = {
	Help = true,
	UserAlias = true
}
local qaGroupConfig = {
	groupId = 3059674,
	minRank = 253
}
local devStudioGroupConfig = {
	groupId = 5770760,
	minRank = 100
}
if RunUtils.getEnv() == RunConsts.QA_NAME or (RunUtils.getEnv() == RunConsts.DEV_NAME or RunUtils.getEnv() == RunConsts.STUDIO_NAME) then
	permissionsTable.DefaultAdmin = devStudioGroupConfig
	permissionsTable.Op = {
		vipOwner = true,
		op = true,
		groupId = devStudioGroupConfig.groupId,
		minRank = devStudioGroupConfig.minRank,
		userIds = vipOpUserIds
	}
	permissionsTable.DefaultDebug = devStudioGroupConfig
	permissionsTable.DefaultUtil = devStudioGroupConfig
	permissionsTable.VipOwner = {
		vipOwner = true,
		groupId = devStudioGroupConfig.groupId,
		minRank = devStudioGroupConfig.minRank
	}
	permissionsTable.Moderator = {
		groupId = devStudioGroupConfig.groupId,
		minRank = devStudioGroupConfig.minRank,
		userIds = vipOpUserIds
	}
else
	permissionsTable.DefaultAdmin = {
		userIds = adminUserIds
	}
	permissionsTable.Op = {
		vipOwner = true,
		op = true,
		groupId = qaGroupConfig.groupId,
		minRank = qaGroupConfig.minRank,
		userIds = vipOpUserIds
	}
	permissionsTable.DefaultDebug = qaGroupConfig
	permissionsTable.DefaultUtil = qaGroupConfig
	permissionsTable.VipOwner = {
		vipOwner = true,
		groupId = qaGroupConfig.groupId,
		minRank = qaGroupConfig.minRank
	}
	permissionsTable.Moderator = {
		groupId = qaGroupConfig.groupId,
		minRank = qaGroupConfig.minRank,
		userIds = vipOpUserIds
	}
end
function permissionsTable.isOp(player)
	return ReplicatedStorage:FindFirstChild("OpList"):FindFirstChild(player.UserId) ~= nil
end
function permissionsTable.groupAllowed(player, groupName)
	assert(player ~= nil, "player missing")
	assert(player.Parent == game:GetService("Players"), "player is not a Player")
	assert(groupName ~= nil, "group missing")
	assert(typeof(groupName) == "string", "group must be a string")
	if RunUtils.isStudio() then
		return true
	else
		local groupConfig = permissionsTable[groupName]
		if groupConfig and typeof(groupConfig) == "boolean" then
			return true
		elseif groupConfig and typeof(groupConfig) == "table" then
			if groupConfig.vipOwner then
				local VipOwnerId = ReplicatedStorage:FindFirstChild("VipOwnerId")
				if VipOwnerId then
					assert(VipOwnerId.Value > 0, "vipOwnerId not > 0")
					if player.UserId == VipOwnerId.Value or (groupConfig.op and permissionsTable.isOp(player) or groupConfig.userIds and table.find(groupConfig.userIds, player.UserId)) then
						return true
					elseif groupConfig.groupId then
						if groupConfig.minRank then
							if player:GetRankInGroup(groupConfig.groupId) >= groupConfig.minRank then
								return true
							else
								return false
							end
						elseif player:IsInGroup(groupConfig.groupId) then
							return true
						else
							return false
						end
					else
						return false
					end
				elseif groupConfig.op and permissionsTable.isOp(player) or groupConfig.userIds and table.find(groupConfig.userIds, player.UserId) then
					return true
				elseif groupConfig.groupId then
					if groupConfig.minRank then
						if player:GetRankInGroup(groupConfig.groupId) >= groupConfig.minRank then
							return true
						else
							return false
						end
					elseif player:IsInGroup(groupConfig.groupId) then
						return true
					else
						return false
					end
				else
					return false
				end
			elseif groupConfig.op and permissionsTable.isOp(player) or groupConfig.userIds and table.find(groupConfig.userIds, player.UserId) then
				return true
			elseif groupConfig.groupId then
				if groupConfig.minRank then
					if player:GetRankInGroup(groupConfig.groupId) >= groupConfig.minRank then
						return true
					else
						return false
					end
				elseif player:IsInGroup(groupConfig.groupId) then
					return true
				else
					return false
				end
			else
				return false
			end
		else
			return false
		end
	end
end
return permissionsTable

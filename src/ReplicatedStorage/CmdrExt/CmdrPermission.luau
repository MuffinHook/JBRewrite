-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local RunConsts = require(ReplicatedStorage.App.RunConsts)
local t = { 606723718, 2837719, 2025110 }
local t2 = { 174178041, 5613127327, 820499, 75308445, 55124844, 2235908458, 391034465 }
local t3 = {
	Help = true,
	UserAlias = true
}
local t4 = {
	groupId = 3059674,
	minRank = 253
}
local t5 = {
	groupId = 5770760,
	minRank = 100
}
if RunUtils.getEnv() == RunConsts.QA_NAME or (RunUtils.getEnv() == RunConsts.DEV_NAME or RunUtils.getEnv() == RunConsts.STUDIO_NAME) then
	t3.DefaultAdmin = t5
	t3.Op = {
		vipOwner = true,
		op = true,
		groupId = t5.groupId,
		minRank = t5.minRank,
		userIds = t2
	}
	t3.DefaultDebug = t5
	t3.DefaultUtil = t5
	t3.VipOwner = {
		vipOwner = true,
		groupId = t5.groupId,
		minRank = t5.minRank
	}
	t3.Moderator = {
		groupId = t5.groupId,
		minRank = t5.minRank,
		userIds = t2
	}
else
	t3.DefaultAdmin = {
		userIds = t
	}
	t3.Op = {
		vipOwner = true,
		op = true,
		groupId = t4.groupId,
		minRank = t4.minRank,
		userIds = t2
	}
	t3.DefaultDebug = t4
	t3.DefaultUtil = t4
	t3.VipOwner = {
		vipOwner = true,
		groupId = t4.groupId,
		minRank = t4.minRank
	}
	t3.Moderator = {
		groupId = t4.groupId,
		minRank = t4.minRank,
		userIds = t2
	}
end
function t3.isOp(p1)
	return ReplicatedStorage:FindFirstChild("OpList"):FindFirstChild(p1.UserId) ~= nil
end
function t3.groupAllowed(p1, p2)
	assert(p1 ~= nil, "player missing")
	assert(p1.Parent == game:GetService("Players"), "player is not a Player")
	assert(p2 ~= nil, "group missing")
	assert(typeof(p2) == "string", "group must be a string")
	if RunUtils.isStudio() then
		return true
	else
		local v5 = t3[p2]
		if v5 and typeof(v5) == "boolean" then
			return true
		elseif v5 and typeof(v5) == "table" then
			if v5.vipOwner then
				local VipOwnerId = ReplicatedStorage:FindFirstChild("VipOwnerId")
				if VipOwnerId then
					assert(VipOwnerId.Value > 0, "vipOwnerId not > 0")
					if p1.UserId == VipOwnerId.Value or (v5.op and t3.isOp(p1) or v5.userIds and table.find(v5.userIds, p1.UserId)) then
						return true
					elseif v5.groupId then
						if v5.minRank then
							if p1:GetRankInGroup(v5.groupId) >= v5.minRank then
								return true
							else
								return false
							end
						elseif p1:IsInGroup(v5.groupId) then
							return true
						else
							return false
						end
					else
						return false
					end
				elseif v5.op and t3.isOp(p1) or v5.userIds and table.find(v5.userIds, p1.UserId) then
					return true
				elseif v5.groupId then
					if v5.minRank then
						if p1:GetRankInGroup(v5.groupId) >= v5.minRank then
							return true
						else
							return false
						end
					elseif p1:IsInGroup(v5.groupId) then
						return true
					else
						return false
					end
				else
					return false
				end
			elseif v5.op and t3.isOp(p1) or v5.userIds and table.find(v5.userIds, p1.UserId) then
				return true
			elseif v5.groupId then
				if v5.minRank then
					if p1:GetRankInGroup(v5.groupId) >= v5.minRank then
						return true
					else
						return false
					end
				elseif p1:IsInGroup(v5.groupId) then
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
return t3

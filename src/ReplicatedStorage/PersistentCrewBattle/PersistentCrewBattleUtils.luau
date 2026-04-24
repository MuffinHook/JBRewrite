-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PersistentCrewBattleConsts = require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleConsts)
local t = {
	getBattleServerInitTime = function()
		return ReplicatedStorage:GetAttribute(PersistentCrewBattleConsts.BATTLE_SERVER_INIT_TIME_ATTR_NAME)
	end,
	setBattleServerInitTime = function(self)
		return ReplicatedStorage:SetAttribute(PersistentCrewBattleConsts.BATTLE_SERVER_INIT_TIME_ATTR_NAME, self)
	end,
	getRoundStartsAt = function()
		return ReplicatedStorage:GetAttribute(PersistentCrewBattleConsts.ROUND_STARTS_AT_ATTR_NAME)
	end,
	setRoundStartsAt = function(self)
		ReplicatedStorage:SetAttribute(PersistentCrewBattleConsts.ROUND_STARTS_AT_ATTR_NAME, self)
	end,
	getRoundStartsAtAttributeChangedSignal = function()
		return ReplicatedStorage:GetAttributeChangedSignal(PersistentCrewBattleConsts.ROUND_STARTS_AT_ATTR_NAME)
	end,
	getCrewStartTime = function(self)
		return self:GetAttribute(PersistentCrewBattleConsts.ROUND_START_ATTR_NAME)
	end,
	setCrewStartTime = function(self, arg2)
		self:SetAttribute(PersistentCrewBattleConsts.ROUND_START_ATTR_NAME, arg2)
	end,
	getCrewPenaltyDuration = function(self)
		return self:GetAttribute(PersistentCrewBattleConsts.ROUND_PENALTY_DURATION_ATTR_NAME)
	end,
	setCrewPenaltyDuration = function(self, arg2)
		self:SetAttribute(PersistentCrewBattleConsts.ROUND_PENALTY_DURATION_ATTR_NAME, arg2)
	end
}
function t.getCrewDurationElapsed(self)
	local local1 = t.getCrewStartTime(self)
	return workspace:GetServerTimeNow() - local1
end
function t.getCrewEffectiveDurationElapsed(self)
	local local1 = t.getCrewPenaltyDuration(self)
	return t.getCrewDurationElapsed(self) + local1
end
function t.getCrewTimeTook(self)
	return self:GetAttribute(PersistentCrewBattleConsts.ROUND_TIME_TOOK_ATTR_NAME)
end
function t.setCrewRoundTimeTook(self, arg2)
	self:SetAttribute(PersistentCrewBattleConsts.ROUND_TIME_TOOK_ATTR_NAME, arg2)
end
function t.getCrewRoundRobberiesDone(self)
	return self:GetAttribute(PersistentCrewBattleConsts.ROUND_ROBBERIES_DONE_ATTR_NAME)
end
function t.setCrewRoundRobberiesDone(self, arg2)
	self:SetAttribute(PersistentCrewBattleConsts.ROUND_ROBBERIES_DONE_ATTR_NAME, arg2)
end
function t.getAttackingCrewStartTime()
	return t.getCrewStartTime(t.getAttackingCrewObj())
end
function t.setAttackingCrewStartTime(self)
	t.setCrewStartTime(t.getAttackingCrewObj(), self)
end
function t.getAttackingCrewPenaltyDuration()
	return t.getCrewPenaltyDuration(t.getAttackingCrewObj())
end
function t.setAttackingCrewPenaltyDuration(self)
	t.setCrewPenaltyDuration(t.getAttackingCrewObj(), self)
end
function t.getAttackingCrewEffectiveDurationElapsed()
	return t.getCrewEffectiveDurationElapsed(t.getAttackingCrewObj())
end
function t.getAllCrewBattleDataObj()
	return ReplicatedStorage:FindFirstChild(PersistentCrewBattleConsts.ALL_CREW_BATTLE_DATA_OBJ_NAME)
end
function t.getAttackingClanId()
	return t.getAllCrewBattleDataObj():GetAttribute(PersistentCrewBattleConsts.ATTACKING_CLAN_ID)
end
function t.getAttackingClanIdChangedSignal()
	return t.getAllCrewBattleDataObj():GetAttributeChangedSignal(PersistentCrewBattleConsts.ATTACKING_CLAN_ID)
end
function t.setAttackingClanId(self)
	t.getAllCrewBattleDataObj():SetAttribute(PersistentCrewBattleConsts.ATTACKING_CLAN_ID, self)
end
function t.getCrewObjFromClanId(self)
	assert(self ~= nil, "clanId cannot be nil")
	return t.getAllCrewBattleDataObj():FindFirstChild(self)
end
function t.getAttackingCrewObj()
	return t.getCrewObjFromClanId(t.getAttackingClanId())
end
function t.getClanBattleInfoFromClanData(self, arg2)
	if self then
		local local1 = nil
		if arg2 then
			return self.AllTimeClanBattleInfo
		else
			if self.SeasonClanBattleInfo then
				local1 = self.SeasonClanBattleInfo[tostring(PersistentCrewBattleConsts.CURR_CREW_BATTLE_SEASON)]
			end
			return local1
		end
	else
		return nil
	end
end
function t.validateClanRatingData(self)
	local local1, local2 = pcall(function()
		if self then
			assert(if typeof(self.Rating) == "number" then self.Rating > 0 else false, "Invalid Rating")
			assert(if typeof(self.RatingDeviation) == "number" then self.RatingDeviation > 0 else false, "Invalid RatingDeviation")
			assert(if typeof(self.Sigma) == "number" then self.Sigma > 0 else false, "Invalid Sigma")
			assert(if typeof(self.LastBattle) == "number" then self.LastBattle > 0 else false, "Invalid LastBattle")
		end
	end)
	if not local1 then
		warn(local2)
	end
	return local1
end
function t.getDefaultRatingData()
	local table2 = {
		Rating = PersistentCrewBattleConsts.DEFAULT_RATING,
		RatingDeviation = PersistentCrewBattleConsts.DEFAULT_RATING_DEVIATION,
		Sigma = PersistentCrewBattleConsts.DEFAULT_SIGMA_GRINDSET,
		LastBattle = workspace:GetServerTimeNow()
	}
	t.validateClanRatingData(table2)
	return table2
end
function t.getDisplayRatingFromClanBattleInfo(self)
	local local1 = self and self.RatingData
	if not local1 then
		local1 = t.getDefaultRatingData()
	end
	local local4 = tostring((math.floor(local1.Rating)))
	if not self or (not self.BattlesPlayed or self.BattlesPlayed < PersistentCrewBattleConsts.NUM_PROVISIONAL_RATING_BATTLES) then
		local4 = local4 .. "?"
	end
	return local4
end
function t.calculateWLRatio(self, arg2)
	if self and arg2 and arg2 > 0 then
		if arg2 - self == 0 then
			return "\226\136\158"
		else
			return string.format("%.2f", self / (arg2 - self))
		end
	else
		return nil
	end
end
return t

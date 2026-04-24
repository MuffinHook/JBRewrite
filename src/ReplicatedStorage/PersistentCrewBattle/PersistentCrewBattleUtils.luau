-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PersistentCrewBattleConsts = require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleConsts)
local t = {
	getBattleServerInitTime = function()
		return ReplicatedStorage:GetAttribute(PersistentCrewBattleConsts.BATTLE_SERVER_INIT_TIME_ATTR_NAME)
	end,
	setBattleServerInitTime = function(p1)
		return ReplicatedStorage:SetAttribute(PersistentCrewBattleConsts.BATTLE_SERVER_INIT_TIME_ATTR_NAME, p1)
	end,
	getRoundStartsAt = function()
		return ReplicatedStorage:GetAttribute(PersistentCrewBattleConsts.ROUND_STARTS_AT_ATTR_NAME)
	end,
	setRoundStartsAt = function(p1)
		ReplicatedStorage:SetAttribute(PersistentCrewBattleConsts.ROUND_STARTS_AT_ATTR_NAME, p1)
	end,
	getRoundStartsAtAttributeChangedSignal = function()
		return ReplicatedStorage:GetAttributeChangedSignal(PersistentCrewBattleConsts.ROUND_STARTS_AT_ATTR_NAME)
	end,
	getCrewStartTime = function(p1)
		return p1:GetAttribute(PersistentCrewBattleConsts.ROUND_START_ATTR_NAME)
	end,
	setCrewStartTime = function(p1, p2)
		p1:SetAttribute(PersistentCrewBattleConsts.ROUND_START_ATTR_NAME, p2)
	end,
	getCrewPenaltyDuration = function(p1)
		return p1:GetAttribute(PersistentCrewBattleConsts.ROUND_PENALTY_DURATION_ATTR_NAME)
	end,
	setCrewPenaltyDuration = function(p1, p2)
		p1:SetAttribute(PersistentCrewBattleConsts.ROUND_PENALTY_DURATION_ATTR_NAME, p2)
	end
}
function t.getCrewDurationElapsed(p1)
	local v1 = t.getCrewStartTime(p1)
	return workspace:GetServerTimeNow() - v1
end
function t.getCrewEffectiveDurationElapsed(p1)
	local v1 = t.getCrewPenaltyDuration(p1)
	return t.getCrewDurationElapsed(p1) + v1
end
function t.getCrewTimeTook(p1)
	return p1:GetAttribute(PersistentCrewBattleConsts.ROUND_TIME_TOOK_ATTR_NAME)
end
function t.setCrewRoundTimeTook(p1, p2)
	p1:SetAttribute(PersistentCrewBattleConsts.ROUND_TIME_TOOK_ATTR_NAME, p2)
end
function t.getCrewRoundRobberiesDone(p1)
	return p1:GetAttribute(PersistentCrewBattleConsts.ROUND_ROBBERIES_DONE_ATTR_NAME)
end
function t.setCrewRoundRobberiesDone(p1, p2)
	p1:SetAttribute(PersistentCrewBattleConsts.ROUND_ROBBERIES_DONE_ATTR_NAME, p2)
end
function t.getAttackingCrewStartTime()
	return t.getCrewStartTime(t.getAttackingCrewObj())
end
function t.setAttackingCrewStartTime(p1)
	t.setCrewStartTime(t.getAttackingCrewObj(), p1)
end
function t.getAttackingCrewPenaltyDuration()
	return t.getCrewPenaltyDuration(t.getAttackingCrewObj())
end
function t.setAttackingCrewPenaltyDuration(p1)
	t.setCrewPenaltyDuration(t.getAttackingCrewObj(), p1)
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
function t.setAttackingClanId(p1)
	t.getAllCrewBattleDataObj():SetAttribute(PersistentCrewBattleConsts.ATTACKING_CLAN_ID, p1)
end
function t.getCrewObjFromClanId(p1)
	assert(p1 ~= nil, "clanId cannot be nil")
	return t.getAllCrewBattleDataObj():FindFirstChild(p1)
end
function t.getAttackingCrewObj()
	return t.getCrewObjFromClanId(t.getAttackingClanId())
end
function t.getClanBattleInfoFromClanData(p1, p2)
	if p1 then
		local v1 = nil
		if p2 then
			return p1.AllTimeClanBattleInfo
		else
			if p1.SeasonClanBattleInfo then
				v1 = p1.SeasonClanBattleInfo[tostring(PersistentCrewBattleConsts.CURR_CREW_BATTLE_SEASON)]
			end
			return v1
		end
	else
		return nil
	end
end
function t.validateClanRatingData(p1)
	local v1, v2 = pcall(function()
		if p1 then
			assert(if typeof(p1.Rating) == "number" then p1.Rating > 0 else false, "Invalid Rating")
			assert(if typeof(p1.RatingDeviation) == "number" then p1.RatingDeviation > 0 else false, "Invalid RatingDeviation")
			assert(if typeof(p1.Sigma) == "number" then p1.Sigma > 0 else false, "Invalid Sigma")
			assert(if typeof(p1.LastBattle) == "number" then p1.LastBattle > 0 else false, "Invalid LastBattle")
		end
	end)
	if not v1 then
		warn(v2)
	end
	return v1
end
function t.getDefaultRatingData()
	local t2 = {
		Rating = PersistentCrewBattleConsts.DEFAULT_RATING,
		RatingDeviation = PersistentCrewBattleConsts.DEFAULT_RATING_DEVIATION,
		Sigma = PersistentCrewBattleConsts.DEFAULT_SIGMA_GRINDSET,
		LastBattle = workspace:GetServerTimeNow()
	}
	t.validateClanRatingData(t2)
	return t2
end
function t.getDisplayRatingFromClanBattleInfo(p1)
	local v1 = p1 and p1.RatingData
	if not v1 then
		v1 = t.getDefaultRatingData()
	end
	local v4 = tostring((math.floor(v1.Rating)))
	if not p1 or (not p1.BattlesPlayed or p1.BattlesPlayed < PersistentCrewBattleConsts.NUM_PROVISIONAL_RATING_BATTLES) then
		v4 = v4 .. "?"
	end
	return v4
end
function t.calculateWLRatio(p1, p2)
	if p1 and p2 and p2 > 0 then
		if p2 - p1 == 0 then
			return "\226\136\158"
		else
			return string.format("%.2f", p1 / (p2 - p1))
		end
	else
		return nil
	end
end
return t

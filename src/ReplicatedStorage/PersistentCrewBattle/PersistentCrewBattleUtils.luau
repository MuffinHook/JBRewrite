local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PersistentCrewBattleConsts = require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleConsts)
local t = {
	getBattleServerInitTime = function() --[[ Name: getBattleServerInitTime | Line: 6 | Upvalues: ReplicatedStorage (copy), PersistentCrewBattleConsts (copy) ]]
		return ReplicatedStorage:GetAttribute(PersistentCrewBattleConsts.BATTLE_SERVER_INIT_TIME_ATTR_NAME)
	end,
	setBattleServerInitTime = function(p1) --[[ Name: setBattleServerInitTime | Line: 9 | Upvalues: ReplicatedStorage (copy), PersistentCrewBattleConsts (copy) ]]
		return ReplicatedStorage:SetAttribute(PersistentCrewBattleConsts.BATTLE_SERVER_INIT_TIME_ATTR_NAME, p1)
	end,
	getRoundStartsAt = function() --[[ Name: getRoundStartsAt | Line: 12 | Upvalues: ReplicatedStorage (copy), PersistentCrewBattleConsts (copy) ]]
		return ReplicatedStorage:GetAttribute(PersistentCrewBattleConsts.ROUND_STARTS_AT_ATTR_NAME)
	end,
	setRoundStartsAt = function(p1) --[[ Name: setRoundStartsAt | Line: 15 | Upvalues: ReplicatedStorage (copy), PersistentCrewBattleConsts (copy) ]]
		ReplicatedStorage:SetAttribute(PersistentCrewBattleConsts.ROUND_STARTS_AT_ATTR_NAME, p1)
	end,
	getRoundStartsAtAttributeChangedSignal = function() --[[ Name: getRoundStartsAtAttributeChangedSignal | Line: 18 | Upvalues: ReplicatedStorage (copy), PersistentCrewBattleConsts (copy) ]]
		return ReplicatedStorage:GetAttributeChangedSignal(PersistentCrewBattleConsts.ROUND_STARTS_AT_ATTR_NAME)
	end,
	getCrewStartTime = function(p1) --[[ Name: getCrewStartTime | Line: 21 | Upvalues: PersistentCrewBattleConsts (copy) ]]
		return p1:GetAttribute(PersistentCrewBattleConsts.ROUND_START_ATTR_NAME)
	end,
	setCrewStartTime = function(p1, p2) --[[ Name: setCrewStartTime | Line: 24 | Upvalues: PersistentCrewBattleConsts (copy) ]]
		p1:SetAttribute(PersistentCrewBattleConsts.ROUND_START_ATTR_NAME, p2)
	end,
	getCrewPenaltyDuration = function(p1) --[[ Name: getCrewPenaltyDuration | Line: 27 | Upvalues: PersistentCrewBattleConsts (copy) ]]
		return p1:GetAttribute(PersistentCrewBattleConsts.ROUND_PENALTY_DURATION_ATTR_NAME)
	end,
	setCrewPenaltyDuration = function(p1, p2) --[[ Name: setCrewPenaltyDuration | Line: 30 | Upvalues: PersistentCrewBattleConsts (copy) ]]
		p1:SetAttribute(PersistentCrewBattleConsts.ROUND_PENALTY_DURATION_ATTR_NAME, p2)
	end
}
function t.getCrewDurationElapsed(p1) --[[ Line: 33 | Upvalues: t (copy) ]]
	local v1 = t.getCrewStartTime(p1)
	return workspace:GetServerTimeNow() - v1
end
function t.getCrewEffectiveDurationElapsed(p1) --[[ Line: 37 | Upvalues: t (copy) ]]
	local v1 = t.getCrewPenaltyDuration(p1)
	return t.getCrewDurationElapsed(p1) + v1
end
function t.getCrewTimeTook(p1) --[[ Line: 41 | Upvalues: PersistentCrewBattleConsts (copy) ]]
	return p1:GetAttribute(PersistentCrewBattleConsts.ROUND_TIME_TOOK_ATTR_NAME)
end
function t.setCrewRoundTimeTook(p1, p2) --[[ Line: 44 | Upvalues: PersistentCrewBattleConsts (copy) ]]
	p1:SetAttribute(PersistentCrewBattleConsts.ROUND_TIME_TOOK_ATTR_NAME, p2)
end
function t.getCrewRoundRobberiesDone(p1) --[[ Line: 47 | Upvalues: PersistentCrewBattleConsts (copy) ]]
	return p1:GetAttribute(PersistentCrewBattleConsts.ROUND_ROBBERIES_DONE_ATTR_NAME)
end
function t.setCrewRoundRobberiesDone(p1, p2) --[[ Line: 50 | Upvalues: PersistentCrewBattleConsts (copy) ]]
	p1:SetAttribute(PersistentCrewBattleConsts.ROUND_ROBBERIES_DONE_ATTR_NAME, p2)
end
function t.getAttackingCrewStartTime() --[[ Line: 53 | Upvalues: t (copy) ]]
	return t.getCrewStartTime(t.getAttackingCrewObj())
end
function t.setAttackingCrewStartTime(p1) --[[ Line: 56 | Upvalues: t (copy) ]]
	t.setCrewStartTime(t.getAttackingCrewObj(), p1)
end
function t.getAttackingCrewPenaltyDuration() --[[ Line: 59 | Upvalues: t (copy) ]]
	return t.getCrewPenaltyDuration(t.getAttackingCrewObj())
end
function t.setAttackingCrewPenaltyDuration(p1) --[[ Line: 62 | Upvalues: t (copy) ]]
	t.setCrewPenaltyDuration(t.getAttackingCrewObj(), p1)
end
function t.getAttackingCrewEffectiveDurationElapsed() --[[ Line: 65 | Upvalues: t (copy) ]]
	return t.getCrewEffectiveDurationElapsed(t.getAttackingCrewObj())
end
function t.getAllCrewBattleDataObj() --[[ Line: 68 | Upvalues: ReplicatedStorage (copy), PersistentCrewBattleConsts (copy) ]]
	return ReplicatedStorage:FindFirstChild(PersistentCrewBattleConsts.ALL_CREW_BATTLE_DATA_OBJ_NAME)
end
function t.getAttackingClanId() --[[ Line: 71 | Upvalues: t (copy), PersistentCrewBattleConsts (copy) ]]
	return t.getAllCrewBattleDataObj():GetAttribute(PersistentCrewBattleConsts.ATTACKING_CLAN_ID)
end
function t.getAttackingClanIdChangedSignal() --[[ Line: 75 | Upvalues: t (copy), PersistentCrewBattleConsts (copy) ]]
	return t.getAllCrewBattleDataObj():GetAttributeChangedSignal(PersistentCrewBattleConsts.ATTACKING_CLAN_ID)
end
function t.setAttackingClanId(p1) --[[ Line: 79 | Upvalues: t (copy), PersistentCrewBattleConsts (copy) ]]
	t.getAllCrewBattleDataObj():SetAttribute(PersistentCrewBattleConsts.ATTACKING_CLAN_ID, p1)
end
function t.getCrewObjFromClanId(p1) --[[ Line: 83 | Upvalues: t (copy) ]]
	assert(p1 ~= nil, "clanId cannot be nil")
	return t.getAllCrewBattleDataObj():FindFirstChild(p1)
end
function t.getAttackingCrewObj() --[[ Line: 87 | Upvalues: t (copy) ]]
	return t.getCrewObjFromClanId(t.getAttackingClanId())
end
function t.getClanBattleInfoFromClanData(p1, p2) --[[ Line: 90 | Upvalues: PersistentCrewBattleConsts (copy) ]]
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
function t.validateClanRatingData(p1) --[[ Line: 107 ]]
	local v1, v2 = pcall(function() --[[ Line: 108 | Upvalues: p1 (copy) ]]
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
function t.getDefaultRatingData() --[[ Line: 128 | Upvalues: PersistentCrewBattleConsts (copy), t (copy) ]]
	local t2 = {
		Rating = PersistentCrewBattleConsts.DEFAULT_RATING,
		RatingDeviation = PersistentCrewBattleConsts.DEFAULT_RATING_DEVIATION,
		Sigma = PersistentCrewBattleConsts.DEFAULT_SIGMA_GRINDSET,
		LastBattle = workspace:GetServerTimeNow()
	}
	t.validateClanRatingData(t2)
	return t2
end
function t.getDisplayRatingFromClanBattleInfo(p1) --[[ Line: 138 | Upvalues: t (copy), PersistentCrewBattleConsts (copy) ]]
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
function t.calculateWLRatio(p1, p2) --[[ Line: 155 ]]
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
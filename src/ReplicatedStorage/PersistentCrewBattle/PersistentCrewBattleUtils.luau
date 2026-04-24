-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PersistentCrewBattleConsts = require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleConsts)
local t = {
	getBattleServerInitTime = function()
		return ReplicatedStorage:GetAttribute(PersistentCrewBattleConsts.BATTLE_SERVER_INIT_TIME_ATTR_NAME)
	end,
	setBattleServerInitTime = function(initTime)
		return ReplicatedStorage:SetAttribute(PersistentCrewBattleConsts.BATTLE_SERVER_INIT_TIME_ATTR_NAME, initTime)
	end,
	getRoundStartsAt = function()
		return ReplicatedStorage:GetAttribute(PersistentCrewBattleConsts.ROUND_STARTS_AT_ATTR_NAME)
	end,
	setRoundStartsAt = function(roundStartTime)
		ReplicatedStorage:SetAttribute(PersistentCrewBattleConsts.ROUND_STARTS_AT_ATTR_NAME, roundStartTime)
	end,
	getRoundStartsAtAttributeChangedSignal = function()
		return ReplicatedStorage:GetAttributeChangedSignal(PersistentCrewBattleConsts.ROUND_STARTS_AT_ATTR_NAME)
	end,
	getCrewStartTime = function(crewObj)
		return crewObj:GetAttribute(PersistentCrewBattleConsts.ROUND_START_ATTR_NAME)
	end,
	setCrewStartTime = function(crewObj, startTime)
		crewObj:SetAttribute(PersistentCrewBattleConsts.ROUND_START_ATTR_NAME, startTime)
	end,
	getCrewPenaltyDuration = function(crewObj)
		return crewObj:GetAttribute(PersistentCrewBattleConsts.ROUND_PENALTY_DURATION_ATTR_NAME)
	end,
	setCrewPenaltyDuration = function(crewObj, penaltyDuration)
		crewObj:SetAttribute(PersistentCrewBattleConsts.ROUND_PENALTY_DURATION_ATTR_NAME, penaltyDuration)
	end
}
function t.getCrewDurationElapsed(crewObj)
	local startTime = t.getCrewStartTime(crewObj)
	return workspace:GetServerTimeNow() - startTime
end
function t.getCrewEffectiveDurationElapsed(crewObj)
	local penaltyDuration = t.getCrewPenaltyDuration(crewObj)
	return t.getCrewDurationElapsed(crewObj) + penaltyDuration
end
function t.getCrewTimeTook(crewObj)
	return crewObj:GetAttribute(PersistentCrewBattleConsts.ROUND_TIME_TOOK_ATTR_NAME)
end
function t.setCrewRoundTimeTook(crewObj, timeTook)
	crewObj:SetAttribute(PersistentCrewBattleConsts.ROUND_TIME_TOOK_ATTR_NAME, timeTook)
end
function t.getCrewRoundRobberiesDone(crewObj)
	return crewObj:GetAttribute(PersistentCrewBattleConsts.ROUND_ROBBERIES_DONE_ATTR_NAME)
end
function t.setCrewRoundRobberiesDone(crewObj, robbieriesDone)
	crewObj:SetAttribute(PersistentCrewBattleConsts.ROUND_ROBBERIES_DONE_ATTR_NAME, robbieriesDone)
end
function t.getAttackingCrewStartTime()
	return t.getCrewStartTime(t.getAttackingCrewObj())
end
function t.setAttackingCrewStartTime(startTime)
	t.setCrewStartTime(t.getAttackingCrewObj(), startTime)
end
function t.getAttackingCrewPenaltyDuration()
	return t.getCrewPenaltyDuration(t.getAttackingCrewObj())
end
function t.setAttackingCrewPenaltyDuration(penaltyDuration)
	t.setCrewPenaltyDuration(t.getAttackingCrewObj(), penaltyDuration)
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
function t.setAttackingClanId(clanId)
	t.getAllCrewBattleDataObj():SetAttribute(PersistentCrewBattleConsts.ATTACKING_CLAN_ID, clanId)
end
function t.getCrewObjFromClanId(clanId)
	assert(clanId ~= nil, "clanId cannot be nil")
	return t.getAllCrewBattleDataObj():FindFirstChild(clanId)
end
function t.getAttackingCrewObj()
	return t.getCrewObjFromClanId(t.getAttackingClanId())
end
function t.getClanBattleInfoFromClanData(clanData, isAllTime)
	if clanData then
		local battleInfo = nil
		if isAllTime then
			return clanData.AllTimeClanBattleInfo
		else
			if clanData.SeasonClanBattleInfo then
				battleInfo = clanData.SeasonClanBattleInfo[tostring(PersistentCrewBattleConsts.CURR_CREW_BATTLE_SEASON)]
			end
			return battleInfo
		end
	else
		return nil
	end
end
function t.validateClanRatingData(ratingData)
	local isValid, errorMsg = pcall(function()
		if ratingData then
			assert(if typeof(ratingData.Rating) == "number" then ratingData.Rating > 0 else false, "Invalid Rating")
			assert(if typeof(ratingData.RatingDeviation) == "number" then ratingData.RatingDeviation > 0 else false, "Invalid RatingDeviation")
			assert(if typeof(ratingData.Sigma) == "number" then ratingData.Sigma > 0 else false, "Invalid Sigma")
			assert(if typeof(ratingData.LastBattle) == "number" then ratingData.LastBattle > 0 else false, "Invalid LastBattle")
		end
	end)
	if not isValid then
		warn(errorMsg)
	end
	return isValid
end
function t.getDefaultRatingData()
	local defaultRatingData = {
		Rating = PersistentCrewBattleConsts.DEFAULT_RATING,
		RatingDeviation = PersistentCrewBattleConsts.DEFAULT_RATING_DEVIATION,
		Sigma = PersistentCrewBattleConsts.DEFAULT_SIGMA_GRINDSET,
		LastBattle = workspace:GetServerTimeNow()
	}
	t.validateClanRatingData(defaultRatingData)
	return defaultRatingData
end
function t.getDisplayRatingFromClanBattleInfo(clanBattleInfo)
	local ratingData = clanBattleInfo and clanBattleInfo.RatingData
	if not ratingData then
		ratingData = t.getDefaultRatingData()
	end
	local displayRating = tostring((math.floor(ratingData.Rating)))
	if not clanBattleInfo or (not clanBattleInfo.BattlesPlayed or clanBattleInfo.BattlesPlayed < PersistentCrewBattleConsts.NUM_PROVISIONAL_RATING_BATTLES) then
		displayRating = displayRating .. "?"
	end
	return displayRating
end
function t.calculateWLRatio(battlesWon, totalBattles)
	if battlesWon and totalBattles and totalBattles > 0 then
		if totalBattles - battlesWon == 0 then
			return "\226\136\158"
		else
			return string.format("%.2f", battlesWon / (totalBattles - battlesWon))
		end
	else
		return nil
	end
end
return t

-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SeasonConsts = require(ReplicatedStorage.Game.Season.SeasonConsts)
local LevelConsts = require(script.Parent.LevelConsts)
local t = {
	getLevelValue = function(instance)
		assert(instance ~= nil)
		return instance:FindFirstChild(LevelConsts.LEVEL_VALUE_NAME)
	end,
	yieldLevelValue = function(instance)
		assert(instance ~= nil)
		return instance:WaitForChild(LevelConsts.LEVEL_VALUE_NAME)
	end
}
function t.yieldLevel(instance)
	assert(instance ~= nil)
	return t.yieldLevelValue(instance).Value
end
function t.getLevel(instance)
	local levelValue = t.getLevelValue(instance)
	if levelValue then
		return levelValue.Value
	end
end
function t.getExpValue(instance)
	assert(instance ~= nil)
	return instance:FindFirstChild(LevelConsts.EXP_VALUE_NAME)
end
function t.yieldExpValue(instance)
	assert(instance ~= nil)
	return instance:WaitForChild(LevelConsts.EXP_VALUE_NAME)
end
function t.yieldExp(instance)
	assert(instance ~= nil)
	return t.yieldExpValue(instance).Value
end
function t.getExp(instance)
	local expValue = t.getExpValue(instance)
	if expValue then
		return expValue.Value
	end
end
function t.yieldTotalExp(instance)
	local level = t.yieldLevel(instance)
	return t.calculateExpOfLevel(level) + t.yieldExp(instance)
end
local function getTotalExpAtLevel(p1, p2, p3, p4)
	local v1 = if p4 == 1 then p2 / p3 else p2 * (1 - p4) / (1 - p4 ^ p3)
	local v2 = if p4 == 1 then v1 * p1 else v1 * (1 - p4 ^ p1) / (1 - p4)
	local count = math.floor(v2)
	if v2 - count >= 0.5 then
		count = count + 1
	end
	return count
end
local baseExpPerDay = LevelConsts.EFFICIENCY * (LevelConsts.AVG_EXP_PER_CONTRACT * LevelConsts.CONTRACTS_PER_DAY * LevelConsts.TOTAL_DAYS + LevelConsts.MAX_DAILY_EXP * LevelConsts.TOTAL_DAYS)
local CURVE_K = LevelConsts.CURVE_K
function t.calculateExpNextLevel(instance)
	return t.calculateExpOfLevel(instance + 1) - t.calculateExpOfLevel(instance)
end
function t.calculateExpOfLevel(instance)
	if instance <= 0 then
		return 0
	else
		local previousLevel = instance - 1
		local totalBaseExp = baseExpPerDay
		local maxRewardLevel = SeasonConsts.MAX_REWARD_LEVEL - 1
		local curveK = CURVE_K
		local baseExpPerLevel = if curveK == 1 then totalBaseExp / maxRewardLevel else totalBaseExp * (1 - curveK) / (1 - curveK ^ maxRewardLevel)
		local expAtLevel = if curveK == 1 then baseExpPerLevel * previousLevel else baseExpPerLevel * (1 - curveK ^ previousLevel) / (1 - curveK)
		local count = math.floor(expAtLevel)
		if expAtLevel - count >= 0.5 then
			count = count + 1
		end
		return count
	end
end
function t.calculateLevelFromExp(totalExp)
	local currentLevel = 1
	local previousExpAtLevel = 0
	while true do
		currentLevel = currentLevel + 1
		local expAtCurrentLevel = t.calculateExpOfLevel(currentLevel)
		if totalExp < expAtCurrentLevel then
			break
		end
		previousExpAtLevel = expAtCurrentLevel
	end
	return currentLevel - 1, totalExp - previousExpAtLevel
end
return t

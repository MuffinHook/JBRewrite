local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SeasonConsts = require(ReplicatedStorage.Game.Season.SeasonConsts)
local LevelConsts = require(script.Parent.LevelConsts)
local t = {
	getLevelValue = function(p1) --[[ Name: getLevelValue | Line: 7 | Upvalues: LevelConsts (copy) ]]
		assert(p1 ~= nil)
		return p1:FindFirstChild(LevelConsts.LEVEL_VALUE_NAME)
	end,
	yieldLevelValue = function(p1) --[[ Name: yieldLevelValue | Line: 11 | Upvalues: LevelConsts (copy) ]]
		assert(p1 ~= nil)
		return p1:WaitForChild(LevelConsts.LEVEL_VALUE_NAME)
	end
}
function t.yieldLevel(p1) --[[ Line: 15 | Upvalues: t (copy) ]]
	assert(p1 ~= nil)
	return t.yieldLevelValue(p1).Value
end
function t.getLevel(p1) --[[ Line: 19 | Upvalues: t (copy) ]]
	local v1 = t.getLevelValue(p1)
	if v1 then
		return v1.Value
	end
end
function t.getExpValue(p1) --[[ Line: 25 | Upvalues: LevelConsts (copy) ]]
	assert(p1 ~= nil)
	return p1:FindFirstChild(LevelConsts.EXP_VALUE_NAME)
end
function t.yieldExpValue(p1) --[[ Line: 29 | Upvalues: LevelConsts (copy) ]]
	assert(p1 ~= nil)
	return p1:WaitForChild(LevelConsts.EXP_VALUE_NAME)
end
function t.yieldExp(p1) --[[ Line: 33 | Upvalues: t (copy) ]]
	assert(p1 ~= nil)
	return t.yieldExpValue(p1).Value
end
function t.getExp(p1) --[[ Line: 37 | Upvalues: t (copy) ]]
	local v1 = t.getExpValue(p1)
	if v1 then
		return v1.Value
	end
end
function t.yieldTotalExp(p1) --[[ Line: 43 | Upvalues: t (copy) ]]
	local v1 = t.yieldLevel(p1)
	return t.calculateExpOfLevel(v1) + t.yieldExp(p1)
end
local function getTotalExpAtLevel(p1, p2, p3, p4) --[[ Line: 49 ]]
	local v1 = if p4 == 1 then p2 / p3 else p2 * (1 - p4) / (1 - p4 ^ p3)
	local v2 = if p4 == 1 then v1 * p1 else v1 * (1 - p4 ^ p1) / (1 - p4)
	local count = math.floor(v2)
	if v2 - count >= 0.5 then
		count = count + 1
	end
	return count
end
local v1 = LevelConsts.EFFICIENCY * (LevelConsts.AVG_EXP_PER_CONTRACT * LevelConsts.CONTRACTS_PER_DAY * LevelConsts.TOTAL_DAYS + LevelConsts.MAX_DAILY_EXP * LevelConsts.TOTAL_DAYS)
local CURVE_K = LevelConsts.CURVE_K
function t.calculateExpNextLevel(p1) --[[ Line: 83 | Upvalues: t (copy) ]]
	return t.calculateExpOfLevel(p1 + 1) - t.calculateExpOfLevel(p1)
end
function t.calculateExpOfLevel(p1) --[[ Line: 86 | Upvalues: v1 (copy), SeasonConsts (copy), CURVE_K (copy) ]]
	if p1 <= 0 then
		return 0
	else
		local v12 = p1 - 1
		local v2 = v1
		local v3 = SeasonConsts.MAX_REWARD_LEVEL - 1
		local v4 = CURVE_K
		local v5 = if v4 == 1 then v2 / v3 else v2 * (1 - v4) / (1 - v4 ^ v3)
		local v6 = if v4 == 1 then v5 * v12 else v5 * (1 - v4 ^ v12) / (1 - v4)
		local count = math.floor(v6)
		if v6 - count >= 0.5 then
			count = count + 1
		end
		return count
	end
end
function t.calculateLevelFromExp(p1) --[[ Line: 92 | Upvalues: t (copy) ]]
	local count = 1
	local v1 = 0
	while true do
		count = count + 1
		local v2 = t.calculateExpOfLevel(count)
		if p1 < v2 then
			break
		end
		v1 = v2
	end
	return count - 1, p1 - v1
end
return t
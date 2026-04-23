local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _allAirDropData = require(ReplicatedStorage.AirDrop.Data._allAirDropData)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local RewardDataUtils = require(ReplicatedStorage.RewardData.RewardDataUtils)
local t = {}
local function lerp(p1, p2, p3) --[[ Line: 7 ]]
	return (p2 - p1) * p3 + p1
end
function t.getProportionOfMaxAirDropScalingDurationDone(p1, p2) --[[ Line: 10 | Upvalues: t (copy) ]]
	local DurationToGetMaxScaling = t.getAirDropTypeData(p1).DurationToGetMaxScaling
	return math.min(p2, DurationToGetMaxScaling) / DurationToGetMaxScaling
end
function t.getCurrentGuardWaveData(p1, p2) --[[ Line: 16 | Upvalues: t (copy) ]]
	local v1 = t.getAirDropTypeData(p1)
	local v2 = t.getProportionOfMaxAirDropScalingDurationDone(p1, p2)
	local t2 = {}
	for v3, v4 in v1.BeginningData.GuardData do
		t2[v3] = (v1.EndingData.GuardData[v3] - v4) * v2 + v4
	end
	return t2
end
function t.getCurrentMoneyDropData(p1, p2) --[[ Line: 28 | Upvalues: t (copy) ]]
	local v1 = t.getAirDropTypeData(p1)
	local v2 = t.getProportionOfMaxAirDropScalingDurationDone(p1, p2)
	local t2 = {}
	for v3, v4 in v1.BeginningData.MoneyDropData do
		t2[v3] = (v1.EndingData.MoneyDropData[v3] - v4) * v2 + v4
	end
	return t2
end
function t.getAirDropTypeData(p1) --[[ Line: 39 | Upvalues: _allAirDropData (copy) ]]
	return _allAirDropData[p1]
end
function t.getCurrentAirDropRarityProbabilities(p1, p2) --[[ Line: 42 | Upvalues: t (copy) ]]
	local v1 = t.getAirDropTypeData(p1)
	local v2 = t.getProportionOfMaxAirDropScalingDurationDone(p1, p2)
	local t2 = {}
	for v3, v4 in v1.BeginningData.RarityProbs do
		local v5 = v1.EndingData.RarityProbs[v3]
		assert(v5, "No ending probability")
		t2[v3] = (v5 - v4) * v2 + v4
	end
	return t2
end
function t.getCurrentDataForAirDrop(p1, p2) --[[ Line: 54 | Upvalues: t (copy), TableUtils (copy), RewardDataUtils (copy) ]]
	local v1 = t.getCurrentAirDropRarityProbabilities(p1, p2)
	local v2 = TableUtils.deepCopy(t.getAirDropTypeData(p1))
	v2.RarityProbabilities = v1
	RewardDataUtils.addAbsoluteProbsToRewardDataFromRarityProbs(v2.RewardData, v2.RarityProbabilities)
	v2.GuardData = t.getCurrentGuardWaveData(p1, p2)
	v2.MoneyDropData = t.getCurrentMoneyDropData(p1, p2)
	return v2
end
return t
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _allAirDropData = require(ReplicatedStorage.AirDrop.Data._allAirDropData)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local RewardDataUtils = require(ReplicatedStorage.RewardData.RewardDataUtils)
local AirDropDataUtilsModule = {}
local function linearInterpolate(startValue, endValue, progress)
	return (endValue - startValue) * progress + startValue
end
function AirDropDataUtilsModule.getProportionOfMaxAirDropScalingDurationDone(airDropTypeId, elapsedTime)
	local DurationToGetMaxScaling = AirDropDataUtilsModule.getAirDropTypeData(airDropTypeId).DurationToGetMaxScaling
	return math.min(elapsedTime, DurationToGetMaxScaling) / DurationToGetMaxScaling
end
function AirDropDataUtilsModule.getCurrentGuardWaveData(airDropTypeId, elapsedTime)
	local airDropTypeData = AirDropDataUtilsModule.getAirDropTypeData(airDropTypeId)
	local scalingProgress = AirDropDataUtilsModule.getProportionOfMaxAirDropScalingDurationDone(airDropTypeId, elapsedTime)
	local currentGuardData = {}
	for key, beginningValue in airDropTypeData.BeginningData.GuardData do
		currentGuardData[key] = (airDropTypeData.EndingData.GuardData[key] - beginningValue) * scalingProgress + beginningValue
	end
	return currentGuardData
end
function AirDropDataUtilsModule.getCurrentMoneyDropData(airDropTypeId, elapsedTime)
	local airDropTypeData = AirDropDataUtilsModule.getAirDropTypeData(airDropTypeId)
	local scalingProgress = AirDropDataUtilsModule.getProportionOfMaxAirDropScalingDurationDone(airDropTypeId, elapsedTime)
	local currentMoneyData = {}
	for key, beginningValue in airDropTypeData.BeginningData.MoneyDropData do
		currentMoneyData[key] = (airDropTypeData.EndingData.MoneyDropData[key] - beginningValue) * scalingProgress + beginningValue
	end
	return currentMoneyData
end
function AirDropDataUtilsModule.getAirDropTypeData(airDropTypeId)
	return _allAirDropData[airDropTypeId]
end
function AirDropDataUtilsModule.getCurrentAirDropRarityProbabilities(airDropTypeId, elapsedTime)
	local airDropTypeData = AirDropDataUtilsModule.getAirDropTypeData(airDropTypeId)
	local scalingProgress = AirDropDataUtilsModule.getProportionOfMaxAirDropScalingDurationDone(airDropTypeId, elapsedTime)
	local currentRarityProbs = {}
	for rarityId, beginningProb in airDropTypeData.BeginningData.RarityProbs do
		local endingProb = airDropTypeData.EndingData.RarityProbs[rarityId]
		assert(endingProb, "No ending probability")
		currentRarityProbs[rarityId] = (endingProb - beginningProb) * scalingProgress + beginningProb
	end
	return currentRarityProbs
end
function AirDropDataUtilsModule.getCurrentDataForAirDrop(airDropTypeId, elapsedTime)
	local currentRarityProbs = AirDropDataUtilsModule.getCurrentAirDropRarityProbabilities(airDropTypeId, elapsedTime)
	local currentAirDropData = TableUtils.deepCopy(AirDropDataUtilsModule.getAirDropTypeData(airDropTypeId))
	currentAirDropData.RarityProbabilities = currentRarityProbs
	RewardDataUtils.addAbsoluteProbsToRewardDataFromRarityProbs(currentAirDropData.RewardData, currentAirDropData.RarityProbabilities)
	currentAirDropData.GuardData = AirDropDataUtilsModule.getCurrentGuardWaveData(airDropTypeId, elapsedTime)
	currentAirDropData.MoneyDropData = AirDropDataUtilsModule.getCurrentMoneyDropData(airDropTypeId, elapsedTime)
	return currentAirDropData
end
return AirDropDataUtilsModule

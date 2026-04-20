local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_3_upvr = {}
local function _(arg1, arg2, arg3) -- Line 7, Named "lerp"
    return (arg2 - arg1) * arg3 + arg1
end
function module_3_upvr.getProportionOfMaxAirDropScalingDurationDone(arg1, arg2) -- Line 10
    local DurationToGetMaxScaling = module_3_upvr.getAirDropTypeData(arg1).DurationToGetMaxScaling
    return math.min(arg2, DurationToGetMaxScaling) / DurationToGetMaxScaling
end
function module_3_upvr.getCurrentGuardWaveData(arg1, arg2) -- Line 16
    local any_getAirDropTypeData_result1_3 = module_3_upvr.getAirDropTypeData(arg1)
    local module = {}
    local any_getProportionOfMaxAirDropScalingDurationDone_result1_3 = module_3_upvr.getProportionOfMaxAirDropScalingDurationDone(arg1, arg2)
    for i, v in any_getAirDropTypeData_result1_3.BeginningData.GuardData do
        module[i] = (any_getAirDropTypeData_result1_3.EndingData.GuardData[i] - v) * any_getProportionOfMaxAirDropScalingDurationDone_result1_3 + v
    end
    return module
end
function module_3_upvr.getCurrentMoneyDropData(arg1, arg2) -- Line 28
    local any_getAirDropTypeData_result1 = module_3_upvr.getAirDropTypeData(arg1)
    local any_getProportionOfMaxAirDropScalingDurationDone_result1 = module_3_upvr.getProportionOfMaxAirDropScalingDurationDone(arg1, arg2)
    local module_2 = {}
    for i_2, v_2 in any_getAirDropTypeData_result1.BeginningData.MoneyDropData do
        module_2[i_2] = (any_getAirDropTypeData_result1.EndingData.MoneyDropData[i_2] - v_2) * any_getProportionOfMaxAirDropScalingDurationDone_result1 + v_2
    end
    return module_2
end
local _allAirDropData_upvr = require(ReplicatedStorage.AirDrop.Data._allAirDropData)
function module_3_upvr.getAirDropTypeData(arg1) -- Line 39
    return _allAirDropData_upvr[arg1]
end
function module_3_upvr.getCurrentAirDropRarityProbabilities(arg1, arg2) -- Line 42
    local any_getAirDropTypeData_result1_2 = module_3_upvr.getAirDropTypeData(arg1)
    local any_getProportionOfMaxAirDropScalingDurationDone_result1_2 = module_3_upvr.getProportionOfMaxAirDropScalingDurationDone(arg1, arg2)
    local module_4 = {}
    for i_3, v_3 in any_getAirDropTypeData_result1_2.BeginningData.RarityProbs do
        local var26 = any_getAirDropTypeData_result1_2.EndingData.RarityProbs[i_3]
        assert(var26, "No ending probability")
        module_4[i_3] = (var26 - v_3) * any_getProportionOfMaxAirDropScalingDurationDone_result1_2 + v_3
    end
    return module_4
end
local TableUtils_upvr = require(ReplicatedStorage.Std.TableUtils)
local RewardDataUtils_upvr = require(ReplicatedStorage.RewardData.RewardDataUtils)
function module_3_upvr.getCurrentDataForAirDrop(arg1, arg2) -- Line 54
    local any_deepCopy_result1 = TableUtils_upvr.deepCopy(module_3_upvr.getAirDropTypeData(arg1))
    any_deepCopy_result1.RarityProbabilities = module_3_upvr.getCurrentAirDropRarityProbabilities(arg1, arg2)
    RewardDataUtils_upvr.addAbsoluteProbsToRewardDataFromRarityProbs(any_deepCopy_result1.RewardData, any_deepCopy_result1.RarityProbabilities)
    any_deepCopy_result1.GuardData = module_3_upvr.getCurrentGuardWaveData(arg1, arg2)
    any_deepCopy_result1.MoneyDropData = module_3_upvr.getCurrentMoneyDropData(arg1, arg2)
    return any_deepCopy_result1
end
return module_3_upvr
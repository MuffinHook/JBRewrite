local LevelConsts_upvr = require(script.Parent.LevelConsts)
local module_upvr = {
    getLevelValue = function(arg1) -- Line 7, Named "getLevelValue"
        if arg1 == nil then
        else
        end
        assert(true)
        return arg1:FindFirstChild(LevelConsts_upvr.LEVEL_VALUE_NAME)
    end;
    yieldLevelValue = function(arg1) -- Line 11, Named "yieldLevelValue"
        if arg1 == nil then
        else
        end
        assert(true)
        return arg1:WaitForChild(LevelConsts_upvr.LEVEL_VALUE_NAME)
    end;
}
function module_upvr.yieldLevel(arg1) -- Line 15
    if arg1 == nil then
    else
    end
    assert(true)
    return module_upvr.yieldLevelValue(arg1).Value
end
function module_upvr.getLevel(arg1) -- Line 19
    local any_getLevelValue_result1 = module_upvr.getLevelValue(arg1)
    if any_getLevelValue_result1 then
        return any_getLevelValue_result1.Value
    end
end
function module_upvr.getExpValue(arg1) -- Line 25
    if arg1 == nil then
    else
    end
    assert(true)
    return arg1:FindFirstChild(LevelConsts_upvr.EXP_VALUE_NAME)
end
function module_upvr.yieldExpValue(arg1) -- Line 29
    if arg1 == nil then
    else
    end
    assert(true)
    return arg1:WaitForChild(LevelConsts_upvr.EXP_VALUE_NAME)
end
function module_upvr.yieldExp(arg1) -- Line 33
    if arg1 == nil then
    else
    end
    assert(true)
    return module_upvr.yieldExpValue(arg1).Value
end
function module_upvr.getExp(arg1) -- Line 37
    local any_getExpValue_result1 = module_upvr.getExpValue(arg1)
    if any_getExpValue_result1 then
        return any_getExpValue_result1.Value
    end
end
function module_upvr.yieldTotalExp(arg1) -- Line 43
    return module_upvr.calculateExpOfLevel(module_upvr.yieldLevel(arg1)) + module_upvr.yieldExp(arg1)
end
local function _(arg1, arg2, arg3, arg4) -- Line 49, Named "getTotalExpAtLevel"
    local var5
    if arg4 == 1 then
        var5 = arg2 / arg3
    else
        var5 = arg2 * (1 - arg4) / (1 - arg4 ^ arg3)
    end
    local var6
    if arg4 == 1 then
        var6 = var5 * arg1
    else
        var6 = var5 * (1 - arg4 ^ arg1) / (1 - arg4)
    end
    local floored = math.floor(var6)
    if 0.5 <= var6 - floored then
        floored += 1
    end
    return floored
end
function module_upvr.calculateExpNextLevel(arg1) -- Line 83
    return module_upvr.calculateExpOfLevel(arg1 + 1) - module_upvr.calculateExpOfLevel(arg1)
end
local var8_upvr = LevelConsts_upvr.EFFICIENCY * (LevelConsts_upvr.AVG_EXP_PER_CONTRACT * LevelConsts_upvr.CONTRACTS_PER_DAY * LevelConsts_upvr.TOTAL_DAYS + LevelConsts_upvr.MAX_DAILY_EXP * LevelConsts_upvr.TOTAL_DAYS)
local SeasonConsts_upvr = require(game:GetService("ReplicatedStorage").Game.Season.SeasonConsts)
local CURVE_K_upvr = LevelConsts_upvr.CURVE_K
function module_upvr.calculateExpOfLevel(arg1) -- Line 86
    local var11
    if arg1 <= 0 then
        return 0
    end
    local var12 = CURVE_K_upvr
    var11 = nil
    if var12 == 1 then
        var11 = var8_upvr / (SeasonConsts_upvr.MAX_REWARD_LEVEL - 1)
    else
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        var11 = var8_upvr * (1 - var12) / (1 - var12 ^ (SeasonConsts_upvr.MAX_REWARD_LEVEL - 1))
    end
    local var13
    if var12 == 1 then
        var13 = var11 * (arg1 - 1)
    else
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        var13 = var11 * (1 - var12 ^ (arg1 - 1)) / (1 - var12)
    end
    local floored_2 = math.floor(var13)
    if 0.5 <= var13 - floored_2 then
        floored_2 += 1
    end
    return floored_2
end
function module_upvr.calculateLevelFromExp(arg1) -- Line 92
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var15
    repeat
        var15 += 1
        local any_calculateExpOfLevel_result1 = module_upvr.calculateExpOfLevel(var15)
    until arg1 < any_calculateExpOfLevel_result1
    var15 -= 1
    return var15, arg1 - any_calculateExpOfLevel_result1
end
return module_upvr
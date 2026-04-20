local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Glicko2Consts_upvr = require(ReplicatedStorage.Glicko2.Glicko2Consts)
local module_upvr = {
    g = function(arg1) -- Line 11, Named "g"
        return 1 / math.sqrt(1 + 3 * arg1 ^ 2 / 9.869604401089358)
    end;
}
function module_upvr.E(arg1, arg2, arg3) -- Line 14
    return 1 / (math.exp(-module_upvr.g(arg3) * (arg1 - arg2)) + 1)
end
function module_upvr.v(arg1, arg2, arg3) -- Line 17
    local var6 = 0
    for i = 1, #arg2 do
        local var7 = arg3[i]
        local any_E_result1 = module_upvr.E(arg1, arg2[i], var7)
        var6 += module_upvr.g(var7) ^ 2 * any_E_result1 * (1 - any_E_result1)
    end
    return 1 / var6
end
function module_upvr.delta(arg1, arg2, arg3, arg4, arg5) -- Line 29
    local var11 = 0
    for i_2 = 1, #arg3 do
        local var12 = arg4[i_2]
        var11 += module_upvr.g(var12) * (arg5[i_2] - module_upvr.E(arg2, arg3[i_2], var12))
    end
    return arg1 * var11
end
function module_upvr.f(arg1, arg2, arg3, arg4, arg5, arg6) -- Line 41
    return (0.5) * (math.exp(arg1) * (arg2 ^ 2 - arg4 ^ 2 - arg3 - math.exp(arg1))) / (arg4 ^ 2 + arg3 + math.exp(arg1)) ^ 2 - (arg1 - math.log(arg5 ^ 2)) / arg6 ^ 2
end
function module_upvr.convertToGlicko2Rating(arg1, arg2) -- Line 49
    return (arg1 - 1500) / Glicko2Consts_upvr.CONVERSION_FACTOR, arg2 / Glicko2Consts_upvr.CONVERSION_FACTOR
end
function module_upvr.convertFromGlicko2Rating(arg1, arg2) -- Line 54
    return Glicko2Consts_upvr.CONVERSION_FACTOR * arg1 + 1500, Glicko2Consts_upvr.CONVERSION_FACTOR * arg2
end
local MathUtils_upvr = require(ReplicatedStorage.Std.MathUtils)
function module_upvr.calculateNewRatingData(arg1, arg2, arg3, arg4, arg5, arg6, arg7) -- Line 62
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local var14
    if typeof(arg4) ~= "table" then
        var14 = false
    else
        var14 = true
    end
    assert(var14, "Invalid ratingList")
    if typeof(arg5) ~= "table" then
        var14 = false
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    var14 = true
    assert(var14, "Invalid ratingDeviationList")
    if typeof(arg6) ~= "table" then
        var14 = false
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
return module_upvr
local function _(arg1, arg2, arg3, arg4, arg5) -- Line 1, Named "CubicBezierCurve"
    local var1 = 1 - arg1
    return var1 * var1 * var1 * arg2 + 3 * var1 * var1 * arg1 * arg3 + 3 * var1 * arg1 * arg1 * arg4 + arg1 * arg1 * arg1 * arg5
end
local function _(arg1, arg2, arg3, arg4, arg5) -- Line 6, Named "DCubicBezierCurve"
    local var2 = 1 - arg1
    return 3 * var2 * var2 * (arg3 - arg2) + 6 * var2 * arg1 * (arg4 - arg3) + 3 * arg1 * arg1 * (arg5 - arg4)
end
local function ApproximateVectorCubicBezierCurveLength_upvr(arg1, arg2, arg3, arg4, arg5) -- Line 10, Named "ApproximateVectorCubicBezierCurveLength"
    local var5 = 0
    for i = 1, arg1 do
        local var6 = (i - 1) / arg1
        local var7 = 1 - var6
        var5 += (3 * var7 * var7 * (arg3 - arg2) + 6 * var7 * var6 * (arg4 - arg3) + 3 * var6 * var6 * (arg5 - arg4)).Magnitude / arg1
    end
    return var5
end
local module_upvr = {}
module_upvr.__index = module_upvr
function module_upvr.new() -- Line 22
    local setmetatable_result1 = setmetatable({}, module_upvr)
    setmetatable_result1.Points = nil
    setmetatable_result1.NumPoints = nil
    setmetatable_result1.LastIndex = nil
    setmetatable_result1.OffsetStart = 0
    setmetatable_result1.OffsetEnd = 0
    setmetatable_result1.t = 0
    setmetatable_result1.lengthCache = {}
    return setmetatable_result1
end
function module_upvr.SetNodeOffset(arg1, arg2, arg3) -- Line 33
    assert(arg2)
    assert(arg3)
    arg1.OffsetStart = arg2
    arg1.OffsetEnd = arg3
end
function module_upvr.SetPoints(arg1, arg2) -- Line 39
    arg1.Points = arg2
    arg1.NumPoints = #arg2
    arg1:_recomputeLengthCache()
end
function module_upvr._recomputeLengthCache(arg1) -- Line 45
    for i_2 = 1, arg1.NumPoints do
        local any_GetPoint_result1_3 = arg1:GetPoint(i_2)
        local any_GetPoint_result1_2 = arg1:GetPoint(i_2 + 1)
        local Magnitude_2 = (any_GetPoint_result1_2 - any_GetPoint_result1_3).Magnitude
        arg1.lengthCache[i_2] = ApproximateVectorCubicBezierCurveLength_upvr(10000, any_GetPoint_result1_3, any_GetPoint_result1_3 + (any_GetPoint_result1_2 - arg1:GetPoint(i_2 - 1)).Unit * Magnitude_2 / 3, any_GetPoint_result1_2 - (arg1:GetPoint(i_2 + 2) - any_GetPoint_result1_3).Unit * Magnitude_2 / 3, any_GetPoint_result1_2)
    end
end
function module_upvr.GetPoint(arg1, arg2) -- Line 55
    return arg1.Points[(arg2 - 1) % arg1.NumPoints + 1]
end
function module_upvr.ApproximateLength(arg1, arg2) -- Line 58
    local var16 = 0
    for i_3 = arg1.OffsetStart + 1, arg1.NumPoints - arg1.OffsetEnd do
        local any_GetPoint_result1 = arg1:GetPoint(i_3)
        local any_GetPoint_result1_4 = arg1:GetPoint(i_3 + 1)
        local Magnitude_3 = (any_GetPoint_result1_4 - any_GetPoint_result1).Magnitude
        var16 += ApproximateVectorCubicBezierCurveLength_upvr(arg2, any_GetPoint_result1, any_GetPoint_result1 + (any_GetPoint_result1_4 - arg1:GetPoint(i_3 - 1)).Unit * Magnitude_3 / 3, any_GetPoint_result1_4 - (arg1:GetPoint(i_3 + 2) - any_GetPoint_result1).Unit * Magnitude_3 / 3, any_GetPoint_result1_4)
    end
    return var16
end
function module_upvr.Step(arg1, arg2) -- Line 73
    local t = arg1.t
    local var21 = t * (arg1.NumPoints - arg1.OffsetStart - arg1.OffsetEnd) + arg1.OffsetStart
    local var22 = var21 % 1
    local var23 = math.floor(var21) + 1
    local var24
    local var25
    local var26
    local var27
    if arg1.LastIndex == var23 then
        var24 = arg1._p0
        var25 = arg1._c0
        var26 = arg1._c1
        var27 = arg1._p1
    else
        var24 = arg1:GetPoint(var23)
        var27 = arg1:GetPoint(var23 + 1)
        local Magnitude_4 = (var27 - var24).Magnitude
        var25 = var24 + (var27 - arg1:GetPoint(var23 - 1)).Unit * Magnitude_4 / 3
        var26 = var27 - (arg1:GetPoint(var23 + 2) - var24).Unit * Magnitude_4 / 3
        arg1._p0 = var24
        arg1._c0 = var25
        arg1._c1 = var26
        arg1._p1 = var27
    end
    arg1.LastIndex = var23
    local var29 = var25
    local var30 = var26
    local var31 = 1 - var22
    local var32 = 3 * var31 * var31 * (var29 - var24) + 6 * var31 * var22 * (var30 - var29) + 3 * var22 * var22 * (var27 - var30)
    local Magnitude = var32.Magnitude
    local var34 = 1 - var22
    if 0 < Magnitude then
        arg1.t = t + arg2 / Magnitude / (arg1.NumPoints - arg1.OffsetStart - arg1.OffsetEnd)
    end
    return var34 * var34 * var34 * var24 + 3 * var34 * var34 * var22 * var25 + 3 * var34 * var22 * var22 * var26 + var22 * var22 * var22 * var27, var32
end
function module_upvr.GetWorldPositionAt(arg1, arg2) -- Line 112
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [63.9]
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_upvr.Reset(arg1) -- Line 139
    arg1.t = 0
    arg1._p0 = nil
    arg1._c0 = nil
    arg1._c1 = nil
    arg1._p1 = nil
    arg1.LastIndex = nil
end
return module_upvr
function cubicBezier(arg1, arg2, arg3, arg4, arg5) -- Line 1
    return (1 - arg1) ^ 3 * arg2 + 3 * (1 - arg1) ^ 2 * arg1 * arg3 + 3 * (1 - arg1) * arg1 ^ 2 * arg4 + arg1 ^ 3 * arg5
end
function cubicBezierDerivative(arg1, arg2, arg3, arg4, arg5) -- Line 5
    return 3 * (1 - arg1) ^ 2 * (arg3 - arg2) + 6 * arg1 * (1 - arg1) * (arg4 - arg3) + 3 * arg1 ^ 2 * (arg5 - arg4)
end
local module_upvr = {}
module_upvr.__index = module_upvr
function module_upvr.new(arg1) -- Line 12
    local setmetatable_result1 = setmetatable({}, module_upvr)
    setmetatable_result1.keyframes = arg1 and {unpack(arg1)} or {}
    return setmetatable_result1
end
function module_upvr.UpdateKeyframes(arg1, arg2) -- Line 19
    table.clear(arg1.keyframes)
    table.move(arg2, 1, #arg2, 1, arg1.keyframes)
end
function module_upvr.CalculateSegmentAt(arg1, arg2) -- Line 24
    local var4 = arg2 * (#arg1.keyframes - 1)
    local var5 = math.floor(var4) + 1
    local var6 = var4 % 1
    if var5 < 1 then
        var5 = 1
        var6 = 0
    elseif #arg1.keyframes <= var5 then
        var5 = #arg1.keyframes - 1
        var6 = 1
    end
    return var6, arg1.keyframes[var5], arg1.keyframes[var5 + 1]
end
function module_upvr.CalculateSpeedAt(arg1, arg2) -- Line 41
    local any_CalculateSegmentAt_result1_2, any_CalculateSegmentAt_result2, any_CalculateSegmentAt_result3 = arg1:CalculateSegmentAt(arg2)
    if not any_CalculateSegmentAt_result2 or not any_CalculateSegmentAt_result3 then
        return 0
    end
    local pos = any_CalculateSegmentAt_result2.pos
    local var11 = any_CalculateSegmentAt_result2.pos + any_CalculateSegmentAt_result2.right
    local pos_2 = any_CalculateSegmentAt_result3.pos
    local var13 = pos - var11
    local var14 = (pos_2) - (any_CalculateSegmentAt_result3.pos + any_CalculateSegmentAt_result3.left)
    local var15 = pos_2.X - pos.X
    local absolute_2 = math.abs(var13.X)
    local absolute_3 = math.abs(var14.X)
    local var18
    if var15 < absolute_2 then
        var11 = pos - var15 / absolute_2 * var13
    end
    if var15 < absolute_3 then
        var18 = pos_2 - var15 / absolute_3 * var14
    end
    local cubicBezierDerivative_result1 = cubicBezierDerivative(any_CalculateSegmentAt_result1_2, pos, var11, var18, pos_2)
    return cubicBezierDerivative_result1.Y / math.sqrt(cubicBezierDerivative_result1.X ^ 2 + cubicBezierDerivative_result1.Y ^ 2)
end
function module_upvr.CalculatePositionAt(arg1, arg2) -- Line 74
    local any_CalculateSegmentAt_result1, any_CalculateSegmentAt_result2_2, any_CalculateSegmentAt_result3_2 = arg1:CalculateSegmentAt(arg2)
    if not any_CalculateSegmentAt_result2_2 then
        return Vector2.zero
    end
    if not any_CalculateSegmentAt_result3_2 then
        return any_CalculateSegmentAt_result2_2.pos
    end
    local pos_3 = any_CalculateSegmentAt_result2_2.pos
    local var24 = any_CalculateSegmentAt_result2_2.pos + any_CalculateSegmentAt_result2_2.right
    local pos_4 = any_CalculateSegmentAt_result3_2.pos
    local var26 = pos_3 - var24
    local var27 = (pos_4) - (any_CalculateSegmentAt_result3_2.pos + any_CalculateSegmentAt_result3_2.left)
    local var28 = pos_4.X - pos_3.X
    local absolute = math.abs(var26.X)
    local absolute_4 = math.abs(var27.X)
    local var31
    if var28 < absolute then
        var24 = pos_3 - var28 / absolute * var26
    end
    if var28 < absolute_4 then
        var31 = pos_4 - var28 / absolute_4 * var27
    end
    return cubicBezier(any_CalculateSegmentAt_result1, pos_3, var24, var31, pos_4)
end
function module_upvr.CalculateValueAt(arg1, arg2) -- Line 106
    local var33 = 0
    local var34 = 1
    while var33 + 0.00001 < var34 do
        local midpoint = (var33 + var34) / 2
        if arg2 < arg1:CalculatePositionAt(midpoint).X then
            var34 = midpoint
        else
            var33 = midpoint
        end
    end
    local var35 = (var33 + var34) / 2
    return arg1:CalculatePositionAt(var35).Y, var35
end
return module_upvr

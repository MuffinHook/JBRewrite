local module = {}
local exp_upvr = math.exp
local cos_upvr = math.cos
local sin_upvr = math.sin
local function SpringUpdate_upvr(arg1) -- Line 7, Named "SpringUpdate"
    local var5 = tick() - arg1.t
    local Freq = arg1.Freq
    local Damp = arg1.Damp
    local Target = arg1.Target
    local var9 = arg1.p - Target
    local v_2 = arg1.v
    if 1 < Damp then
        local var11 = -Freq * Damp
        local var12 = Freq * (Damp * Damp - 1) ^ 0.5
        local var13 = var11 - var12
        local var14 = var11 + var12
        local var2_result1_2 = exp_upvr(var13 * var5)
        local var2_result1 = exp_upvr(var14 * var5)
        local var17 = (v_2 - var9 * var14) / (-2 * var12)
        local var18 = var9 - var17
        return Target + var17 * var2_result1_2 + var18 * var2_result1, var17 * var13 * var2_result1_2 + var18 * var14 * var2_result1
    end
    if Damp == 1 then
        local var2_result1_3 = exp_upvr(-Freq * var5)
        local var20 = v_2 + Freq * var9
        local var21 = (var20 * var5 + var9) * var2_result1_3
        return Target + var21, var20 * var2_result1_3 - var21 * Freq
    end
    local var22 = Freq * Damp
    local var23 = Freq * (1 - Damp * Damp) ^ 0.5
    local var3_result1 = cos_upvr(var23 * var5)
    local var4_result1 = sin_upvr(var23 * var5)
    local var27 = (v_2 + var22 * var9) / var23
    return Target + exp_upvr(-var22 * var5) * (var9 * var3_result1 + var27 * var4_result1), -exp_upvr(-var22 * var5) * ((var9 * var22 - var27 * var23) * var3_result1 + (var9 * var23 + var27 * var22) * var4_result1)
end
local function SpringSetTarget_upvr(arg1, arg2) -- Line 52, Named "SpringSetTarget"
    local SpringUpdate_upvr_result1, SpringUpdate_upvr_result2 = SpringUpdate_upvr(arg1)
    arg1.p = SpringUpdate_upvr_result1
    arg1.v = SpringUpdate_upvr_result2
    arg1.Target = arg2
    arg1.t = tick()
    return SpringUpdate_upvr_result1, SpringUpdate_upvr_result2
end
local function SingleAABBRaw_upvr(arg1, arg2) -- Line 59, Named "SpringAccelerate"
    local SpringUpdate_upvr_result1_2, SpringUpdate_result2 = SpringUpdate_upvr(arg1)
    arg1.t = tick()
    arg1.p = SpringUpdate_upvr_result1_2
    arg1.v = SpringUpdate_result2 + arg2
end
function module.MakeSpring() -- Line 70
    return {
        p = nil;
        v = nil;
        Target = nil;
        Damp = nil;
        Freq = nil;
        t = tick();
        Update = SpringUpdate_upvr;
        SetTarget = SpringSetTarget_upvr;
        Accelerate = SingleAABBRaw_upvr;
    }
end
module.SpringUpdate = SpringUpdate_upvr
exp_upvr = CFrame.new
local TraceBounceRay_upvr = exp_upvr
cos_upvr = TraceBounceRay_upvr()
local SinkRay_upvr = cos_upvr
sin_upvr = math.cos
local DoesFixedConeIntersectSphere_upvr = sin_upvr
SpringUpdate_upvr = math.sin
local var36_upvr = SpringUpdate_upvr
SpringSetTarget_upvr = SinkRay_upvr.pointToObjectSpace
function SingleAABBRaw_upvr(arg1) -- Line 92, Named "FromAxisAngle"
    local x_2 = arg1.x
    local y_3 = arg1.y
    local z = arg1.z
    local var40 = (x_2 * x_2 + y_3 * y_3 + z * z) ^ 0.5
    if 0.00001 < var40 then
        local var41 = var36_upvr(var40 * 0.5) / var40
        return TraceBounceRay_upvr(0, 0, 0, var41 * x_2, var41 * y_3, var41 * z, DoesFixedConeIntersectSphere_upvr(var40 * 0.5))
    end
    return SinkRay_upvr
end
module.FromAxisAngle = SingleAABBRaw_upvr
function module.SolveIK(arg1, arg2, arg3, arg4, arg5) -- Line 103
    local SpringSetTarget_upvr_result1 = SpringSetTarget_upvr(arg3, arg4)
    local x = SpringSetTarget_upvr_result1.x
    local y = SpringSetTarget_upvr_result1.y
    local z_2 = SpringSetTarget_upvr_result1.z
    local var46 = (x * x + y * y + z_2 * z_2) ^ 0.5
    local var47 = x / var46
    local var48 = y / var46
    local var49 = z_2 / var46
    local var50
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var50 = arg1 + arg2
        return var50
    end
    if arg1 + arg2 >= var46 or not decompInlinedCondition() then
        var50 = var46
    end
    local var51 = var50
    var50 = (arg2 * arg2 - arg1 * arg1 - var51 * var51) / (2 * arg1 * var51)
    local var52 = (1 - var50 * var50) ^ 0.5
    local var53 = (2 * (1 + var52 * var48 + var50 * var49)) ^ 0.5
    local var54 = var53 * 0.5
    local var55 = (var52 * var49 - var50 * var48) / var53
    local var56 = var50 * var47 / var53
    local var57 = -var52 * var47 / var53
    if arg5 then
        local DoesFixedConeIntersectSphere_upvr_result1 = DoesFixedConeIntersectSphere_upvr(arg5 / 2)
        local var36_result1 = var36_upvr(arg5 / 2)
        var57 = DoesFixedConeIntersectSphere_upvr_result1 * var57 + var36_result1 * (var49 * var54 - var48 * var55 + var47 * var56)
        var54 = DoesFixedConeIntersectSphere_upvr_result1 * var54 - var36_result1 * (var47 * var55 + var48 * var56 + var49 * var57)
        var55 = DoesFixedConeIntersectSphere_upvr_result1 * var55 + var36_result1 * (var47 * var54 - var49 * var56 + var48 * var57)
        var56 = DoesFixedConeIntersectSphere_upvr_result1 * var56 + var36_result1 * (var48 * var54 + var49 * var55 - var47 * var57)
    end
    local var60 = (var51 * var50 + arg1) / (var51 * var51 + 2 * var51 * var50 * arg1 + arg1 * arg1) ^ 0.5
    local var61 = ((1 - var60) * 0.5) ^ 0.5
    local var62 = ((1 + var60) * 0.5) ^ 0.5
    return arg3 * TraceBounceRay_upvr(-arg1 * 2 * (var55 * var57 + var56 * var54), arg1 * 2 * (var55 * var54 - var56 * var57), arg1 * (2 * (var55 * var55 + var56 * var56) - 1), var61 * var55 + var62 * var54, var61 * var56 + var62 * var57, var61 * var57 - var62 * var56, var61 * var54 - var62 * var55), arg3 * TraceBounceRay_upvr(0, 0, 0, var55, var56, var57, var54)
end
TraceBounceRay_upvr = Vector3.new()
TraceBounceRay_upvr = TraceBounceRay_upvr.Dot
SinkRay_upvr = math.min
DoesFixedConeIntersectSphere_upvr = math.max
var36_upvr = CFrame.new()
var36_upvr = var36_upvr.components
SpringSetTarget_upvr = math.abs
local OffsetLookAtTarget_upvr = SpringSetTarget_upvr
function SingleAABBRaw_upvr(arg1, arg2, arg3, arg4, arg5) -- Line 167, Named "SingleAABBRaw"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var65
    local var66
    local var67
    local var68
    if arg3 then
        var65 = arg3.x
        var66 = arg3.y
        var67 = arg3.z
    else
        var65 = 1
        var66 = 0
        var67 = 0
    end
    if arg4 then
        var68 = arg4.x
        local y_2 = arg4.y
        local _ = arg4.z
    else
        var68 = 0
    end
    if arg5 then
        local _ = arg5.x
        local _ = arg5.y
        local _ = arg5.z
    else
    end
    local var36_upvr_result1, var36_upvr_result2, var36_upvr_result3, var36_upvr_result4, var36_upvr_result5, var36_upvr_result6, var36_upvr_result7, var36_upvr_result8, var36_result9, var36_upvr_result10, var36_result11, var36_upvr_result12 = var36_upvr(arg1)
    local var86 = 0.5 * arg2.x
    local var87 = 0.5 * arg2.y
    local var88 = 0.5 * arg2.z
    local var89 = var36_upvr_result1 - var36_upvr_result4 * var86 - var36_upvr_result5 * var87 - var36_upvr_result6 * var88
    local var90 = var36_upvr_result2 - var36_upvr_result7 * var86 - var36_upvr_result8 * var87 - var36_result9 * var88
    local var91 = var36_upvr_result3 - var36_upvr_result10 * var86 - var36_result11 * var87 - var36_upvr_result12 * var88
    local var92 = var36_upvr_result1 - var36_upvr_result4 * var86 - var36_upvr_result5 * var87 + var36_upvr_result6 * var88
    local var93 = var36_upvr_result2 - var36_upvr_result7 * var86 - var36_upvr_result8 * var87 + var36_result9 * var88
    local var94 = var36_upvr_result3 - var36_upvr_result10 * var86 - var36_result11 * var87 + var36_upvr_result12 * var88
    local var95 = var36_upvr_result1 - var36_upvr_result4 * var86 + var36_upvr_result5 * var87 - var36_upvr_result6 * var88
    local var96 = var36_upvr_result2 - var36_upvr_result7 * var86 + var36_upvr_result8 * var87 - var36_result9 * var88
    local var97 = var36_upvr_result3 - var36_upvr_result10 * var86 + var36_result11 * var87 - var36_upvr_result12 * var88
    local var98 = var36_upvr_result1 - var36_upvr_result4 * var86 + var36_upvr_result5 * var87 + var36_upvr_result6 * var88
    local var99 = var36_upvr_result2 - var36_upvr_result7 * var86 + var36_upvr_result8 * var87 + var36_result9 * var88
    local var100 = var36_upvr_result3 - var36_upvr_result10 * var86 + var36_result11 * var87 + var36_upvr_result12 * var88
    local var101 = var36_upvr_result1 + var36_upvr_result4 * var86 - var36_upvr_result5 * var87 - var36_upvr_result6 * var88
    local var102 = var36_upvr_result2 + var36_upvr_result7 * var86 - var36_upvr_result8 * var87 - var36_result9 * var88
    local var103 = var36_upvr_result3 + var36_upvr_result10 * var86 - var36_result11 * var87 - var36_upvr_result12 * var88
    local var104 = var36_upvr_result1 + var36_upvr_result4 * var86 - var36_upvr_result5 * var87 + var36_upvr_result6 * var88
    local var105 = var36_upvr_result2 + var36_upvr_result7 * var86 - var36_upvr_result8 * var87 + var36_result9 * var88
    local var106 = var36_upvr_result3 + var36_upvr_result10 * var86 - var36_result11 * var87 + var36_upvr_result12 * var88
    local var107 = var36_upvr_result1 + var36_upvr_result4 * var86 + var36_upvr_result5 * var87 - var36_upvr_result6 * var88
    local var108 = var36_upvr_result2 + var36_upvr_result7 * var86 + var36_upvr_result8 * var87 - var36_result9 * var88
    local var109 = var36_upvr_result3 + var36_upvr_result10 * var86 + var36_result11 * var87 - var36_upvr_result12 * var88
    local var110 = var36_upvr_result1 + var36_upvr_result4 * var86 + var36_upvr_result5 * var87 + var36_upvr_result6 * var88
    local var111 = var36_upvr_result2 + var36_upvr_result7 * var86 + var36_upvr_result8 * var87 + var36_result9 * var88
    local var112 = var36_upvr_result3 + var36_upvr_result10 * var86 + var36_result11 * var87 + var36_upvr_result12 * var88
    local var113 = var65 * var89 + var66 * var90 + var67 * var91
    local var114 = var65 * var92 + var66 * var93 + var67 * var94
    local var115 = var65 * var95 + var66 * var96 + var67 * var97
    local var116 = var65 * var98 + var66 * var99 + var67 * var100
    local var117 = var65 * var101 + var66 * var102 + var67 * var103
    local var118 = var65 * var104 + var66 * var105 + var67 * var106
    local var119 = var65 * var107 + var66 * var108 + var67 * var109
    local var120 = var65 * var110 + var66 * var111 + var67 * var112
    local var121 = var68 * var89 + 1 * var90 + 0 * var91
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    local var122 = var68 * var92 + 1 * var93 + 0 * var94
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    local var123 = var68 * var95 + 1 * var96 + 0 * var97
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    local var124 = var68 * var98 + 1 * var99 + 0 * var100
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    local var125 = var68 * var101 + 1 * var102 + 0 * var103
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    local var126 = var68 * var104 + 1 * var105 + 0 * var106
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    local var127 = var68 * var107 + 1 * var108 + 0 * var109
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    local var128 = var68 * var110 + 1 * var111 + 0 * var112
    local var129 = 0 * var89 + 0 * var90 + 1 * var91
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    local var130 = 0 * var92 + 0 * var93 + 1 * var94
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    local var131 = 0 * var95 + 0 * var96 + 1 * var97
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    local var132 = 0 * var98 + 0 * var99 + 1 * var100
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    local var133 = 0 * var101 + 0 * var102 + 1 * var103
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    local var134 = 0 * var104 + 0 * var105 + 1 * var106
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    local var135 = 0 * var107 + 0 * var108 + 1 * var109
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    local var136 = 0 * var110 + 0 * var111 + 1 * var112
    return SinkRay_upvr(var113, var114, var115, var116, var117, var118, var119, var120), DoesFixedConeIntersectSphere_upvr(var113, var114, var115, var116, var117, var118, var119, var120), SinkRay_upvr(var121, var122, var123, var124, var125, var126, var127, var128), DoesFixedConeIntersectSphere_upvr(var121, var122, var123, var124, var125, var126, var127, var128), SinkRay_upvr(var129, var130, var131, var132, var133, var134, var135, var136), DoesFixedConeIntersectSphere_upvr(var129, var130, var131, var132, var133, var134, var135, var136)
end
local var64_upvr = SingleAABBRaw_upvr
local function MultiAABBRaw_upvr(arg1, arg2, arg3, arg4) -- Line 265, Named "MultiAABBRaw"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var151
    local var152
    local var153
    local var154
    local var155
    local var156
    for _, v in next, arg1 do
        local var64_upvr_result1_5, var64_upvr_result2_7, var64_result3_12, var64_upvr_result4_8, var64_upvr_result5_5, var64_upvr_result6_6 = var64_upvr(v.CFrame, v.Size, arg2, arg3, arg4)
        if not var156 or var64_upvr_result1_5 < var156 then
            var156 = var64_upvr_result1_5
        end
        if not var151 or var151 < var64_upvr_result2_7 then
        end
        if not var152 or var64_result3_12 < var152 then
        end
        if not var153 or var153 < var64_upvr_result4_8 then
        end
        if not var154 or var64_upvr_result5_5 < var154 then
        end
        if not var155 or var155 < var64_upvr_result6_6 then
        end
    end
    return var156, var64_upvr_result2_7, var64_result3_12, var64_upvr_result4_8, var64_upvr_result5_5, var64_upvr_result6_6
end
local function _(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8) -- Line 365, Named "IntersectSegSeg"
    local var339 = (arg8 - arg6) * (arg3 - arg1) - (arg7 - arg5) * (arg4 - arg2)
    local var340 = (arg7 - arg5) * (arg2 - arg6) - (arg8 - arg6) * (arg1 - arg5)
    if OffsetLookAtTarget_upvr(var340) < 0.001 and OffsetLookAtTarget_upvr((arg3 - arg1) * (arg2 - arg6) - (arg4 - arg2) * (arg1 - arg5)) < 0.001 and OffsetLookAtTarget_upvr(var339) < 0.001 then
        return true
    end
    if OffsetLookAtTarget_upvr(var339) < 0.001 then
        return false
    end
    local var341 = var340 / var339
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    local var342 = ((arg3 - arg1) * (arg2 - arg6) - (arg4 - arg2) * (arg1 - arg5)) / var339
    if var341 <= 0 or 1 < var341 or var342 <= 0 or 1 < var342 then
        return false
    end
    return true
end
function module.SingleAABB(arg1, arg2) -- Line 245
    local var64_result1_4, var64_upvr_result2, var64_result3_3, var64_result4, var64_result5_2, var64_result6_9 = var64_upvr(arg1, arg2, Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1))
    return CFrame.new(0.5 * (var64_result1_4 + var64_upvr_result2), 0.5 * (var64_result3_3 + var64_result4), 0.5 * (var64_result5_2 + var64_result6_9), 1, 0, 0, 0, 1, 0, 0, 0, 1), Vector3.new(var64_upvr_result2 - var64_result1_4, var64_result4 - var64_result3_3, var64_result6_9 - var64_result5_2)
end
module.SingleAABBRaw = var64_upvr
function module.MultiAABB(arg1) -- Line 291
    local MultiAABBRaw_upvr_result1, MultiAABBRaw_upvr_result2, MultiAABBRaw_upvr_result3, MultiAABBRaw_upvr_result4, MultiAABBRaw_upvr_result5, MultiAABBRaw_upvr_result6 = MultiAABBRaw_upvr(arg1, Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1))
    return CFrame.new(0.5 * (MultiAABBRaw_upvr_result1 + MultiAABBRaw_upvr_result2), 0.5 * (MultiAABBRaw_upvr_result3 + MultiAABBRaw_upvr_result4), 0.5 * (MultiAABBRaw_upvr_result5 + MultiAABBRaw_upvr_result6), 1, 0, 0, 0, 1, 0, 0, 0, 1), Vector3.new(MultiAABBRaw_upvr_result2 - MultiAABBRaw_upvr_result1, MultiAABBRaw_upvr_result4 - MultiAABBRaw_upvr_result3, MultiAABBRaw_upvr_result6 - MultiAABBRaw_upvr_result5)
end
module.MultiAABBRaw = MultiAABBRaw_upvr
function module.IntersectAABB(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12) -- Line 310
    local var173 = false
    if arg1 <= arg8 then
        var173 = false
        if arg7 <= arg2 then
            var173 = false
            if arg3 <= arg10 then
                var173 = false
                if arg9 <= arg4 then
                    var173 = false
                    if arg5 <= arg12 then
                        if arg11 > arg6 then
                            var173 = false
                        else
                            var173 = true
                        end
                    end
                end
            end
        end
    end
    return var173
end
function module.IntersectPrism(arg1, arg2, arg3, arg4) -- Line 313
    local var64_result1_9, var64_result2_11, var64_result3_13, var64_upvr_result4_5, var64_upvr_result5_4, var64_result6_14 = var64_upvr(arg1, arg2)
    local var64_upvr_result1, var64_result2_9, var64_result3_15, var64_result4_4, var64_result5_6, var64_result6_16 = var64_upvr(arg3, arg4)
    local var238 = false
    if var64_result1_9 <= var64_result2_9 then
        var238 = false
        if var64_upvr_result1 <= var64_result2_11 then
            var238 = false
            if var64_result3_13 <= var64_result4_4 then
                var238 = false
                if var64_result3_15 <= var64_upvr_result4_5 then
                    var238 = false
                    if var64_upvr_result5_4 <= var64_result6_16 then
                        if var64_result5_6 > var64_result6_14 then
                            var238 = false
                        else
                            var238 = true
                        end
                    end
                end
            end
        end
    end
    return var238
end
function module.IntersectMultiPrism(arg1) -- Line 318
    for i_2 = 1, #arg1 do
        local var319 = arg1[i_2]
        local var64_result1_8, var64_upvr_result2_5, var64_result3_9, var64_upvr_result4_4, var64_result5_8, var64_result6 = var64_upvr(var319.CFrame, var319.Size, Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1))
        for i_3 = i_2 + 1, #arg1 do
            local var326 = arg1[i_3]
            local var64_upvr_result1_2, var64_result2_8, var64_result3_10, var64_result4_9, var64_result5_15, var64_result6_12 = var64_upvr(var326.CFrame, var326.Size, Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1))
            local var333 = false
            if var64_result1_8 <= var64_result2_8 then
                var333 = false
                if var64_upvr_result1_2 <= var64_upvr_result2_5 then
                    var333 = false
                    if var64_result3_9 <= var64_result4_9 then
                        var333 = false
                        if var64_result3_10 <= var64_upvr_result4_4 then
                            var333 = false
                            if var64_result5_8 <= var64_result6_12 then
                                if var64_result5_15 > var64_result6 then
                                    var333 = false
                                else
                                    var333 = true
                                end
                            end
                        end
                    end
                end
            end
            if var333 then
                return true
            end
        end
    end
    return false
end
function module.IntersectRectangleRaw(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8) -- Line 335
    local var334 = false
    if arg1 <= arg6 then
        var334 = false
        if arg5 <= arg2 then
            var334 = false
            if arg3 <= arg8 then
                if arg7 > arg4 then
                    var334 = false
                else
                    var334 = true
                end
            end
        end
    end
    return var334
end
function module.ContainRectangleRaw(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8) -- Line 339
    local var335 = false
    if arg5 <= arg1 then
        var335 = false
        if arg2 <= arg6 then
            var335 = false
            if arg7 <= arg3 then
                if arg4 > arg8 then
                    var335 = false
                else
                    var335 = true
                end
            end
        end
    end
    return var335
end
function module.IsPointInRectangleRaw(arg1, arg2, arg3, arg4, arg5, arg6) -- Line 342
    local var336 = false
    if arg3 <= arg1 then
        var336 = false
        if arg1 <= arg4 then
            var336 = false
            if arg5 <= arg2 then
                if arg2 > arg6 then
                    var336 = false
                else
                    var336 = true
                end
            end
        end
    end
    return var336
end
function module.IntersectRayPlane(arg1, arg2, arg3, arg4) -- Line 350
    local TraceBounceRay_upvr_result1_2 = TraceBounceRay_upvr(arg2, arg4)
    if OffsetLookAtTarget_upvr(TraceBounceRay_upvr_result1_2) <= 0.000001 then
        return false
    end
    local TraceBounceRay_upvr_result1 = TraceBounceRay_upvr(arg3 - arg1, arg4)
    if 0 < TraceBounceRay_upvr_result1 then
        return false
    end
    return true, arg1 + (arg2) * (TraceBounceRay_upvr_result1 / TraceBounceRay_upvr_result1_2)
end
TraceBounceRay_upvr = math.cos
SinkRay_upvr = math.tan
function DoesFixedConeIntersectSphere_upvr(arg1, arg2, arg3, arg4, arg5, arg6) -- Line 399, Named "DoesFixedConeIntersectSphere"
    local var343 = arg5 - arg1
    if arg3 <= arg2:Dot(var343) then
        return false
    end
    local any_Dot_result1 = var343:Dot(arg2)
    local TraceBounceRay_upvr_result1_3 = TraceBounceRay_upvr(arg4)
    if ((var343:Dot(var343) - any_Dot_result1 * any_Dot_result1) ^ 0.5 - any_Dot_result1 * SinkRay_upvr(arg4)) * TraceBounceRay_upvr_result1_3 > arg6 then
        TraceBounceRay_upvr_result1_3 = false
    else
        TraceBounceRay_upvr_result1_3 = true
    end
    return TraceBounceRay_upvr_result1_3
end
module.DoesFixedConeIntersectSphere = DoesFixedConeIntersectSphere_upvr
TraceBounceRay_upvr = math.asin
SinkRay_upvr = math.atan
DoesFixedConeIntersectSphere_upvr = math.cos
var36_upvr = math.sin
function OffsetLookAtTarget_upvr(arg1, arg2, arg3, arg4, arg5, arg6) -- Line 428, Named "OffsetLookAtTarget"
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    do
        return 0, 0
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
module.OffsetLookAtTarget = OffsetLookAtTarget_upvr
function TraceBounceRay_upvr(arg1, arg2, arg3, arg4) -- Line 445, Named "TraceBounceRay"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var346
    repeat
        local workspace_FindPartOnRayWithIgnoreList_result1_2, workspace_FindPartOnRayWithIgnoreList_result2_2, workspace_FindPartOnRayWithIgnoreList_result3 = workspace:FindPartOnRayWithIgnoreList(Ray.new(var346, arg2 * arg3), arg4)
        local Magnitude_2 = (workspace_FindPartOnRayWithIgnoreList_result2_2 - var346).Magnitude
        var346 = workspace_FindPartOnRayWithIgnoreList_result2_2
        if workspace_FindPartOnRayWithIgnoreList_result1_2 then
            if workspace_FindPartOnRayWithIgnoreList_result1_2.CanCollide then
            end
        end
    until arg3 - Magnitude_2 <= 0 and Magnitude_2 < 0.001 and 10 < 0 + 1
    return var346, arg2 - 2 * arg2:Dot(workspace_FindPartOnRayWithIgnoreList_result3) * workspace_FindPartOnRayWithIgnoreList_result3
end
function SinkRay_upvr(arg1, arg2, arg3, arg4) -- Line 468, Named "SinkRay"
    local var351
    repeat
        local workspace_FindPartOnRayWithIgnoreList_result1, workspace_FindPartOnRayWithIgnoreList_result2, _ = workspace:FindPartOnRayWithIgnoreList(Ray.new(var351, arg2 * arg3), arg4)
        local Magnitude = (workspace_FindPartOnRayWithIgnoreList_result2 - var351).Magnitude
        var351 = workspace_FindPartOnRayWithIgnoreList_result2
        if workspace_FindPartOnRayWithIgnoreList_result1 then
            if workspace_FindPartOnRayWithIgnoreList_result1.CanCollide then
                return var351, arg2, workspace_FindPartOnRayWithIgnoreList_result1
            end
            table.insert(arg4, workspace_FindPartOnRayWithIgnoreList_result1)
        end
    until arg3 - Magnitude <= 0 and Magnitude < 0.001 and 10 < 0 + 1
    return var351, arg2
end
module.SinkRay = SinkRay_upvr
module.TraceBounceRay = TraceBounceRay_upvr
return module
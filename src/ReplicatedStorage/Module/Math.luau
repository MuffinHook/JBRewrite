local new_upvr = Vector3.new
local new_upvr_2 = CFrame.new
local const_vector = Vector3.new(0, 0, 0)
local new_upvr_2_result1_upvr = new_upvr_2()
local Cross_upvr = const_vector.Cross
local Dot_upvr = const_vector.Dot
local cos_upvr = math.cos
local sin_upvr = math.sin
local acos_upvr = math.acos
local asin_upvr = math.asin
local atan2_upvr = math.atan2
local components_upvr = new_upvr_2_result1_upvr.components
local abs_upvr = math.abs
local floor_upvr = math.floor
local random_upvr = math.random
local module_2_upvr = {
    ContinuousSpring1 = function(arg1, arg2, arg3, arg4, arg5, arg6) -- Line 29, Named "ContinuousSpring1"
        return arg2 + arg3 * arg6 * arg4, arg3 + (arg1 - arg2 - arg3) * arg6 * arg5
    end;
    ContinuousSpring3 = module_2_upvr.ContinuousSpring1;
    ContinuousSpring3F = function(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12) -- Line 33, Named "ContinuousSpring3F"
        return arg4 + arg7 * arg12 * arg10, arg6 + arg9 * arg12 * arg10, arg6 + arg9 * arg12 * arg10, arg7 + (arg1 - arg4 - arg7) * arg12 * arg11, arg8 + (arg2 - arg5 - arg8) * arg12 * arg11, arg9 + (arg3 - arg6 - arg9) * arg12 * arg11
    end;
    MakeSpring = function(arg1, arg2, arg3) -- Line 45, Named "MakeSpring"
        local var17
        if typeof(arg1) == "Vector3" then
            var17 = Vector3.new(0, 0, 0)
        else
            var17 = 0
        end
        local module = {}
        module.t = arg1
        module.p = arg1 or var17
        module.v = var17
        module.s = arg2 or 10
        module.d = arg3 or 0.5
        module.t0 = 0
        return module
    end;
    Spring = function(arg1, arg2) -- Line 56, Named "Spring"
        local t = arg1.t
        local p = arg1.p
        local v = arg1.v
        local s = arg1.s
        local d = arg1.d
        local var24 = tick() - arg1.t0
        if s == 0 then
            return p, v
        end
        if d < 1 then
            local var25 = (1 - d * d) ^ 0.5
            local var26 = p - t
            local var27 = (d * var26 + v / s) / var25
            local var28 = 2.718281828459045 ^ (-d * s * var24)
            local var7_result1_3 = cos_upvr(var25 * s * var24)
            local sin_upvr_result1 = sin_upvr(var25 * s * var24)
            return t + (var26 * var7_result1_3 + var27 * sin_upvr_result1) * var28, ((var26 * d - d * var27 - v) * var7_result1_3 + (var26 * var25 + var27 * d) * sin_upvr_result1) * -var28
        end
        if 1 < d then
            assert(false, "not implemented")
        else
            local var31 = p - t
            local var32 = var31 + v / s
            local var33 = 2.718281828459045 ^ (-s * var24)
            return t + (var31 + var32 * s * var24) * var33, s * (var32 - var31 - var32 * s * var24) * var33
        end
    end;
}
function module_2_upvr.SpringSetTarget(arg1, arg2) -- Line 79
    local tick_result1 = tick()
    local any_Spring_result1, any_Spring_result2 = module_2_upvr.Spring(arg1, tick_result1)
    arg1.p = any_Spring_result1
    arg1.v = any_Spring_result2
    arg1.t0 = tick_result1
    arg1.t = arg2
end
function module_2_upvr.SpringAccelerate(arg1, arg2) -- Line 87
    local tick_result1_2 = tick()
    local any_Spring_result1_2, any_Spring_result2_2 = module_2_upvr.Spring(arg1, tick_result1_2)
    arg1.p = any_Spring_result1_2
    arg1.v = any_Spring_result2_2 + arg2
    arg1.t0 = tick_result1_2
end
function module_2_upvr.MakeWorldSpring() -- Line 95
    return {
        Part = nil;
        Target = nil;
        k = 200;
        B = 15;
        f3 = nil;
    }
end
function module_2_upvr.WorldSpringUpdate(arg1, arg2) -- Line 104
    local Part = arg1.Part
    local Target = arg1.Target
    local var43
    if Target then
        var43 = arg1.k * Target - arg1.B * Part.CFrame:vectorToObjectSpace(Part.Velocity)
    else
        var43 = Vector3.new(0, 0, 0)
    end
    arg1.f3 = var43
end
function module_2_upvr.WorldSpringSetTarget(arg1, arg2) -- Line 116
    arg1.Target = arg2 - arg1.Part.Position
end
function module_2_upvr.CrossMagSq(arg1, arg2) -- Line 130
    local var6_result1 = Dot_upvr(arg1, arg2)
    return Dot_upvr(arg1, arg1) * Dot_upvr(arg2, arg2) - var6_result1 * var6_result1
end
function module_2_upvr.CrossMagSqF(arg1, arg2, arg3, arg4, arg5, arg6) -- Line 134
    local var45 = arg1 * arg4 + arg2 * arg5 + arg3 * arg6
    return (arg1 * arg1 + arg2 * arg2 + arg3 * arg3) * (arg4 * arg4 + arg5 * arg5 + arg6 * arg6) - var45 * var45
end
function module_2_upvr.CFrameFromAxisAngle(arg1) -- Line 138
    local var46 = Dot_upvr(arg1, arg1) ^ 0.5
    if 0.000001 < var46 then
        local var47 = sin_upvr(var46 * 0.5) / var46
        return new_upvr_2(0, 0, 0, var47 * arg1.x, var47 * arg1.y, var47 * arg1.z, cos_upvr(var46 * 0.5))
    end
    return new_upvr_2_result1_upvr
end
function module_2_upvr.CFrameFromAxisAngleF(arg1, arg2, arg3) -- Line 146
    local var48 = (arg1 * arg1 + arg2 * arg2 + arg3 * arg3) ^ 0.5
    if 0.000001 < var48 then
        local var49 = sin_upvr(var48 * 0.5) / var48
        return new_upvr_2(0, 0, 0, var49 * arg1, var49 * arg2, var49 * arg3, cos_upvr(var48 * 0.5))
    end
    return new_upvr_2_result1_upvr
end
function module_2_upvr.CFrameToAxisAngleF(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9) -- Line 154
    local var50 = (arg1 + arg5 + arg9 - 1) * 0.5
    if var50 < -0.99999 then
        local var51 = arg1 + arg2 + arg3 + 1
        local var52 = arg4 + arg5 + arg6 + 1
        local var53 = arg7 + arg8 + arg9 + 1
        local var54 = math.pi * (var51 * var51 + var52 * var52 + var53 * var53) ^ -0.5
        return var54 * var51, var54 * var52, var54 * var53
    end
    if var50 < 0.99999 then
        local var55 = arg8 - arg6
        local var56 = arg3 - arg7
        local var57 = arg4 - arg2
        local var58 = acos_upvr(var50) * (var55 * var55 + var56 * var56 + var57 * var57) ^ -0.5
        return var58 * var55, var58 * var56, var58 * var57
    end
    return 0, 0, 0
end
function module_2_upvr.CFrameToAxisAngle(arg1) -- Line 173
    local _, _, _, var12_result4_3, var12_result5_2, var12_result6, var12_result7, var12_result8_3, var12_result9, components_upvr_result10_2, var12_result11, var12_result12 = components_upvr(arg1)
    return new_upvr(module_2_upvr.CFrameToAxisAngleF(var12_result4_3, var12_result5_2, var12_result6, var12_result7, var12_result8_3, var12_result9, components_upvr_result10_2, var12_result11, var12_result12))
end
function module_2_upvr.UnitVectorToAnglesYXF(arg1, arg2, arg3) -- Line 178
    return asin_upvr(arg2), atan2_upvr(-arg1, -arg3)
end
function module_2_upvr.UnitVectorToAnglesYX(arg1) -- Line 181
    return module_2_upvr.UnitVectorToAnglesYXF(arg1.x, arg1.y, arg1.z)
end
function module_2_upvr.VectorToAnglesYXF(arg1, arg2, arg3) -- Line 184
    return asin_upvr(arg2 / (arg1 * arg1 + arg2 * arg2 + arg3 * arg3) ^ 0.5), atan2_upvr(-arg1, -arg3)
end
function module_2_upvr.VectorToAnglesYX(arg1) -- Line 187
    return module_2_upvr.VectorToAnglesYXF(arg1.x, arg1.y, arg1.z)
end
function module_2_upvr.VectorFromAnglesYX(arg1, arg2) -- Line 190
    local var7_result1 = cos_upvr(arg1)
    return new_upvr(-var7_result1 * sin_upvr(arg2), sin_upvr(arg1), -var7_result1 * cos_upvr(arg2))
end
function module_2_upvr.Quaternion(arg1, arg2) -- Line 202
    local var6_result1_2 = Dot_upvr(arg1, arg2)
    local var5_result1 = Cross_upvr(arg1, arg2)
    local var74 = (2 * (1 + var6_result1_2)) ^ 0.5
    return new_upvr_2(0, 0, 0, var5_result1.x / var74, var5_result1.y / var74, var5_result1.z / var74, (1 + var6_result1_2) / var74)
end
function module_2_upvr.QuaternionF(arg1, arg2, arg3, arg4, arg5, arg6) -- Line 208
    local var75 = 1 + arg1 * arg4 + arg2 * arg5 + arg3 * arg6
    local var76 = (2 * var75) ^ 0.5
    return new_upvr_2(0, 0, 0, (arg2 * arg6 - arg3 * arg5) / var76, (arg3 * arg4 - arg1 * arg6) / var76, (arg1 * arg5 - arg2 * arg4) / var76, var75 / var76)
end
local inverse_upvr = new_upvr_2_result1_upvr.inverse
local fromAxisAngle_upvr = CFrame.fromAxisAngle
function module_2_upvr.AxisAngleInterpolate(arg1, arg2, arg3) -- Line 216
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local _, _, _, var12_result4, var12_result5_4, var12_result6_2, components_upvr_result7, var12_result8_2, var12_result9_2, var12_result10, components_upvr_result11_2, var12_result12_2 = components_upvr(inverse_upvr(arg1) * arg2)
    local var91 = (var12_result4 + var12_result8_2 + var12_result12_2 - 1) * 0.5
    local var92
    if 1 < var91 then
        var92 = 1
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if var91 < -1 then
        var92 = -1
    else
        var92 = var91
    end
    do
        return arg1 * fromAxisAngle_upvr(new_upvr(components_upvr_result11_2 - var12_result9_2, var12_result6_2 - var12_result10, components_upvr_result7 - var12_result5_4), acos_upvr(var92) * arg3) + (arg2.p - arg1.p) * arg3
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_2_upvr.IsPointInPolygonXZ(arg1, arg2) -- Line 226
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local Z_6 = arg1.Z
    local len_2 = #arg2
    local const_number = 0
    local var105
    while len_2 > const_number do
        local var106 = arg2[const_number + 1]
        local var107 = arg2[len_2 - 1 + 1]
        local X = var106.X
        local Z_2 = var106.Z
        local Z_3 = var107.Z
        if Z_6 >= Z_2 then
            var105 = false
        else
            var105 = true
        end
        if Z_6 >= Z_3 then
        else
        end
        if var105 ~= true then
            var105 = (var107.X - X) * (Z_6 - Z_2) / (Z_3 - Z_2) + X
            if arg1.X < var105 then
            end
        end
    end
    return not false
end
function module_2_upvr.IsPointInRectangleYZ(arg1, arg2, arg3) -- Line 244
    local var115 = arg2:pointToObjectSpace(arg1) + arg3 * 0.5
    local var116 = false
    if 0 <= var115.y then
        var116 = false
        if var115.y < arg3.y then
            var116 = false
            if 0 <= var115.z then
                if var115.z >= arg3.z then
                    var116 = false
                else
                    var116 = true
                end
            end
        end
    end
    return var116
end
function module_2_upvr.IsPointInRectangleXY(arg1, arg2, arg3) -- Line 248
    local var117 = arg2:pointToObjectSpace(arg1) + arg3 * 0.5
    local var118 = false
    if 0 <= var117.x then
        var118 = false
        if var117.x < arg3.x then
            var118 = false
            if 0 <= var117.y then
                if var117.y >= arg3.y then
                    var118 = false
                else
                    var118 = true
                end
            end
        end
    end
    return var118
end
function module_2_upvr.IsPointInRectangleXZ(arg1, arg2, arg3) -- Line 252
    local var119 = arg2:pointToObjectSpace(arg1) + arg3 * 0.5
    local var120 = false
    if 0 <= var119.x then
        var120 = false
        if var119.x < arg3.x then
            var120 = false
            if 0 <= var119.z then
                if var119.z >= arg3.z then
                    var120 = false
                else
                    var120 = true
                end
            end
        end
    end
    return var120
end
function module_2_upvr.IsPointInPrism(arg1, arg2, arg3) -- Line 256
    local var123 = arg2:pointToObjectSpace(arg1) + arg3 * 0.5
    local var124 = false
    if 0 <= var123.x then
        var124 = false
        if var123.x < arg3.x then
            var124 = false
            if 0 <= var123.y then
                var124 = false
                if var123.y < arg3.y then
                    var124 = false
                    if 0 <= var123.z then
                        if var123.z >= arg3.z then
                            var124 = false
                        else
                            var124 = true
                        end
                    end
                end
            end
        end
    end
    return var124
end
function module_2_upvr.IsPointInFixedCone(arg1, arg2, arg3, arg4) -- Line 260
    local var125 = arg4 - arg1.p
    local var126 = false
    if -arg3 <= var125.z then
        if acos_upvr(Dot_upvr(arg1.lookVector, var125.unit)) > arg2 then
            var126 = false
        else
            var126 = true
        end
    end
    return var126
end
local tan_upvr = math.tan
function module_2_upvr.DoesFixedConeIntersectSphere(arg1, arg2, arg3, arg4, arg5, arg6) -- Line 265
    local var128 = arg5 - arg1
    if arg3 <= arg2:Dot(var128) then
        return false
    end
    local any_Dot_result1 = var128:Dot(arg2)
    local var7_result1_2 = cos_upvr(arg4)
    if ((var128:Dot(var128) - any_Dot_result1 * any_Dot_result1) ^ 0.5 - any_Dot_result1 * tan_upvr(arg4)) * var7_result1_2 > arg6 then
        var7_result1_2 = false
    else
        var7_result1_2 = true
    end
    return var7_result1_2
end
function module_2_upvr.TopPoint(arg1, arg2) -- Line 286
    return arg1 * new_upvr(0, arg2.y * 0.5, 0)
end
function module_2_upvr.BottomPoint(arg1, arg2) -- Line 289
    return module_2_upvr.TopPoint(arg1, -arg2)
end
function module_2_upvr.Normal(arg1) -- Line 299
    return arg1.upVector
end
function module_2_upvr.IntersectRayPlane(arg1, arg2, arg3, arg4) -- Line 303
    local var6_result1_3 = Dot_upvr(arg4, arg2)
    if abs_upvr(var6_result1_3) < 0.000001 then return end
    local var132 = Dot_upvr(arg4, arg3 - arg1) / var6_result1_3
    if var132 < 0 then return end
    return arg1 + arg2 * var132
end
function module_2_upvr.IntersectRectanglesByCornersF(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8) -- Line 316
    local var135 = true
    if arg7 > arg1 then
        var135 = true
        if arg3 > arg5 then
            var135 = true
            if arg8 > arg2 then
                if arg4 > arg6 then
                    var135 = false
                else
                    var135 = true
                end
            end
        end
    end
    return not var135
end
function module_2_upvr.IntersectRectanglesF(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8) -- Line 319
    local var136 = 0.5 * arg5
    local var137 = 0.5 * arg6
    local var138 = 0.5 * arg7
    local var139 = 0.5 * arg8
    return module_2_upvr.IntersectRectanglesByCornersF(arg1 - var136, arg2 - var137, arg1 + var136, arg2 + var137, arg3 - var138, arg4 - var139, arg3 + var138, arg4 + var139)
end
function module_2_upvr.IntersectRectanglesXZ(arg1, arg2, arg3, arg4) -- Line 325
    return module_2_upvr.IntersectRectanglesF(arg1.x, arg1.z, arg2.x, arg2.z, arg3.x, arg3.z, arg4.x, arg4.z)
end
function module_2_upvr.Round(arg1, arg2) -- Line 328
    return floor_upvr(arg1 / arg2 + 0.5) * arg2
end
function module_2_upvr.RoundVec(arg1, arg2) -- Line 331
    return new_upvr(floor_upvr(arg1.x / arg2 + 0.5) * arg2, floor_upvr(arg1.y / arg2 + 0.5) * arg2, floor_upvr(arg1.z / arg2 + 0.5) * arg2)
end
module_2_upvr.Clamp = math.clamp
function module_2_upvr.AABBXZF(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12) -- Line 336
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var140 = 0.5 * arg10
    local var141 = 0.5 * arg12
    local var142 = -arg1 * var140 - arg3 * var141
    local var143 = var142
    local var144 = -arg1 * var140 + arg3 * var141
    local var145 = -arg7 * var140 + arg9 * var141
    local var146
    if var144 < var142 then
        var142 = var144
    elseif var143 <= var144 then
        var143 = var144
    end
    if var145 < var146 then
        var146 = var145
    elseif -arg7 * var140 - arg9 * var141 <= var145 then
    end
    local var147 = arg1 * var140 - arg3 * var141
    local var148 = arg7 * var140 - arg9 * var141
    if var147 < var142 then
    elseif var143 <= var147 then
        var143 = var147
    end
    if var148 < var146 then
        var146 = var148
    elseif var145 <= var148 then
    end
    local var149 = arg1 * var140 + arg3 * var141
    local var150 = arg7 * var140 + arg9 * var141
    if var149 < var147 then
    elseif var143 <= var149 then
        var143 = var149
    end
    if var150 < var146 then
        var146 = var150
    elseif var148 <= var150 then
    end
    return var143 - var149, var150 - var146
end
function module_2_upvr.AABBXZ(arg1, arg2) -- Line 375
    local _, _, _, var12_result4_4, var12_result5, var12_result6_3, var12_result7_3, components_upvr_result8, var12_result9_3, components_upvr_result10_3, var12_result11_2, components_upvr_result12 = components_upvr(arg1)
    return module_2_upvr.AABBXZF(var12_result4_4, var12_result5, var12_result6_3, var12_result7_3, components_upvr_result8, var12_result9_3, components_upvr_result10_3, var12_result11_2, components_upvr_result12, arg2.x, arg2.y, arg2.z)
end
function module_2_upvr.IsPrismVisibleD(arg1, arg2, arg3) -- Line 380
    local lookVector_3 = arg2.lookVector
    local x_2 = arg2.x
    local y_4 = arg2.y
    local z_3 = arg2.z
    local x = lookVector_3.x
    local y = lookVector_3.y
    local z_5 = lookVector_3.z
    local var12_result1, var12_result2, components_upvr_result3, var12_result4_2, var12_result5_3, var12_result6_4, var12_result7_2, var12_result8, var12_result9_4, components_upvr_result10, components_upvr_result11, var12_result12_3 = components_upvr(arg3.CFrame)
    local var182 = arg3.Size * 0.5
    local x_5 = var182.x
    local y_5 = var182.y
    local z_4 = var182.z
    local var186 = x_5 * var12_result4_2
    local var187 = y_5 * var12_result5_3
    local var188 = z_4 * var12_result6_4
    local var189 = x_5 * var12_result7_2
    local var190 = y_5 * var12_result8
    local var191 = z_4 * var12_result9_4
    local var192 = x_5 * components_upvr_result10
    local var193 = y_5 * components_upvr_result11
    local var194 = z_4 * var12_result12_3
    local var195 = var12_result1 + var186 + var187 + var188
    local var196 = var12_result2 + var189 + var190 + var191
    local var197 = components_upvr_result3 + var192 + var193 + var194
    local var198 = var12_result1 - var186 - var187 - var188
    local var199 = var12_result2 - var189 - var190 - var191
    local var200 = components_upvr_result3 - var192 - var193 - var194
    local var201 = var195 - x_2
    local var202 = var196 - y_4
    local var203 = var197 - z_3
    local var204 = (var201 * var201 + var202 * var202 + var203 * var203) ^ -0.5
    if acos_upvr((x) * (var201 * var204) + (y) * (var202 * var204) + (z_5) * (var203 * var204)) < arg1 then
        return true
    end
    local var205 = var198 - x_2
    local var206 = var199 - y_4
    local var207 = var200 - z_3
    local var208 = (var205 * var205 + var206 * var206 + var207 * var207) ^ -0.5
    if acos_upvr((x) * (var205 * var208) + (y) * (var206 * var208) + (z_5) * (var207 * var208)) < arg1 then
        return true
    end
    local var209 = var198 - x_2
    local var210 = var196 - y_4
    local var211 = var197 - z_3
    local var212 = (var209 * var209 + var210 * var210 + var211 * var211) ^ -0.5
    if acos_upvr((x) * (var209 * var212) + (y) * (var210 * var212) + (z_5) * (var211 * var212)) < arg1 then
        return true
    end
    local var213 = var195 - x_2
    local var214 = var199 - y_4
    local var215 = var200 - z_3
    local var216 = (var213 * var213 + var214 * var214 + var215 * var215) ^ -0.5
    if acos_upvr((x) * (var213 * var216) + (y) * (var214 * var216) + (z_5) * (var215 * var216)) < arg1 then
        return true
    end
    return false
end
function module_2_upvr.IsPrismVisible(arg1, arg2, arg3, arg4) -- Line 425
    local var217 = 0.5 * arg4
    local x_4 = var217.x
    local y_2 = var217.y
    local z_2 = var217.z
    local _, arg1_result2_10 = arg1(arg2, arg3 * new_upvr(x_4, y_2, z_2))
    if arg1_result2_10 then
        return true
    end
    local arg1_result1, arg1_result2 = arg1(arg2, arg3 * new_upvr(-x_4, -y_2, -z_2))
    if arg1_result2 then
        return true
    end
    local _, arg1_result2_3 = arg1(arg2, arg3 * new_upvr(x_4, y_2, -z_2))
    if arg1_result2_3 then
        return true
    end
    local _, arg1_result2_9 = arg1(arg2, arg3 * new_upvr(-x_4, y_2, z_2))
    if arg1_result2_9 then
        return true
    end
    local _, arg1_result2_8 = arg1(arg2, arg3 * new_upvr(-x_4, y_2, -z_2))
    if arg1_result2_8 then
        return true
    end
    local _, arg1_result2_7 = arg1(arg2, arg3 * new_upvr(x_4, -y_2, z_2))
    if arg1_result2_7 then
        return true
    end
    local _, arg1_result2_6 = arg1(arg2, arg3 * new_upvr(x_4, -y_2, -z_2))
    if arg1_result2_6 then
        return true
    end
    local _, arg1_result2_2 = arg1(arg2, arg3 * new_upvr(-x_4, -y_2, z_2))
    if arg1_result2_2 then
        return true
    end
end
function module_2_upvr.IsPrismApproxVisible(arg1, arg2, arg3, arg4) -- Line 469
    local var237 = 0.5 * arg4 * 2
    local x_3 = var237.x
    local y_3 = var237.y
    local z = var237.z
    local _, arg1_result2_5 = arg1(arg2, arg3 * new_upvr(x_3, y_3, z))
    if arg1_result2_5 then
        return true
    end
    local _, arg1_result2_4 = arg1(arg2, arg3 * new_upvr(-x_3, -y_3, -z))
    if arg1_result2_4 then
        return true
    end
    return false
end
function module_2_upvr.IntersectRaySphereF(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11) -- Line 496
    local var245 = arg8 - arg1
    local var246 = arg9 - arg2
    local var247 = arg10 - arg3
    local var248 = var245 * arg4 + var246 * arg5 + var247 * arg6
    if var248 < 0 then
        return false
    end
    local var249 = var245 * var245 + var246 * var246 + var247 * var247 - var248 * var248
    local var250 = arg11 * arg11
    if var250 < var249 then
        return false
    end
    if arg7 < var248 - (var250 - var249) ^ 0.5 then
        return false
    end
    return true
end
function module_2_upvr.IntersectRaySphere(arg1, arg2, arg3, arg4, arg5) -- Line 523
    local var251 = arg4.x - arg1.x
    local var252 = arg4.y - arg1.y
    local var253 = arg4.z - arg1.z
    local var254 = var251 * arg2.x + var252 * arg2.y + var253 * arg2.z
    if var254 < 0 then
        return false
    end
    local var255 = var251 * var251 + var252 * var252 + var253 * var253 - var254 * var254
    local var256 = arg5 * arg5
    if var256 < var255 then
        return false
    end
    if arg3 < var254 - (var256 - var255) ^ 0.5 then
        return false
    end
    return true
end
function module_2_upvr.GUID() -- Line 541
    return "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx":gsub("[xy]", function(arg1) -- Line 543
        if arg1 ~= 'x' or not random_upvr(0, 15) then
        end
        return "%x":format(random_upvr(8, 11))
    end)
end
function module_2_upvr.ShortGUID() -- Line 548
    return "xxx-yx":gsub("[xy]", function(arg1) -- Line 550
        if arg1 ~= 'x' or not random_upvr(0, 15) then
        end
        return "%x":format(random_upvr(8, 11))
    end)
end
module_2_upvr.Base85UUID = require(game:GetService("ReplicatedStorage").Std.String).base85UUID
function module_2_upvr.Uniform2D(arg1) -- Line 556
    local var15_result1_2 = random_upvr()
    local var15_result1 = random_upvr()
    if var15_result1 < var15_result1_2 then
        var15_result1 = var15_result1_2
        var15_result1_2 = var15_result1
    end
    return new_upvr(var15_result1 * arg1 * cos_upvr((-math.pi*2) * var15_result1_2 / var15_result1), var15_result1 * arg1 * sin_upvr((-math.pi*2) * var15_result1_2 / var15_result1), 0)
end
local random_state_upvr = Random.new()
function module_2_upvr.WeightedRandom(arg1) -- Line 566
    local var268
    for _ = 1, var268 do
        random_state_upvr:NextNumber()
    end
    var268 = 0
    for i_2 = 1, #arg1 do
        var268 += arg1[i_2]
    end
    for i_3 = 1, #arg1 do
        if random_state_upvr:NextNumber() * var268 < arg1[i_3] then
            return i_3
        end
    end
    return false
end
function module_2_upvr.LookAt(arg1, arg2, arg3) -- Line 584
    local unit_2 = (arg2 - arg3).unit
    local unit = Cross_upvr(arg1, unit_2).unit
    local Cross_upvr_result1 = Cross_upvr(unit_2, unit)
    return new_upvr_2(arg2.X, arg2.Y, arg2.Z, unit.x, Cross_upvr_result1.x, unit_2.x, unit.y, Cross_upvr_result1.y, unit_2.y, unit.z, Cross_upvr_result1.z, unit_2.z)
end
function module_2_upvr.BinaryFind(arg1, arg2, arg3) -- Line 590
    local len_3 = #arg1
    local var274
    while var274 <= len_3 do
        local floor_upvr_result1 = floor_upvr((var274 + len_3) * 0.5)
        local var276 = arg1[floor_upvr_result1][arg3 or "Sort"]
        if var276 < arg2 then
            var274 = floor_upvr_result1 + 1
        elseif arg2 < var276 then
        else
            return floor_upvr_result1
        end
    end
    return var274
end
function module_2_upvr.Shuffle(arg1) -- Line 606
    for i_4 = #arg1, 2, -1 do
        local randint_from_1 = math.random(i_4)
        arg1[i_4] = arg1[randint_from_1]
        arg1[randint_from_1] = arg1[i_4]
    end
end
function module_2_upvr.IsNaN(arg1) -- Line 612
    if arg1 == arg1 then
    else
    end
    return true
end
function module_2_upvr.IsNaNv3(arg1) -- Line 615
    local var279 = true
    if arg1.x == arg1.x then
        var279 = true
        if arg1.y == arg1.y then
            if arg1.z == arg1.z then
                var279 = false
            else
                var279 = true
            end
        end
    end
    return var279
end
function module_2_upvr.IsNaNcf(arg1) -- Line 619
    local lookVector_2 = arg1.lookVector
    local var285 = true
    if lookVector_2.x == lookVector_2.x then
        var285 = true
        if lookVector_2.y == lookVector_2.y then
            if lookVector_2.z == lookVector_2.z then
                var285 = false
            else
                var285 = true
            end
        end
    end
    if not var285 then
        local rightVector = arg1.rightVector
        var285 = true
        if rightVector.x == rightVector.x then
            var285 = true
            if rightVector.y == rightVector.y then
                if rightVector.z == rightVector.z then
                    var285 = false
                else
                    var285 = true
                end
            end
        end
        if not var285 then
            local upVector_2 = arg1.upVector
            if upVector_2.x == upVector_2.x then
                if upVector_2.y == upVector_2.y then
                    if upVector_2.z == upVector_2.z then
                    else
                    end
                end
            end
        end
    end
    return true
end
function module_2_upvr.Clampv3(arg1, arg2, arg3) -- Line 622
    return new_upvr(math.clamp(arg1.x, arg2, arg3), math.clamp(arg1.y, arg2, arg3), math.clamp(arg1.z, arg2, arg3))
end
function module_2_upvr.comma(arg1) -- Line 626
    local string_match_result1, string_match_result2, string_match_result3 = string.match(arg1, "^([^%d]*%d)(%d*)(.-)$")
    return string_match_result1..string_match_result2:reverse():gsub("(%d%d%d)", "%1,"):reverse()..string_match_result3
end
function module_2_upvr.FormatMoney(arg1) -- Line 630
    local var291
    if 0 <= arg1 then
        var291 = ""
    else
        var291 = '-'
    end
    local string_match_result1_2, string_match_result2_2, string_match_result3_2 = string.match(abs_upvr(arg1), "^([^%d]*%d)(%d*)(.-)$")
    return "%s$%s":format(var291, string_match_result1_2..string_match_result2_2:reverse():gsub("(%d%d%d)", "%1,"):reverse()..string_match_result3_2)
end
function module_2_upvr.stohms(arg1) -- Line 639
    local floored_2 = math.floor(arg1 / 3600)
    local var296 = arg1 - floored_2 * 3600
    local floored = math.floor(var296 / 60)
    return floored_2, floored, var296 - floored * 60
end
function module_2_upvr.Now(arg1) -- Line 649
    return os.time() + ((arg1 or -8) + 1) * 60 * 60
end
function module_2_upvr.NextMidnight(arg1) -- Line 657
    return math.ceil(module_2_upvr.Now(arg1) / 86400) * 86400
end
function module_2_upvr.TimeUntilMidnight(arg1) -- Line 663
    return module_2_upvr.NextMidnight(arg1) - module_2_upvr.Now(arg1)
end
local max_upvr = math.max
local function TimeAccumDiff_upvw(arg1, arg2) -- Line 670, Named "TimeAccumDiff"
    if not arg2 or not os.time() then
    end
    return max_upvr(0, arg1 - tick())
end
module_2_upvr.TimeAccumDiff = TimeAccumDiff_upvw
function module_2_upvr.TimeAccumAdd(arg1, arg2, arg3) -- Line 674
    if not arg3 or not os.time() then
    end
    return tick() + TimeAccumDiff_upvw(arg1) + arg2
end
function max_upvr(arg1, arg2, arg3, arg4) -- Line 683, Named "Ease_inOutQuad"
    local var299 = arg1 / arg4 * 2
    if var299 < 1 then
        return arg3 * 0.5 * var299 * var299 + arg2
    end
    return -arg3 * 0.5 * ((var299 - 1) * (var299 - 3) - 1) + arg2
end
module_2_upvr.TweenType = {
    Linear = 1;
    InOutQuad = 2;
}
function module_2_upvr.MakeTween() -- Line 695
    return {
        i = 0;
        t0 = 0;
        t1 = 1;
        s = 1;
        v = 0;
        Type = module_2_upvr.TweenType.Linear;
        Finished = nil;
    }
end
function module_2_upvr.UpdateTween(arg1, arg2) -- Line 706
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    arg1.i += arg2 * arg1.s
    if arg1.Type == module_2_upvr.TweenType.Linear then
        arg1.v = arg1.t0 * (1 - arg1.i) + arg1.t1 * arg1.i
    else
        local Type = arg1.Type
        if Type == module_2_upvr.TweenType.InOutQuad then
            local var303 = arg1.i / 1 * 2
            if var303 < 1 then
            else
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            end
            arg1.v = -(arg1.t1 - arg1.t0) * 0.5 * ((var303 - 1) * (var303 - 3) - 1) + arg1.t0
        end
    end
    if 1 <= arg1.i and arg1.Finished then
        arg1.Finished(arg1)
    end
end
function module_2_upvr.TweenFunSwap(arg1) -- Line 717
    arg1.t1 = arg1.t0
    arg1.t0 = arg1.t1
    arg1.i -= 1
end
return module_2_upvr
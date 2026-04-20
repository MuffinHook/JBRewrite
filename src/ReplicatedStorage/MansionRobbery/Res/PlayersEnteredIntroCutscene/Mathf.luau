local module_upvr = {
    FrameDelta = function(arg1, arg2) -- Line 5, Named "FrameDelta"
        return 1 - (1 - arg1) ^ (arg2 * 60)
    end;
    SafeLerp = function(arg1, arg2, arg3) -- Line 11, Named "SafeLerp"
        if arg1 == nil or 1 <= arg3 then
            return arg2
        end
        if arg2 == nil or arg3 <= 0 then
            return arg1
        end
        if typeof(arg1) == "Color3" then
            local var2 = 1 - arg3
            return Color3.new((arg1.R ^ 2 * var2 + arg2.R ^ 2 * arg3) ^ 0.5, (arg1.G ^ 2 * var2 + arg2.G ^ 2 * arg3) ^ 0.5, (arg1.B ^ 2 * var2 + arg2.B ^ 2 * arg3) ^ 0.5)
        end
        return arg1 * (1 - arg3) + arg2 * arg3
    end;
    PercentBetween = function(arg1, arg2, arg3) -- Line 33, Named "PercentBetween"
        if arg3 - arg2 == 0 then
            return 1
        end
        return math.clamp((arg1 - arg2) / (arg3 - arg2), 0, 1)
    end;
    Round = function(arg1, arg2, arg3) -- Line 37, Named "Round"
        return math.floor(arg1 / arg2 + (arg3 or 0.5)) * arg2
    end;
    RoundNumber = function(arg1) -- Line 41, Named "RoundNumber"
        local var3
        local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var3 = math.floor(arg1 + 0.5)
            return var3
        end
        if 0 > arg1 or not decompInlinedCondition() then
            var3 = math.ceil(arg1 - 0.5)
        end
        return var3
    end;
    Lerp = function(arg1, arg2, arg3) -- Line 45, Named "Lerp"
        return arg1 * (1 - arg3) + arg2 * arg3
    end;
    SmoothLerp = function(arg1, arg2, arg3, arg4) -- Line 49, Named "SmoothLerp"
        local var4 = 1 - math.pow(1 - arg3, arg4)
        if type(arg1) == "number" then
            return (1 - var4) * arg1 + arg2 * var4
        end
        return arg1:Lerp(arg2, var4)
    end;
    LerpTowards = function(arg1, arg2, arg3) -- Line 57, Named "LerpTowards"
        if arg1 < arg2 then
            return math.clamp(arg1 + arg3, arg1, arg2)
        end
        return math.clamp(arg1 - arg3, arg2, arg1)
    end;
    Wrap = function(arg1, arg2, arg3) -- Line 65, Named "Wrap"
        return arg2 + (arg1 - arg2) % (arg3 - arg2)
    end;
    Cubic_Interpolate = function(arg1, arg2, arg3, arg4, arg5) -- Line 69, Named "Cubic_Interpolate"
        local var5 = (arg4 - arg3) - (arg1 - arg2)
        return var5 * arg5 ^ 3 + (arg1 - arg2 - var5) * arg5 ^ 2 + (arg3 - arg1) * arg5 + arg2
    end;
    SlerpVector = function(arg1, arg2, arg3) -- Line 80, Named "SlerpVector"
        return CFrame.new(Vector3.new(0, 0, 0), arg1):Lerp(CFrame.new(Vector3.new(0, 0, 0), arg2), arg3).LookVector
    end;
    RandomizeVector = function(arg1, arg2, arg3) -- Line 84, Named "RandomizeVector"
        return (CFrame.new(Vector3.new(), arg2) * CFrame.Angles(0, 0, arg1:NextNumber(0, (-math.pi*2))) * CFrame.Angles(math.acos(arg1:NextNumber(math.cos(arg3), 1)), 0, 0)).LookVector * arg2.Magnitude
    end;
    LerpColor3 = function(arg1, arg2, arg3) -- Line 92, Named "LerpColor3"
        local var6 = 1 - arg3
        return Color3.new((arg1.R ^ 2 * var6 + arg2.R ^ 2 * arg3) ^ 0.5, (arg1.G ^ 2 * var6 + arg2.G ^ 2 * arg3) ^ 0.5, (arg1.B ^ 2 * var6 + arg2.B ^ 2 * arg3) ^ 0.5)
    end;
    InPart = function(arg1, arg2, arg3) -- Line 104, Named "InPart"
        local any_PointToObjectSpace_result1 = arg1.CFrame:PointToObjectSpace(arg2)
        local var8 = arg1.Size * (arg3 or 1)
        if math.abs(any_PointToObjectSpace_result1.x) <= var8.x / 2 and math.abs(any_PointToObjectSpace_result1.y) <= var8.y / 2 and math.abs(any_PointToObjectSpace_result1.z) <= var8.z / 2 then
            return true
        end
        return false
    end;
    IK = function(arg1, arg2, arg3, arg4) -- Line 115, Named "IK"
        local var9
        if arg3 + arg4 <= (arg1 - arg2).magnitude then
            return CFrame.new(arg1, arg2), 0, 0
        end
        var9 = arg4
        if (arg1 - arg2).magnitude < math.max(arg3, arg4) - math.min(arg3, var9) then
            return CFrame.new(arg1, arg2), 0, math.pi
        end
        local cframe = CFrame.new(arg1, arg2)
        local any_pointToObjectSpace_result1 = cframe:pointToObjectSpace(arg2)
        var9 = any_pointToObjectSpace_result1.z ^ 2
        var9 = arg3 ^ 2
        var9 = 2
        local var12 = (var9 - arg4 ^ 2 + var9) / (var9 * any_pointToObjectSpace_result1.z)
        var9 = 1 - (var12 / arg3) ^ 2
        local var13 = math.sqrt(var9) * arg3
        var9 = math.asin(var13 / (var12 ^ 2 + var13 ^ 2) ^ 0.5)
        local var14 = -var9
        local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var9 = (-math.pi) + math.asin(-var13 / ((any_pointToObjectSpace_result1.z - var12) ^ 2 + var13 ^ 2) ^ 0.5)
            return var9
        end
        if var12 >= any_pointToObjectSpace_result1.z or not decompInlinedCondition_2() then
            var9 = -math.asin(-var13 / ((any_pointToObjectSpace_result1.z - var12) ^ 2 + var13 ^ 2) ^ 0.5)
        end
        return cframe, var14, var9 - var14
    end;
    Vector3ToPixel = function(arg1, arg2, arg3) -- Line 135, Named "Vector3ToPixel"
        local X = arg3.AbsoluteSize.X
        local Y = arg3.AbsoluteSize.Y
        local var17 = arg2.CoordinateFrame * CFrame.Angles(0, 0, -arg2:GetRoll()):inverse() * arg1
        local var18 = 1 / math.tan(math.rad(arg2.FieldOfView) / 2)
        local var19 = X / 2 * (1 + var17.x / -var17.z * var18 * Y / X)
        local var20 = Y / 2 * (1 + var17.y / -var17.z * var18)
        if 0 < var17.z then
            var19 = 20000
            var20 = 20000
        end
        return var19, Y - var20 - 36
    end;
    LerpAngle = function(arg1, arg2, arg3) -- Line 150, Named "LerpAngle"
        local var21
        if arg1 - arg2 < 180 then
            var21 = arg1 + (arg2 - arg1) * arg3
        else
            var21 = arg1 + (360 + arg2 - arg1) * arg3
        end
        return (var21 - 180) % 360 - 180
    end;
}
function module_upvr.LerpTowardsAngle(arg1, arg2, arg3) -- Line 162
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var22
    if 180 < math.abs(arg2 - arg1) then
        if arg2 < var22 then
            var22 += 360
        else
        end
    end
    return module_upvr.LerpTowards(var22, arg2 + 360, arg3)
end
function module_upvr.LerpAngle2(arg1, arg2, arg3) -- Line 174
    arg1 += 180
    local var23 = arg1
    arg2 += 180
    local var24 = arg2
    difference = math.abs(var24 - var23) -- Setting global
    if 180 < difference then
        if var23 < var24 then
            var24 -= 360
        else
            var23 -= 360
        end
    end
    return module_upvr.Wrap(module_upvr.Lerp(var23 - 180, var24 - 180, arg3), -180, 180)
end
function module_upvr.AngleDistance(arg1, arg2) -- Line 194
    arg1 = math.deg(arg1)
    local var25 = arg1
    arg2 = math.deg(arg2)
    local var26 = arg2
    difference = math.abs(var26 - var25) -- Setting global
    if 180 < difference then
        if var26 < var25 then
            var26 += 360
        else
            var25 += 360
        end
    end
    return math.rad(var25 - var26)
end
function module_upvr.InterpolateCFrame(arg1, arg2, arg3) -- Line 211
    local var27
    local function decompInlinedCondition_3() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var27 = arg1
        return var27
    end
    local function decompInlinedCondition_4() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var27 = arg2
        return var27
    end
    if arg3 >= 0.001 or not decompInlinedCondition_3() or 0.999 >= arg3 or not decompInlinedCondition_4() then
        var27 = arg1:lerp(arg2, arg3)
    end
    return var27
end
return module_upvr
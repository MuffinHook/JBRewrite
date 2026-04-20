local function _(arg1, ...) -- Line 45, Named "warnf"
    warn(string.format(arg1, ...))
end
local CurveData_upvr = script.Curve:FindFirstChild("CurveData")
if CurveData_upvr then
    CurveData_upvr = require(script.Curve.CurveData)
end
local CatmullRomSpline_upvr = script:FindFirstChild("CatmullRomSpline")
if CatmullRomSpline_upvr then
    CatmullRomSpline_upvr = require(script.CatmullRomSpline)
end
local Mathf_upvr = script:FindFirstChild("Mathf")
if Mathf_upvr then
    Mathf_upvr = require(script.Mathf)
end
local UpVectorData_upvr = script.Curve:FindFirstChild("UpVectorData")
if UpVectorData_upvr then
    UpVectorData_upvr = require(script.Curve.UpVectorData)
end
local TransformFunction_upvr = script.Curve:FindFirstChild("TransformFunction")
if TransformFunction_upvr then
    TransformFunction_upvr = require(script.Curve.TransformFunction)
end
local var6_upvw
if CurveData_upvr.AnimationKeyframes then
    local tbl_2 = {unpack(CurveData_upvr.AnimationKeyframes)}
    table.sort(tbl_2, function(arg1, arg2) -- Line 66
        local var9
        if arg1.pos.X >= arg2.pos.X then
            var9 = false
        else
            var9 = true
        end
        return var9
    end)
    if #tbl_2 == 0 or 0 < tbl_2[1].pos.X then
        table.insert(tbl_2, 1, {
            pos = Vector2.new(0, 0);
            left = Vector2.new(-0.1, 0);
            right = Vector2.new(0.1, 0);
        })
    end
    if #tbl_2 == 1 or tbl_2[#tbl_2].pos.X < 1 then
        table.insert(tbl_2, {
            pos = Vector2.new(1, 1);
            left = Vector2.new(-0.1, 0);
            right = Vector2.new(0.1, 0);
        })
    end
    var6_upvw = require(script.GraphBezier).new(tbl_2)
end
local module_2_upvr = {}
local module = {}
local NumPoints_upvr = CurveData_upvr.Attributes.NumPoints
function module.GetCurveValueAt(arg1, arg2) -- Line 86
    return Mathf_upvr.Lerp(arg1:_getAttribute("GraphMinSpeed") or 0, arg1:_getAttribute("GraphMaxSpeed") or 1, math.clamp(arg1:_getCurveValueAt(arg2), 0, 1))
end
function module.GetProgress(arg1, arg2, arg3, arg4) -- Line 95
    local any__getProgress_result1_2, any__getProgress_result2_3, any__getProgress_result3 = arg1:_getProgress(arg2, arg3)
    local DeltaTime = arg1.DeltaTime
    if not DeltaTime then
        DeltaTime = arg4
        if not DeltaTime then
            DeltaTime = (1/60)
        end
    end
    return arg1:_getTransformed(any__getProgress_result1_2, any__getProgress_result2_3, any__getProgress_result3, module_2_upvr, DeltaTime)
end
function module.GetProgressRaw(arg1, arg2, arg3, arg4) -- Line 101
    local any__getProgress_result1, any__getProgress_result2_2, any__getProgress_result3_2 = arg1:_getProgress(arg2, arg3)
    local DeltaTime_2 = arg1.DeltaTime
    if not DeltaTime_2 then
        DeltaTime_2 = arg4
        if not DeltaTime_2 then
            DeltaTime_2 = (1/60)
        end
    end
    return arg1:_getTransformedRaw(any__getProgress_result1, any__getProgress_result2_2, any__getProgress_result3_2, module_2_upvr, DeltaTime_2)
end
local TweenService_upvr = game:GetService("TweenService")
function module.CreateTween(arg1, arg2, arg3, arg4) -- Line 107
    local NumberValue_upvr = Instance.new("NumberValue")
    local any_Create_result1_upvr = TweenService_upvr:Create(NumberValue_upvr, arg2, {
        Value = 1;
    })
    any_Create_result1_upvr:GetPropertyChangedSignal("PlaybackState"):connect(function() -- Line 111
        if any_Create_result1_upvr.PlaybackState == Enum.PlaybackState.Playing then
            arg1.LastTick = os.clock()
        end
    end)
    NumberValue_upvr:GetPropertyChangedSignal("Value"):connect(function() -- Line 117
        local os_clock_result1 = os.clock()
        arg1.DeltaTime = os_clock_result1 - arg1.LastTick
        arg1.LastTick = os_clock_result1
        arg4(arg1:GetProgress(NumberValue_upvr.Value, arg3))
    end)
    return any_Create_result1_upvr
end
function module.Generate(arg1) -- Line 128
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local ControlPoints = CurveData_upvr.ControlPoints
    local var39
    if CurveData_upvr.Attributes.PathClosed == true then
        for i = 1, #ControlPoints do
            table.insert({}, ControlPoints[i])
            local var41
        end
        table.insert(var41, ControlPoints[1])
        table.insert(var41, ControlPoints[2])
        table.insert(var41, ControlPoints[3])
        var39 = CatmullRomSpline_upvr.new(var41, CurveData_upvr.Attributes.Tension)
    else
        var39 = CatmullRomSpline_upvr.new(ControlPoints, CurveData_upvr.Attributes.Tension)
    end
    var39.LengthIterations = CurveData_upvr.Attributes.LengthIterations or 2000
    var39:UpdateLength()
    arg1.Spline = var39
    arg1:_generatePointData()
end
function module._getAttribute(arg1, arg2) -- Line 159
    return CurveData_upvr.Attributes[arg2]
end
function module._getCurveValueAt(arg1, arg2) -- Line 162
    if not var6_upvw then return end
    return var6_upvw:CalculateValueAt(arg2)
end
function module._getProgress(arg1, arg2, arg3) -- Line 168
    local any_CalculatePositionRelativeToLength_result1 = arg1.Spline:CalculatePositionRelativeToLength(arg2)
    local any_CalculateDerivativeRelativeToLength_result1_2 = arg1.Spline:CalculateDerivativeRelativeToLength(arg2)
    local any__getUpVector_result1 = arg1:_getUpVector(arg2, any_CalculatePositionRelativeToLength_result1, any_CalculateDerivativeRelativeToLength_result1_2)
    if UpVectorData_upvr then
        any__getUpVector_result1 = arg1:_twistUpvector(any__getUpVector_result1, arg1:_getAttribute("PathClosed"), arg2, any_CalculateDerivativeRelativeToLength_result1_2, UpVectorData_upvr)
    end
    return any_CalculatePositionRelativeToLength_result1 + any__getUpVector_result1 * (arg3 or 0), any_CalculateDerivativeRelativeToLength_result1_2, any__getUpVector_result1
end
function module._getUpVector(arg1, arg2, arg3, arg4) -- Line 180
    if not arg1.PointData then
        return Vector3.new(0, 1, 0)
    end
    local var45 = arg1.PointData.points[math.floor(arg2 * NumPoints_upvr)]
    if not var45 then
        return Vector3.new(0, 1, 0)
    end
    return CFrame.lookAt(arg3, arg3 + arg4, var45.upVector).UpVector
end
function module._getTwistAt(arg1, arg2, arg3, arg4) -- Line 192
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var57
    for i_2, v in pairs(arg4.data) do
        local degrees = v.degrees
        if degrees ~= 0.00001 then
            if not nil then
                local var60 = v
            end
            local var61 = v
            local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                if v.tValue <= arg3 then
                    var57 = degrees
                else
                    local var62 = degrees
                end
                return var57
            end
            if nil or not decompInlinedCondition() or var62 then break end
        end
    end
    if not arg2 and var57 and not var62 then
        return var57
    end
    if arg2 then
        if var62 and not var57 then
            var57 = var61.degrees + (arg1.PointData.LoopAngleDiff or 0)
        elseif var57 and not var62 then
        end
    end
    if var57 and var60.degrees - (arg1.PointData.LoopAngleDiff or 0) then
        i_2 = var60.degrees - (arg1.PointData.LoopAngleDiff or 0) - var57
        i_2 = Mathf_upvr
        i_2 = i_2.PercentBetween
        v = arg3
        i_2 = i_2(v, var61.tValue - 1, var60.tValue + 1)
        return Mathf_upvr.Lerp(var57, var57 + (i_2 + 180) % 360 - 180, i_2)
    end
    return 0
end
function module._twistUpvector(arg1, arg2, arg3, arg4, arg5, arg6) -- Line 245
    if not arg1.PointData then return end
    local any__getTwistAt_result1 = arg1:_getTwistAt(arg3, arg4, arg6)
    if any__getTwistAt_result1 ~= 0 then
        return CFrame.fromAxisAngle(arg5, math.rad(any__getTwistAt_result1)) * arg2
    end
    return arg2
end
function module._getTransformed(arg1, ...) -- Line 259
    local args_list_upvr = {...}
    if TransformFunction_upvr then
        local pcall_result1_3, pcall_result2 = pcall(function() -- Line 262
            return TransformFunction_upvr(unpack(args_list_upvr))
        end)
        if pcall_result1_3 then
            return pcall_result2
        end
    end
    local var77, var78, var79, _ = ...
    return CFrame.lookAt(var77, var77 + var78, var79)
end
function module._getTransformedRaw(arg1, ...) -- Line 272
    local args_list_upvr_2 = {...}
    if TransformFunction_upvr then
        local pcall_result1_2, pcall_result2_2 = pcall(function() -- Line 275
            return TransformFunction_upvr(unpack(args_list_upvr_2))
        end)
        if pcall_result1_2 then
            return pcall_result2_2
        end
    end
    local var85, var86, var87, _ = ...
    return var85, var86, var87
end
function module._generatePointData(arg1) -- Line 286
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local tbl = {
        points = {};
    }
    local var94 = Vector3.new(0, 1, 0)
    for i_3 = 1, NumPoints_upvr do
        local var95 = i_3 / NumPoints_upvr
        local any_CalculatePositionRelativeToLength_result1_2 = arg1.Spline:CalculatePositionRelativeToLength(var95)
        local any_CalculateDerivativeRelativeToLength_result1 = arg1.Spline:CalculateDerivativeRelativeToLength(var95)
        var94 = CFrame.lookAt(any_CalculatePositionRelativeToLength_result1_2, any_CalculatePositionRelativeToLength_result1_2 + any_CalculateDerivativeRelativeToLength_result1, var94).UpVector
        tbl.points[i_3] = {
            upVector = var94;
            pos = any_CalculatePositionRelativeToLength_result1_2;
            dir = any_CalculateDerivativeRelativeToLength_result1;
            t = var95;
        }
    end
    if var94:Dot(tbl.points[#tbl.points].dir:Cross(Vector3.new(0, 1, 0))) < 0 then
    else
    end
    tbl.LoopAngleDiff = math.acos(var94.Y) / math.pi * 180 * 1
    arg1.PointData = tbl
end
return module
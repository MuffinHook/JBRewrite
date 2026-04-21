local module_upvr = {}
module_upvr.__index = module_upvr
local RunService_upvr = game:GetService("RunService")
local random_state_upvr = Random.new()
local Trove_upvr = require(script.Trove)
function module_upvr.new() -- Line 179
    local setmetatable_result1 = setmetatable({}, module_upvr)
    setmetatable_result1.Amplitude = 1
    setmetatable_result1.Frequency = 1
    setmetatable_result1.FadeInTime = 1
    setmetatable_result1.FadeOutTime = 1
    setmetatable_result1.SustainTime = 0
    setmetatable_result1.Sustain = false
    setmetatable_result1.PositionInfluence = Vector3.new(1, 1, 1)
    local var6 = Vector3.new(1, 1, 1)
    setmetatable_result1.RotationInfluence = var6
    if RunService_upvr:IsRunning() then
        var6 = time
    else
        var6 = os.clock
    end
    setmetatable_result1.TimeFunction = var6
    setmetatable_result1._timeOffset = random_state_upvr:NextNumber(-1000000000, 1000000000)
    setmetatable_result1._startTime = 0
    setmetatable_result1._trove = Trove_upvr.new()
    setmetatable_result1._running = false
    return setmetatable_result1
end
function module_upvr.InverseSquare(arg1, arg2) -- Line 226
    local var7
    if var7 < 1 then
        var7 = 1
    end
    return (arg1) * ((1) / (var7 * var7))
end
local var8_upvw = 0
function module_upvr.NextRenderName() -- Line 242
    var8_upvw += 1
    return string.format("__shake_%.4i__", var8_upvw);
end
function module_upvr.Start(arg1) -- Line 255
    arg1._startTime = arg1.TimeFunction()
    arg1._running = true
    arg1._trove:Add(function() -- Line 258
        arg1._running = false
    end)
end
function module_upvr.Stop(arg1) -- Line 270
    arg1._trove:Clean()
end
function module_upvr.IsShaking(arg1) -- Line 278
    return arg1._running
end
function module_upvr.StopSustain(arg1) -- Line 287
    arg1.Sustain = false
    arg1.SustainTime = arg1.TimeFunction() - arg1._startTime - arg1.FadeInTime
end
function module_upvr.Update(arg1) -- Line 315
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local any_TimeFunction_result1 = arg1.TimeFunction()
    local var11 = any_TimeFunction_result1 - arg1._startTime
    local var12 = (any_TimeFunction_result1 + arg1._timeOffset) / arg1.Frequency % 1000000
    local var13
    if var11 < arg1.FadeInTime then
        var13 = var11 / arg1.FadeInTime
    end
    local var14
    if not arg1.Sustain and arg1.FadeInTime + arg1.SustainTime < var11 then
        if arg1.FadeOutTime == 0 then
            local _ = true
        else
            var14 = 1 - (var11 - arg1.FadeInTime - arg1.SustainTime) / arg1.FadeOutTime
            if not arg1.Sustain and arg1.FadeInTime + arg1.SustainTime + arg1.FadeOutTime <= var11 then
            end
        end
    end
    local var16 = Vector3.new(math.noise(var12, 0) / 2, math.noise(0, var12) / 2, math.noise(var12, var12) / 2) * arg1.Amplitude * math.min(var13, var14)
    if true then
        arg1:Stop()
    end
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    return arg1.PositionInfluence * var16, arg1.RotationInfluence * var16, true
end
function module_upvr.OnSignal(arg1, arg2, arg3) -- Line 373
    return arg1._trove:Connect(arg2, function() -- Line 374
        arg3(arg1:Update())
    end)
end
function module_upvr.BindToRenderStep(arg1, arg2, arg3, arg4) -- Line 399
    arg1._trove:BindToRenderStep(arg2, arg3, function() -- Line 400
        arg4(arg1:Update())
    end)
end
function module_upvr.Clone(arg1) -- Line 434
    local any_new_result1 = module_upvr.new()
    for _, v in {"Amplitude", "Frequency", "FadeInTime", "FadeOutTime", "SustainTime", "Sustain", "PositionInfluence", "RotationInfluence", "TimeFunction"} do
        any_new_result1[v] = arg1[v]
    end
    return any_new_result1
end
function module_upvr.Destroy(arg1) -- Line 456
    arg1:Stop()
end
return module_upvr
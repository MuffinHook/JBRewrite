local module_upvr = {}
module_upvr.__index = module_upvr
function module_upvr.new(arg1) -- Line 21
    local setmetatable_result1 = setmetatable({}, module_upvr)
    setmetatable_result1.Origin = arg1
    setmetatable_result1.Target = nil
    setmetatable_result1.Velocity = nil
    setmetatable_result1._PrevUpdatePosition = setmetatable_result1.Origin
    setmetatable_result1._GetNow = os.clock
    setmetatable_result1.Birthdate = setmetatable_result1:_GetNow()
    setmetatable_result1.Gravity = workspace.Gravity
    setmetatable_result1.CollidableFunc = nil
    setmetatable_result1._GravityVector = Vector3.new(0, -setmetatable_result1.Gravity, 0)
    setmetatable_result1.IgnoreList = {}
    return setmetatable_result1
end
function module_upvr.CalculateVelocityToHitTargetWithSpeed(arg1, arg2, arg3, arg4, arg5) -- Line 35
    local var3 = arg2 - arg1
    local var4 = (var3.x * var3.x + var3.z * var3.z) ^ 0.5
    local var5
    local var6 = arg3 * arg3 * arg3 * arg3 - arg4 * (arg4 * var4 * var4 + 2 * var3.y * arg3 * arg3)
    if 0 <= var6 then
        local var7 = var6 ^ 0.5
        if arg5 then
            var5 = math.max(math.atan((arg3 * arg3 + var7) / (arg4 * var4)), math.atan((arg3 * arg3 - var7) / (arg4 * var4)))
        else
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            var5 = math.min(math.atan((arg3 * arg3 + var7) / (arg4 * var4)), math.atan((arg3 * arg3 - var7) / (arg4 * var4)))
        end
    else
        var5 = 0.7853981633974483
    end
    return Vector3.new(arg3 * var3.x / var4 * math.cos(var5), arg3 * math.sin(var5), arg3 * var3.z / var4 * math.cos(var5)), (var4) / (arg3 * math.cos(var5))
end
function module_upvr.HitTargetWithSpeed(arg1, arg2, arg3, arg4) -- Line 68
    arg1.Target = arg2
    local any_CalculateVelocityToHitTargetWithSpeed_result1, any_CalculateVelocityToHitTargetWithSpeed_result2 = module_upvr.CalculateVelocityToHitTargetWithSpeed(arg1.Origin, arg2, arg3, arg1.Gravity, arg4)
    arg1.Velocity = any_CalculateVelocityToHitTargetWithSpeed_result1
    arg1.Duration = any_CalculateVelocityToHitTargetWithSpeed_result2
    return true
end
function module_upvr.CalculateElapsedPosition(arg1, arg2) -- Line 80
    if arg2 == nil then
    else
    end
    assert(true)
    return arg1.Origin + arg1.Velocity * arg2 + 0.5 * arg1._GravityVector * arg2 * arg2
end
local RayCast_upvr = require(game:GetService("ReplicatedStorage").Module.RayCast)
function module_upvr.Step(arg1, arg2, arg3) -- Line 85
    assert(arg2)
    assert(arg1.Velocity)
    local any_CalculateElapsedPosition_result1 = arg1:CalculateElapsedPosition(arg2 - arg1.Birthdate)
    local var12 = any_CalculateElapsedPosition_result1 - arg3
    local any_RayIgnoreNonCollideWithIgnoreList_result1, any_RayIgnoreNonCollideWithIgnoreList_result2 = RayCast_upvr.RayIgnoreNonCollideWithIgnoreList(arg3, var12.Unit, var12.Magnitude, arg1.IgnoreList, nil, nil, arg1.CollidableFunc)
    if any_RayIgnoreNonCollideWithIgnoreList_result1 then
        return any_RayIgnoreNonCollideWithIgnoreList_result2, true, any_RayIgnoreNonCollideWithIgnoreList_result1
    end
    return any_CalculateElapsedPosition_result1, false
end
function module_upvr.Update(arg1) -- Line 106
    local any_Step_result1, any_Step_result2_2 = arg1:Step(arg1:_GetNow(), arg1._PrevUpdatePosition)
    arg1._PrevUpdatePosition = any_Step_result1
    return any_Step_result1, any_Step_result2_2
end
function module_upvr.CalculateNextInstantCollision(arg1, arg2) -- Line 114
    local any_Update_result1, any_Update_result2 = arg1:Update()
    if any_Update_result2 then
        return any_Update_result1, 0
    end
    local any__GetNow_result1 = arg1:_GetNow()
    while true do
        local var20 = any__GetNow_result1 + arg2
        local any_Step_result1_2, any_Step_result2 = arg1:Step(var20, any_Update_result1)
        if any_Step_result2 or any_Step_result1_2.y <= workspace.FallenPartsDestroyHeight then
            return any_Step_result1_2, var20 - any__GetNow_result1
        end
    end
end
function module_upvr.GetElapsed(arg1) -- Line 131
    return arg1:_GetNow() - arg1.Birthdate
end
return module_upvr
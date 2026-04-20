local module_upvr = {}
module_upvr.__index = module_upvr
local zero_vector3_upvr = Vector3.new()
local CameraShakeInstance_upvr = require(script.Parent.CameraShakeInstance)
module_upvr.CameraShakeInstance = CameraShakeInstance_upvr
module_upvr.Presets = require(script.Parent.CameraShakePresets)
function module_upvr.new(arg1, arg2) -- Line 83
    local var4
    if type(arg1) ~= "number" then
        var4 = false
    else
        var4 = true
    end
    assert(var4, "RenderPriority must be a number (e.g.: Enum.RenderPriority.Camera.Value)")
    if type(arg2) ~= "function" then
        var4 = false
    else
        var4 = true
    end
    assert(var4, "Callback must be a function")
    var4 = {}
    var4._running = false
    var4._renderName = "CameraShaker"
    var4._renderPriority = arg1
    var4._posAddShake = zero_vector3_upvr
    var4._rotAddShake = zero_vector3_upvr
    var4._camShakeInstances = {}
    var4._removeInstances = {}
    var4._callback = arg2
    return setmetatable(var4, module_upvr)
end
local profilebegin_upvr = debug.profilebegin
local profileend_upvr = debug.profileend
function module_upvr.Start(arg1) -- Line 101
    if arg1._running then
    else
        arg1._running = true
        local _callback_upvr = arg1._callback
        game:GetService("RunService"):BindToRenderStep(arg1._renderName, arg1._renderPriority, function(arg1_2) -- Line 107
            profilebegin_upvr("CameraShakerUpdate")
            profileend_upvr()
            _callback_upvr(arg1:Update(arg1_2))
        end)
    end
end
function module_upvr.Stop(arg1) -- Line 115
    if not arg1._running then
    else
        game:GetService("RunService"):UnbindFromRenderStep(arg1._renderName)
        arg1._running = false
    end
end
function module_upvr.StopSustained(arg1, arg2) -- Line 123
    for _, v in pairs(arg1._camShakeInstances) do
        if v.fadeOutDuration == 0 then
            local var16 = arg2
            if not var16 then
                var16 = v.fadeInDuration
            end
            v:StartFadeOut(var16)
        end
    end
end
local CameraShakeState_upvr = CameraShakeInstance_upvr.CameraShakeState
local new_2_upvr = CFrame.new
local Angles_upvr = CFrame.Angles
local rad_upvr = math.rad
function module_upvr.Update(arg1, arg2) -- Line 131
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local _camShakeInstances = arg1._camShakeInstances
    local var30
    for i_2 = 1, #_camShakeInstances do
        local var31 = _camShakeInstances[i_2]
        local any_GetState_result1 = var31:GetState()
        if any_GetState_result1 == CameraShakeState_upvr.Inactive and var31.DeleteOnInactive then
            arg1._removeInstances[#arg1._removeInstances + 1] = i_2
        elseif any_GetState_result1 ~= CameraShakeState_upvr.Inactive then
            local any_UpdateShake_result1 = var31:UpdateShake(arg2)
            var30 += any_UpdateShake_result1 * var31.PositionInfluence
            local var34 = zero_vector3_upvr + any_UpdateShake_result1 * var31.RotationInfluence
        end
    end
    for i_3 = #arg1._removeInstances, 1, -1 do
        table.remove(_camShakeInstances, arg1._removeInstances[i_3])
        arg1._removeInstances[i_3] = nil
    end
    return new_2_upvr(var30) * Angles_upvr(0, rad_upvr(var34.Y), 0) * Angles_upvr(rad_upvr(var34.X), 0, rad_upvr(var34.Z))
end
function module_upvr.Shake(arg1, arg2) -- Line 161
    local var35 = false
    if type(arg2) == "table" then
        var35 = arg2._camShakeInstance
    end
    assert(var35, "ShakeInstance must be of type CameraShakeInstance")
    arg1._camShakeInstances[#arg1._camShakeInstances + 1] = arg2
    return arg2
end
function module_upvr.ShakeSustain(arg1, arg2) -- Line 170
    local var36 = false
    if type(arg2) == "table" then
        var36 = arg2._camShakeInstance
    end
    assert(var36, "ShakeInstance must be of type CameraShakeInstance")
    arg1._camShakeInstances[#arg1._camShakeInstances + 1] = arg2
    arg2:StartFadeIn(arg2.fadeInDuration)
    return arg2
end
function module_upvr.ShakeOnce(arg1, arg2, arg3, arg4, arg5, arg6, arg7) -- Line 180
    local any_new_result1_2 = CameraShakeInstance_upvr.new(arg2, arg3, arg4, arg5)
    local var38
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var38 = arg6
        return var38
    end
    if typeof(arg6) ~= "Vector3" or not decompInlinedCondition() then
        var38 = Vector3.new(0.15000, 0.15000, 0.15000)
    end
    any_new_result1_2.PositionInfluence = var38
    local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var38 = arg7
        return var38
    end
    if typeof(arg7) ~= "Vector3" or not decompInlinedCondition_2() then
        var38 = Vector3.new(1, 1, 1)
    end
    any_new_result1_2.RotationInfluence = var38
    var38 = arg1._camShakeInstances
    var38[#arg1._camShakeInstances + 1] = any_new_result1_2
    return any_new_result1_2
end
function module_upvr.StartShake(arg1, arg2, arg3, arg4, arg5, arg6) -- Line 188
    local any_new_result1 = CameraShakeInstance_upvr.new(arg2, arg3, arg4)
    local var40
    local function decompInlinedCondition_3() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var40 = arg5
        return var40
    end
    if typeof(arg5) ~= "Vector3" or not decompInlinedCondition_3() then
        var40 = Vector3.new(0.15000, 0.15000, 0.15000)
    end
    any_new_result1.PositionInfluence = var40
    local function decompInlinedCondition_4() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var40 = arg6
        return var40
    end
    if typeof(arg6) ~= "Vector3" or not decompInlinedCondition_4() then
        var40 = Vector3.new(1, 1, 1)
    end
    any_new_result1.RotationInfluence = var40
    var40 = any_new_result1:StartFadeIn
    var40(arg4)
    var40 = arg1._camShakeInstances
    var40[#arg1._camShakeInstances + 1] = any_new_result1
    return any_new_result1
end
return module_upvr
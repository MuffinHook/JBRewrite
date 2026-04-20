local new_2_upvr = Vector3.new
local module_upvr = {}
module_upvr.__index = module_upvr
function module_upvr.new(arg1, arg2) -- Line 18
    assert(arg1, "missing PartNode")
    local setmetatable_result1 = setmetatable({}, module_upvr)
    if not arg2 then
        local Attachment = Instance.new("Attachment")
        Attachment.Parent = arg1
        setmetatable_result1.Attachment = Attachment
        local VectorForce_2 = Instance.new("VectorForce")
        VectorForce_2.RelativeTo = Enum.ActuatorRelativeTo.Attachment0
        VectorForce_2.Attachment0 = Attachment
        VectorForce_2.Force = Vector3.new()
        VectorForce_2.Parent = arg1
        setmetatable_result1.VectorForce = VectorForce_2
        local Torque = Instance.new("Torque")
        Torque.RelativeTo = Enum.ActuatorRelativeTo.World
        Torque.Attachment0 = Attachment
        Torque.Torque = Vector3.new()
        Torque.Parent = arg1
        setmetatable_result1.Torque = Torque
    end
    setmetatable_result1.PartNode = arg1
    setmetatable_result1.dx = 0
    setmetatable_result1.d2x = 0
    setmetatable_result1.RotationVisual = 0
    setmetatable_result1.VisualHeightFloat = 0
    setmetatable_result1.EffectiveMass = 0
    setmetatable_result1.IgnoreModel = nil
    setmetatable_result1.HeightSuspension = 0
    setmetatable_result1.RadiusVisual = 0
    setmetatable_result1.Springk = 1.5
    setmetatable_result1.SpringB = 3.5
    setmetatable_result1.BHFric0 = 7
    setmetatable_result1.BFFric0 = 0.02
    setmetatable_result1.BFFric1 = 0.005
    setmetatable_result1._version = 1
    setmetatable_result1._applyForces = not arg2
    return setmetatable_result1
end
function module_upvr.SetSuspensionHeight(arg1, arg2) -- Line 64
    assert(arg2)
    arg1.HeightSuspension = arg2
end
function module_upvr.SetVisualRadius(arg1, arg2) -- Line 68
    assert(arg2)
    arg1.RadiusVisual = arg2
end
function module_upvr.SetSpringConstants(arg1, arg2, arg3) -- Line 72
    arg1.Springk = arg2
    arg1.SpringB = arg3
end
function module_upvr.SetHorizontalFriction(arg1, arg2) -- Line 75
    arg1.BHFric0 = arg2
end
function module_upvr.SetForwardFriction(arg1, arg2) -- Line 78
    arg1.BFFric0 = arg2
end
function module_upvr.SetForwardFriction2(arg1, arg2) -- Line 81
    arg1.BFFric1 = arg2
end
function module_upvr.SetVersion(arg1, arg2) -- Line 84
    arg1._version = arg2
end
function module_upvr.SetApplyForces(arg1, arg2) -- Line 87
    arg1._applyForces = arg2
end
function module_upvr.SetExternalGroundAccel(arg1, arg2) -- Line 90
    arg1._extGroundAccel = arg2
end
local Angles_upvr = CFrame.Angles
local RayCast_upvr = require(game:GetService("ReplicatedStorage").Module.RayCast)
local Dot_upvr = new_2_upvr().Dot
local clamp_upvr = math.clamp
local abs_upvr = math.abs
function module_upvr.Update(arg1, arg2, arg3) -- Line 93
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local PartNode = arg1.PartNode
    local VectorForce = arg1.VectorForce
    local Torque_2 = arg1.Torque
    local HeightSuspension = arg1.HeightSuspension
    local CFrame = PartNode.CFrame
    local _ = arg1.SpringB
    local var19
    if arg3 then
        CFrame *= Angles_upvr(0, arg3, 0)
    end
    local p = CFrame.p
    local var21 = -CFrame.UpVector
    if arg1._version <= 1 then
        p -= var21 * HeightSuspension * 0.5
    end
    local any_RayIgnoreNonCollide_result1, any_RayIgnoreNonCollide_result2, any_RayIgnoreNonCollide_result3 = RayCast_upvr.RayIgnoreNonCollide(p, var21, HeightSuspension, arg1.IgnoreModel)
    local Dot_upvr_result1 = Dot_upvr(any_RayIgnoreNonCollide_result2 - p, var21)
    local var26 = HeightSuspension - Dot_upvr_result1
    local any_vectorToObjectSpace_result1 = CFrame:vectorToObjectSpace(PartNode.Velocity)
    var19 = 0
    if 0.01 < var26 then
        local clamp_upvr_result1 = clamp_upvr(any_vectorToObjectSpace_result1.z, -1000, 1000)
        var19 = -clamp_upvr(any_vectorToObjectSpace_result1.x, -1000, 1000) / 60 * arg1.BHFric0
    end
    local var29
    local var30
    if arg1._applyForces then
        local any_VectorToObjectSpace_result1 = PartNode.CFrame:VectorToObjectSpace(any_RayIgnoreNonCollide_result3)
        local var32
        if arg1._extGroundAccel and 0.01 < var26 then
            var32 += arg1._extGroundAccel
        end
        var29 = arg1.EffectiveMass * workspace.Gravity * var32
        var30 = PartNode.CFrame:VectorToWorldSpace(var29):Cross(arg1.Attachment.WorldPosition - PartNode.Position)
    end
    if VectorForce then
        any_VectorToObjectSpace_result1 = var29
        local var33 = any_VectorToObjectSpace_result1
        if not var33 then
            var33 = Vector3.new()
        end
        VectorForce.Force = var33
    end
    if Torque_2 then
        var33 = var30
        local var34 = var33
        if not var34 then
            var34 = Vector3.new()
        end
        Torque_2.Torque = var34
    end
    local var35 = arg1.RotationVisual + clamp_upvr_result1 * arg2 / arg1.RadiusVisual
    arg1.RotationVisual = var35
    local var36
    local var37
    if arg1._version <= 1 then
        var36 = (arg1.RadiusVisual * 2 + HeightSuspension) * 0.5 - Dot_upvr_result1
        var37 = 0.2
    else
        var36 = arg1.RadiusVisual - Dot_upvr_result1
        var37 = -arg1.RadiusVisual
    end
    if var37 < var36 then
    end
    local VisualHeightFloat = arg1.VisualHeightFloat
    if VisualHeightFloat < var37 then
        VisualHeightFloat = var37
    else
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        VisualHeightFloat += (var37 - VisualHeightFloat) * 0.4
    end
    arg1.VisualHeightFloat = VisualHeightFloat
    arg1.d2x = arg1.dx
    arg1.dx = var26
    return VisualHeightFloat, var35, clamp_upvr_result1 * arg2
end
local new_2_upvr_result1_upvr = new_2_upvr()
function module_upvr.Clear(arg1) -- Line 205
    if arg1.VectorForce then
        arg1.VectorForce.Force = new_2_upvr_result1_upvr
    end
    if arg1.Torque then
        arg1.Torque.Torque = new_2_upvr_result1_upvr
    end
end
function module_upvr.Destroy(arg1) -- Line 213
    if arg1.VectorForce then
        arg1.VectorForce:Destroy()
        arg1.VectorForce = nil
    end
    if arg1.Torque then
        arg1.Torque:Destroy()
        arg1.Torque = nil
    end
    if arg1.Attachment then
        arg1.Attachment:Destroy()
        arg1.Attachment = nil
    end
end
return module_upvr
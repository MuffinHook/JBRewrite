local PlayerModule = game:GetService("Players").LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")
local var1_2_upvr = require(PlayerModule)
local module = {}
local ManualJump_upvr = PlayerModule:WaitForChild("ControlModule"):WaitForChild("ManualJump")
function module.setIsJumping(arg1) -- Line 11
    ManualJump_upvr.Value = arg1
end
local CameraSensitivity_upvr = PlayerModule:WaitForChild("CameraModule"):WaitForChild("CameraSensitivity")
function module.setCameraSensitivity(arg1) -- Line 14
    CameraSensitivity_upvr.Value = arg1
end
local function _() -- Line 17, Named "getCameraController"
    local any_GetCameras_result1_3 = var1_2_upvr:GetCameras()
    if any_GetCameras_result1_3 then
        local activeCameraController_2 = any_GetCameras_result1_3.activeCameraController
        if activeCameraController_2 then
            return activeCameraController_2
        end
    end
    return nil
end
function module.getCameraToSubjectDistance() -- Line 27
    local any_GetCameras_result1 = var1_2_upvr:GetCameras()
    if any_GetCameras_result1 then
        if any_GetCameras_result1.activeCameraController then
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
    end
    local var12
    if var12 then
        return var12:GetCameraToSubjectDistance()
    end
    return nil
end
function module.setCameraToSubjectDistance(arg1) -- Line 34
    local any_GetCameras_result1_2 = var1_2_upvr:GetCameras()
    if any_GetCameras_result1_2 then
        if any_GetCameras_result1_2.activeCameraController then
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
    end
    local var15
    if var15 then
        var15:SetCameraToSubjectDistance(arg1)
        return true
    end
    return false
end
local any_GetControls_result1_upvr = var1_2_upvr:GetControls()
function module.getMoveVector() -- Line 42
    return any_GetControls_result1_upvr:GetMoveVector()
end
return module
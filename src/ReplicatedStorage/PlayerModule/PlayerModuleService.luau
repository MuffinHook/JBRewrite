local PlayerModule = game:GetService("Players").LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")
local ManualJump = PlayerModule:WaitForChild("ControlModule"):WaitForChild("ManualJump")
local CameraSensitivity = PlayerModule:WaitForChild("CameraModule"):WaitForChild("CameraSensitivity")
local v1 = require(PlayerModule)
local v2 = v1:GetControls()
local t = {
	setIsJumping = function(p1) --[[ Name: setIsJumping | Line: 11 | Upvalues: ManualJump (copy) ]]
		ManualJump.Value = p1
	end,
	setCameraSensitivity = function(p1) --[[ Name: setCameraSensitivity | Line: 14 | Upvalues: CameraSensitivity (copy) ]]
		CameraSensitivity.Value = p1
	end
}
local function getCameraController() --[[ Line: 17 | Upvalues: v1 (copy) ]]
	local v12 = v1:GetCameras()
	if v12 then
		local activeCameraController = v12.activeCameraController
		if activeCameraController then
			return activeCameraController
		else
			return nil
		end
	else
		return nil
	end
end
function t.getCameraToSubjectDistance() --[[ Line: 27 | Upvalues: v1 (copy) ]]
	local v12 = v1:GetCameras()
	local v2 = v12 and v12.activeCameraController or nil
	if v2 then
		return v2:GetCameraToSubjectDistance()
	else
		return nil
	end
end
function t.setCameraToSubjectDistance(p1) --[[ Line: 34 | Upvalues: v1 (copy) ]]
	local v12 = v1:GetCameras()
	local v2 = v12 and v12.activeCameraController or nil
	if v2 then
		v2:SetCameraToSubjectDistance(p1)
		return true
	else
		return false
	end
end
function t.getMoveVector() --[[ Line: 42 | Upvalues: v2 (copy) ]]
	return v2:GetMoveVector()
end
return t
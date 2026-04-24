-- Reviewed by Claude
local PlayerModule = game:GetService("Players").LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")
local ManualJump = PlayerModule:WaitForChild("ControlModule"):WaitForChild("ManualJump")
local CameraSensitivity = PlayerModule:WaitForChild("CameraModule"):WaitForChild("CameraSensitivity")
local module = require(PlayerModule)
local v2 = module:GetControls()
local t = {
	setIsJumping = function(p1)
		ManualJump.Value = p1
	end,
	setCameraSensitivity = function(p1)
		CameraSensitivity.Value = p1
	end
}
local function getCameraController()
	local var12 = module:GetCameras()
	if var12 then
		local activeCameraController = var12.activeCameraController
		if activeCameraController then
			return activeCameraController
		else
			return nil
		end
	else
		return nil
	end
end
function t.getCameraToSubjectDistance()
	local var12 = module:GetCameras()
	local v2 = var12 and var12.activeCameraController or nil
	if v2 then
		return v2:GetCameraToSubjectDistance()
	else
		return nil
	end
end
function t.setCameraToSubjectDistance(p1)
	local var12 = module:GetCameras()
	local v2 = var12 and var12.activeCameraController or nil
	if v2 then
		v2:SetCameraToSubjectDistance(p1)
		return true
	else
		return false
	end
end
function t.getMoveVector()
	return v2:GetMoveVector()
end
return t

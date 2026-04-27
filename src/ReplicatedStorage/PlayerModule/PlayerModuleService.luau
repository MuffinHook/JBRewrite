local PlayerModule = game:GetService("Players").LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")
local ManualJump = PlayerModule:WaitForChild("ControlModule"):WaitForChild("ManualJump")
local CameraSensitivity = PlayerModule:WaitForChild("CameraModule"):WaitForChild("CameraSensitivity")
local module = require(PlayerModule)
local controls = module:GetControls()
local playerModuleService = {
	setIsJumping = function(isJumping)
		ManualJump.Value = isJumping
	end,
	setCameraSensitivity = function(sensitivity)
		CameraSensitivity.Value = sensitivity
	end
}
local function getCameraController()
	local cameraModule = module:GetCameras()
	if cameraModule then
		local activeCameraController = cameraModule.activeCameraController
		if activeCameraController then
			return activeCameraController
		else
			return nil
		end
	else
		return nil
	end
end
function playerModuleService.getCameraToSubjectDistance()
	local cameraModule = module:GetCameras()
	local activeCameraController = cameraModule and cameraModule.activeCameraController or nil
	if activeCameraController then
		return activeCameraController:GetCameraToSubjectDistance()
	else
		return nil
	end
end
function playerModuleService.setCameraToSubjectDistance(distance)
	local cameraModule = module:GetCameras()
	local activeCameraController = cameraModule and cameraModule.activeCameraController or nil
	if activeCameraController then
		activeCameraController:SetCameraToSubjectDistance(distance)
		return true
	else
		return false
	end
end
function playerModuleService.getMoveVector()
	return controls:GetMoveVector()
end
return playerModuleService

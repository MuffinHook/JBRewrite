local CurrentCamera = workspace.CurrentCamera
local cframe = CFrame.new
local vector2 = Vector3.new
cframe()
local zeroVector = vector2()
return {
	MakeCinematicCamera = function()
		return {
			StartPosition = nil,
			Position = zeroVector,
			TargetPosition = nil,
			LookVector = zeroVector,
			TargetFocus = nil
		}
	end,
	StepCinematicCamera = function(deltaTime, cameraState, focusSmoothness, progress)
		if cameraState.TargetPosition then
			if cameraState.StartPosition then
				cameraState.Position = cameraState.StartPosition * (1 - progress) + cameraState.TargetPosition * progress
			else
				cameraState.Position = cameraState.Position + (cameraState.TargetPosition - cameraState.Position) * deltaTime * progress
			end
		end
		if cameraState.TargetFocus then
			cameraState.LookVector = cameraState.LookVector + ((cameraState.TargetFocus - cameraState.Position).unit - cameraState.LookVector) * deltaTime * focusSmoothness
		end
		CurrentCamera.CoordinateFrame = cframe(zeroVector, cameraState.LookVector) + cameraState.Position
	end
}

local RunService = game:GetService("RunService")
local estimatedPhysicsStep = 1 / 60
RunService.Stepped:Connect(function(elapsedTime, deltaTime)
	estimatedPhysicsStep = estimatedPhysicsStep + (deltaTime - estimatedPhysicsStep) * 0.1
end)
return {
	getEstimatedPhysicsStepsMult = function()
		return estimatedPhysicsStep / 1 / 60
	end
}

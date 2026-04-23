local RunService = game:GetService("RunService")
local v1 = 1 / 60
RunService.Stepped:Connect(function(p1, p2) --[[ Line: 7 | Upvalues: v1 (ref) ]]
	v1 = v1 + (p2 - v1) * 0.1
end)
return {
	getEstimatedPhysicsStepsMult = function() --[[ Name: getEstimatedPhysicsStepsMult | Line: 12 | Upvalues: v1 (ref) ]]
		return v1 / 1 / 60
	end
}
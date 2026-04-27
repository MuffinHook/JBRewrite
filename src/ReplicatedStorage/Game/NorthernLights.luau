local RunService = game:GetService("RunService")
local northernLightsController = {
	_color = nil,
	_targetColor = Color3.new(255/255, 255/255, 255/255)
}
function northernLightsController.init()
	task.spawn(function()
		local SkyLights = workspace:WaitForChild("SkyLights", 20)
		if SkyLights then
			local lastTick = 0
			RunService.Heartbeat:Connect(function()
				local currentTime = tick()
				if currentTime - lastTick > 5 then
					lastTick = currentTime
					northernLightsController._color = northernLightsController._targetColor
					northernLightsController._targetColor = Color3.fromHSV(math.random(), 1, 1.5)
				end
				local interpolatedColor = northernLightsController._color:lerp(northernLightsController._targetColor, (currentTime - lastTick) / 5)
				for i, skyLight in ipairs(SkyLights:GetChildren()) do
					skyLight.Decal.Color3 = interpolatedColor
				end
			end)
		end
	end)
end
return northernLightsController

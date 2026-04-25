-- Reviewed by Claude
-- variables reassigned
local RunService = game:GetService("RunService")
local t = {
	_color = nil,
	_targetColor = Color3.new(255/255, 255/255, 255/255)
}
function t.init()
	task.spawn(function()
		local SkyLights = workspace:WaitForChild("SkyLights", 20)
		if SkyLights then
			local lastTick = 0
			RunService.Heartbeat:Connect(function()
				local currentTick = tick()
				if currentTick - lastTick > 5 then
					lastTick = currentTick
					t._color = t._targetColor
					t._targetColor = Color3.fromHSV(math.random(), 1, 1.5)
				end
				local interpolatedColor = t._color:lerp(t._targetColor, (currentTick - lastTick) / 5)
				for i, v in ipairs(SkyLights:GetChildren()) do
					v.Decal.Color3 = interpolatedColor
				end
			end)
		end
	end)
end
return t

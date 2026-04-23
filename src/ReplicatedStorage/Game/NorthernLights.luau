local RunService = game:GetService("RunService")
local t = {
	_color = nil,
	_targetColor = Color3.new(255/255, 255/255, 255/255)
}
function t.init() --[[ Line: 6 | Upvalues: RunService (copy), t (copy) ]]
	task.spawn(function() --[[ Line: 7 | Upvalues: RunService (ref), t (ref) ]]
		local SkyLights = workspace:WaitForChild("SkyLights", 20)
		if SkyLights then
			local v1 = 0
			RunService.Heartbeat:Connect(function() --[[ Line: 11 | Upvalues: v1 (ref), t (ref), SkyLights (copy) ]]
				local v12 = tick()
				if v12 - v1 > 5 then
					v1 = v12
					t._color = t._targetColor
					t._targetColor = Color3.fromHSV(math.random(), 1, 1.5)
				end
				local v2 = t._color:lerp(t._targetColor, (v12 - v1) / 5)
				for i, v in ipairs(SkyLights:GetChildren()) do
					v.Decal.Color3 = v2
				end
			end)
		end
	end)
end
return t
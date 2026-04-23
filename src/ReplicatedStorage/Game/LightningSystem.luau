local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local Anim = require(ReplicatedStorage.Module.Anim)
local LightningUtils = require(ReplicatedStorage.Game.LightningUtils)
local v1 = 0
local t = {
	StrikePosition = function(p1, p2) --[[ Name: StrikePosition | Line: 12 | Upvalues: LightningUtils (copy), Audio (copy), v1 (ref), Lighting (copy), RunService (copy), Anim (copy) ]]
		local v12 = LightningUtils.strikePosition({
			Origin = p1,
			Target = p2,
			Transparency = 0.6
		})
		local Part = Instance.new("Part")
		Part.Anchored = true
		Part.CanCollide = false
		Part.Transparency = 1
		Part.Position = p2
		Part.Parent = workspace
		Audio.ObjectLocal(Part, 5042136770, {
			Volume = 2,
			EmitterSize = 60,
			MaxPlaybackTime = 8
		})
		Audio.ObjectLocal(Part, 457217618, {
			EmitterSize = 60,
			TimePosition = 1,
			MaxPlaybackTime = 8
		})
		delay(8, function() --[[ Line: 30 | Upvalues: Part (copy) ]]
			Part:Destroy()
		end)
		local v2 = tick()
		if v2 - v1 > 1 then
			v1 = v2
			local v3 = Color3.fromRGB(164, 172, 186)
			local v4 = Color3.fromRGB(64, 76, 93)
			Lighting.OutdoorAmbient = v3
			local Clouds = workspace.Terrain.Clouds
			Clouds.Density = 1
			Clouds.Cover = 0.9
			Clouds.Color = v4
			task.delay(0.2, function() --[[ Line: 46 | Upvalues: RunService (ref), Lighting (ref), v3 (copy), Clouds (copy), v4 (copy) ]]
				local v1 = nil
				local v2 = os.clock()
				v1 = RunService.Heartbeat:Connect(function() --[[ Line: 50 | Upvalues: v2 (copy), Lighting (ref), v3 (ref), Clouds (ref), v4 (ref), v1 (ref) ]]
					local v12 = (os.clock() - v2) / 0.5
					if v12 >= 1 then
						v12 = 1
					end
					Lighting.OutdoorAmbient = v3:lerp(Lighting:GetAttribute("_OutdoorAmbient"), v12)
					Clouds.Density = math.lerp(1, Lighting:GetAttribute("_CloudsDensity"), v12)
					Clouds.Cover = math.lerp(0.9, Lighting:GetAttribute("_CloudsCover"), v12)
					Clouds.Color = v4:lerp(Lighting:GetAttribute("_CloudsColor"), v12)
					if v12 == 1 then
						v1:Disconnect()
					end
				end)
			end)
		end
		task.delay(1, function() --[[ Line: 69 | Upvalues: v12 (copy), Anim (ref), RunService (ref) ]]
			local v1 = v12:GetChildren()
			local v2 = Anim.new(4)
			local v3 = RunService.Heartbeat:Connect(function() --[[ Line: 73 | Upvalues: v2 (copy), v1 (copy) ]]
				local v12 = v2:Update()
				for i, v in ipairs(v1) do
					v.Transparency = 0.6 * (1 - v12) + 1 * v12
				end
			end)
			v2.OnCompleted:Connect(function() --[[ Line: 79 | Upvalues: v3 (ref), v2 (copy), v12 (ref) ]]
				v3:Disconnect()
				v3 = nil
				v2:Destroy()
				v12:Destroy()
			end)
		end)
	end
}
function t.Init(p1) --[[ Line: 87 | Upvalues: t (copy) ]]
	function p1.em.tqftmpkl(p1, p2) --[[ Line: 89 | Upvalues: t (ref) ]]
		t.StrikePosition(p1, p2)
	end
end
return t
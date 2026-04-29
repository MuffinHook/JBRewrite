local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local Anim = require(ReplicatedStorage.Module.Anim)
local LightningUtils = require(ReplicatedStorage.Game.LightningUtils)
local lastStrikeTime = 0
local LightningModule = {
	StrikePosition = function(origin, target)
		local lightningModel = LightningUtils.strikePosition({
			Origin = origin,
			Target = target,
			Transparency = 0.6
		})
		local Part = Instance.new("Part")
		Part.Anchored = true
		Part.CanCollide = false
		Part.Transparency = 1
		Part.Position = target
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
		task.delay(8, function()
			Part:Destroy()
		end)
		local currentTime = tick()
		if currentTime - lastStrikeTime > 1 then
			lastStrikeTime = currentTime
			local ambientColor = Color3.fromRGB(164, 172, 186)
			local cloudsColor = Color3.fromRGB(64, 76, 93)
			Lighting.OutdoorAmbient = ambientColor
			local Clouds = workspace.Terrain.Clouds
			Clouds.Density = 1
			Clouds.Cover = 0.9
			Clouds.Color = cloudsColor
			task.delay(0.2, function()
				local heartbeatConnection = nil
				local startTime = os.clock()
				heartbeatConnection = RunService.Heartbeat:Connect(function()
					local progress = (os.clock() - startTime) / 0.5
					if progress >= 1 then
						progress = 1
					end
					Lighting.OutdoorAmbient = ambientColor:lerp(Lighting:GetAttribute("_OutdoorAmbient"), progress)
					Clouds.Density = math.lerp(1, Lighting:GetAttribute("_CloudsDensity"), progress)
					Clouds.Cover = math.lerp(0.9, Lighting:GetAttribute("_CloudsCover"), progress)
					Clouds.Color = cloudsColor:lerp(Lighting:GetAttribute("_CloudsColor"), progress)
					if progress == 1 then
						heartbeatConnection:Disconnect()
					end
				end)
			end)
		end
		task.delay(1, function()
			local lightningParts = lightningModel:GetChildren()
			local animator = Anim.new(4)
			local animConnection = RunService.Heartbeat:Connect(function()
				local progress = animator:Update()
				for i, lightningPart in ipairs(lightningParts) do
					lightningPart.Transparency = 0.6 * (1 - progress) + 1 * progress
				end
			end)
			animator.OnCompleted:Connect(function()
				animConnection:Disconnect()
				animConnection = nil
				animator:Destroy()
				lightningModel:Destroy()
			end)
		end)
	end
}
function LightningModule.Init(target)
	function target.em.OnLightningStrike(target, attackerPosition)
		LightningModule.StrikePosition(target, attackerPosition)
	end
end
return LightningModule

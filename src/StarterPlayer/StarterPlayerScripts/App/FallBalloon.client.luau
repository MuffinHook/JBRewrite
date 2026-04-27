game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("RunService")
require(ReplicatedStorage.App.RunUtils)
local function toggleBalloonEmitters(balloon, isEnabled)
	for index, part in balloon.Part:GetChildren() do
		local ParticleEmitter = part:FindFirstChildOfClass("ParticleEmitter")
		local Sound = part:FindFirstChildOfClass("Sound")
		if ParticleEmitter then
			ParticleEmitter.Enabled = isEnabled
		end
		if Sound then
			Sound.Playing = isEnabled
		end
	end
end
local function updateBalloonPhases()
	if not (isPhaseUpdateEnabled <= 0) then
		local currentTime = workspace:GetServerTimeNow()
		for balloonIndex, balloonConfig in balloonConfigs do
			local elapsedTime = (currentTime + balloonConfig.Offset) % timingConfig.Total
			if elapsedTime < timingConfig.RestingTime then
				if balloonConfig.Phase == "Resting" then
					_ = balloonIndex
					_2 = balloonConfig
					break
				end
				balloonConfig.Phase = "Resting"
				toggleBalloonEmitters(balloonConfig, false)
				balloonConfig.Part.CFrame = balloonConfig.Origin
			elseif elapsedTime < timingConfig.RestingTime + timingConfig.ActivatingTime then
				if balloonConfig.Phase == "Activating" then
					_ = balloonIndex
					_2 = balloonConfig
					break
				end
				balloonConfig.Phase = "Activating"
				toggleBalloonEmitters(balloonConfig, true)
			elseif elapsedTime < timingConfig.RestingTime + timingConfig.ActivatingTime + timingConfig.UpTime then
				if balloonConfig.Phase ~= "Up" then
					toggleBalloonEmitters(balloonConfig, true)
					balloonConfig.Phase = "Up"
				end
				balloonConfig.Part.CFrame = balloonConfig.Origin:Lerp(balloonConfig.Up, (elapsedTime - (timingConfig.RestingTime + timingConfig.ActivatingTime)) / timingConfig.UpTime)
			elseif elapsedTime < timingConfig.RestingTime + timingConfig.ActivatingTime + timingConfig.UpTime + timingConfig.AirTime then
				if balloonConfig.Phase ~= "Air" then
					toggleBalloonEmitters(balloonConfig, false)
					balloonConfig.Phase = "Air"
				end
				local swayNoiseX = math.noise(currentTime * timingConfig.SwaySpeed * timingConfig.SwayAmount)
				local swayNoiseZ = math.noise(currentTime * timingConfig.SwaySpeed * 0.8 * timingConfig.SwayAmount * 0.5)
				local swayRotationX = math.sin(currentTime * timingConfig.SwaySpeed)
				local swayRotationX = swayRotationX * math.rad(timingConfig.SwayTilt)
				local swayRotationZ = math.cos(currentTime * timingConfig.SwaySpeed * 0.8)
				local swayRotationZ = swayRotationZ * math.rad(timingConfig.SwayTilt)
				balloonConfig.Part.CFrame = balloonConfig.Pivot * CFrame.Angles(swayRotationX, 0, swayRotationZ) * CFrame.new(swayNoiseX, 0, swayNoiseZ) * balloonConfig.Pivot:ToObjectSpace(balloonConfig.Up)
			else
				if balloonConfig.Phase ~= "Down" then
					balloonConfig.Phase = "Down"
				end
				balloonConfig.Part.CFrame = balloonConfig.Up:Lerp(balloonConfig.Origin, (elapsedTime - (timingConfig.RestingTime + timingConfig.ActivatingTime + timingConfig.UpTime + timingConfig.AirTime)) / timingConfig.DownTime)
			end
		end
	end
end
local function initializeBalloonConfig(balloonInstance)
	local configTable = {
		Offset = balloonInstance:GetAttribute("Offset") or 0,
		Part = balloonInstance:WaitForChild("Main"),
		Origin = balloonInstance.Main.CFrame
	}
	configTable.Up = balloonInstance.Main.CFrame + Vector3.new(0, balloonCount.UpDist, 0)
	configTable.Pivot = balloonInstance.Main.CFrame + Vector3.new(0, balloonCount.UpDist + balloonCount.UpPivot, 0)
	configTable.Phase = "Resting"
	balloonConfigsByInstance[balloonInstance] = configTable
	balloonCount = balloonCount + 1
end
local function cleanupBalloonConfig(balloonInstance)
	if balloonConfigsByInstance[balloonInstance] then
		if balloonConfigsByInstance[balloonInstance].Part then
			balloonConfigsByInstance[balloonInstance].Part.CFrame = balloonConfigsByInstance[balloonInstance].Origin
		end
		balloonConfigsByInstance[balloonInstance] = nil
		balloonCount = balloonCount - 1
	end
end

local RunService = game:GetService("RunService")
local Trove = require(script.Trove)
local randomGenerator = Random.new()
local renderNameCounter = 0
local ShakeClass = {}
ShakeClass.__index = ShakeClass
function ShakeClass.new()
	local shakeInstance = setmetatable({}, ShakeClass)
	shakeInstance.Amplitude = 1
	shakeInstance.Frequency = 1
	shakeInstance.FadeInTime = 1
	shakeInstance.FadeOutTime = 1
	shakeInstance.SustainTime = 0
	shakeInstance.Sustain = false
	shakeInstance.PositionInfluence = Vector3.new(1, 1, 1)
	shakeInstance.RotationInfluence = Vector3.new(1, 1, 1)
	shakeInstance.TimeFunction = if RunService:IsRunning() then time else os.clock
	shakeInstance._timeOffset = randomGenerator:NextNumber(-1000000000, 1000000000)
	shakeInstance._startTime = 0
	shakeInstance._trove = Trove.new()
	shakeInstance._running = false
	return shakeInstance
end
function ShakeClass.InverseSquare(distance, falloff)
	if falloff < 1 then
		falloff = 1
	end
	return distance * (1 / (falloff * falloff))
end
function ShakeClass.NextRenderName()
	renderNameCounter = renderNameCounter + 1
	return ("__shake_%.4i__"):format(renderNameCounter)
end
function ShakeClass.Start(shakeInstance)
	shakeInstance._startTime = shakeInstance.TimeFunction()
	shakeInstance._running = true
	shakeInstance._trove:Add(function()
		shakeInstance._running = false
	end)
end
function ShakeClass.Stop(shakeInstance)
	shakeInstance._trove:Clean()
end
function ShakeClass.IsShaking(shakeInstance)
	return shakeInstance._running
end
function ShakeClass.StopSustain(shakeInstance)
	local currentTime = shakeInstance.TimeFunction()
	shakeInstance.Sustain = false
	shakeInstance.SustainTime = currentTime - shakeInstance._startTime - shakeInstance.FadeInTime
end
function ShakeClass.Update(shakeInstance)
	local shouldStop = false
	local currentTime = shakeInstance.TimeFunction()
	local elapsedTime = currentTime - shakeInstance._startTime
	local noisePhase = (currentTime + shakeInstance._timeOffset) / shakeInstance.Frequency % 1000000
	local fadeOutMultiplier = 1
	local fadeInMultiplier = if elapsedTime < shakeInstance.FadeInTime then elapsedTime / shakeInstance.FadeInTime else 1
	if not shakeInstance.Sustain and shakeInstance.FadeInTime + shakeInstance.SustainTime < elapsedTime then
		if shakeInstance.FadeOutTime == 0 then
			shouldStop = true
		else
			fadeOutMultiplier = 1 - (elapsedTime - shakeInstance.FadeInTime - shakeInstance.SustainTime) / shakeInstance.FadeOutTime
			if not shakeInstance.Sustain and shakeInstance.FadeInTime + shakeInstance.SustainTime + shakeInstance.FadeOutTime <= elapsedTime then
				shouldStop = true
			end
		end
	end
	local noiseX = math.noise(noisePhase, 0) / 2
	local noiseY = math.noise(0, noisePhase) / 2
	local noiseZ = math.noise(noisePhase, noisePhase) / 2
	local noiseVector = Vector3.new(noiseX, noiseY, noiseZ) * shakeInstance.Amplitude * math.min(fadeInMultiplier, fadeOutMultiplier)
	if shouldStop then
		shakeInstance:Stop()
	end
	return shakeInstance.PositionInfluence * noiseVector, shakeInstance.RotationInfluence * noiseVector, shouldStop
end
function ShakeClass.OnSignal(shakeInstance, signal, callback)
	return shakeInstance._trove:Connect(signal, function()
		callback(shakeInstance:Update())
	end)
end
function ShakeClass.BindToRenderStep(shakeInstance, renderStepName, priority, callback)
	shakeInstance._trove:BindToRenderStep(renderStepName, priority, function()
		callback(shakeInstance:Update())
	end)
end
function ShakeClass.Clone(shakeInstance)
	local clonedInstance = ShakeClass.new()
	for propertyIndex, propertyName in {
		"Amplitude",
		"Frequency",
		"FadeInTime",
		"FadeOutTime",
		"SustainTime",
		"Sustain",
		"PositionInfluence",
		"RotationInfluence",
		"TimeFunction"
	} do
		clonedInstance[propertyName] = shakeInstance[propertyName]
	end
	return clonedInstance
end
function ShakeClass.Destroy(shakeInstance)
	shakeInstance:Stop()
end
return ShakeClass

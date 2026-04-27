local t = {}
t.__index = t
local Vector3_new = Vector3.new
local noise = math.noise
t.CameraShakeState = {
	FadingIn = 0,
	FadingOut = 1,
	Sustained = 2,
	Inactive = 3
}
function t.new(magnitude, roughness, fadeInTime, fadeOutTime)
	if fadeInTime == nil then
		fadeInTime = 0
	end
	if fadeOutTime == nil then
		fadeOutTime = 0
	end
	assert(type(magnitude) == "number", "Magnitude must be a number")
	assert(type(roughness) == "number", "Roughness must be a number")
	assert(type(fadeInTime) == "number", "FadeInTime must be a number")
	assert(type(fadeOutTime) == "number", "FadeOutTime must be a number")
	local shakeInstance = {
		Magnitude = magnitude,
		Roughness = roughness,
		PositionInfluence = Vector3_new(),
		RotationInfluence = Vector3_new(),
		DeleteOnInactive = true,
		roughMod = 1,
		magnMod = 1,
		fadeOutDuration = fadeOutTime,
		fadeInDuration = fadeInTime
	}
	shakeInstance.sustain = fadeInTime > 0
	shakeInstance.currentFadeTime = if fadeInTime > 0 then 0 else 1
	shakeInstance.tick = Random.new():NextNumber(-100, 100)
	shakeInstance._camShakeInstance = true
	return setmetatable(shakeInstance, t)
end
function t.UpdateShake(shakeInstance, deltaTime)
	local tickValue = shakeInstance.tick
	local currentFadeTime = shakeInstance.currentFadeTime
	local noiseOffset = Vector3_new(noise(tickValue, 0) * 0.5, noise(0, tickValue) * 0.5, noise(tickValue, tickValue) * 0.5)
	if shakeInstance.fadeInDuration > 0 and shakeInstance.sustain then
		if currentFadeTime < 1 then
			currentFadeTime = currentFadeTime + deltaTime / shakeInstance.fadeInDuration
		elseif shakeInstance.fadeOutDuration > 0 then
			shakeInstance.sustain = false
		end
	end
	if not shakeInstance.sustain then
		currentFadeTime = currentFadeTime - deltaTime / shakeInstance.fadeOutDuration
	end
	if shakeInstance.sustain then
		shakeInstance.tick = tickValue + deltaTime * shakeInstance.Roughness * shakeInstance.roughMod
	else
		shakeInstance.tick = tickValue + deltaTime * shakeInstance.Roughness * shakeInstance.roughMod * currentFadeTime
	end
	shakeInstance.currentFadeTime = currentFadeTime
	return noiseOffset * shakeInstance.Magnitude * shakeInstance.magnMod * currentFadeTime
end
function t.StartFadeOut(shakeInstance, duration)
	if duration == 0 then
		shakeInstance.currentFadeTime = 0
	end
	shakeInstance.fadeOutDuration = duration
	shakeInstance.fadeInDuration = 0
	shakeInstance.sustain = false
end
function t.StartFadeIn(shakeInstance, duration)
	if duration == 0 then
		shakeInstance.currentFadeTime = 1
	end
	shakeInstance.fadeInDuration = duration or shakeInstance.fadeInDuration
	shakeInstance.fadeOutDuration = 0
	shakeInstance.sustain = true
end
function t.GetScaleRoughness(shakeInstance)
	return shakeInstance.roughMod
end
function t.SetScaleRoughness(shakeInstance, scaleFactor)
	shakeInstance.roughMod = scaleFactor
end
function t.GetScaleMagnitude(shakeInstance)
	return shakeInstance.magnMod
end
function t.SetScaleMagnitude(shakeInstance, scaleFactor)
	shakeInstance.magnMod = scaleFactor
end
function t.GetNormalizedFadeTime(shakeInstance)
	return shakeInstance.currentFadeTime
end
function t.IsShaking(shakeInstance)
	return if shakeInstance.currentFadeTime > 0 then true else shakeInstance.sustain
end
function t.IsFadingOut(shakeInstance)
	return not shakeInstance.sustain and shakeInstance.currentFadeTime > 0
end
function t.IsFadingIn(shakeInstance)
	return shakeInstance.currentFadeTime < 1 and (shakeInstance.sustain and shakeInstance.fadeInDuration > 0) or false
end
function t.GetState(shakeInstance)
	if shakeInstance:IsFadingIn() then
		return t.CameraShakeState.FadingIn
	elseif shakeInstance:IsFadingOut() then
		return t.CameraShakeState.FadingOut
	elseif shakeInstance:IsShaking() then
		return t.CameraShakeState.Sustained
	else
		return t.CameraShakeState.Inactive
	end
end
return t

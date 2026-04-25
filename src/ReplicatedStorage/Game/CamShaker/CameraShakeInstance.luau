-- Reviewed by Claude
-- variables reassigned
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
function t.new(p1, p2, p3, p4)
	if p3 == nil then
		p3 = 0
	end
	if p4 == nil then
		p4 = 0
	end
	assert(type(p1) == "number", "Magnitude must be a number")
	assert(type(p2) == "number", "Roughness must be a number")
	assert(type(p3) == "number", "FadeInTime must be a number")
	assert(type(p4) == "number", "FadeOutTime must be a number")
	local shakeInstance = {
		Magnitude = p1,
		Roughness = p2,
		PositionInfluence = Vector3_new(),
		RotationInfluence = Vector3_new(),
		DeleteOnInactive = true,
		roughMod = 1,
		magnMod = 1,
		fadeOutDuration = p4,
		fadeInDuration = p3
	}
	shakeInstance.sustain = p3 > 0
	shakeInstance.currentFadeTime = if p3 > 0 then 0 else 1
	shakeInstance.tick = Random.new():NextNumber(-100, 100)
	shakeInstance._camShakeInstance = true
	return setmetatable(shakeInstance, t)
end
function t.UpdateShake(p1, p2)
	local tickValue = p1.tick
	local currentFadeTime = p1.currentFadeTime
	local noiseOffset = Vector3_new(noise(tickValue, 0) * 0.5, noise(0, tickValue) * 0.5, noise(tickValue, tickValue) * 0.5)
	if p1.fadeInDuration > 0 and p1.sustain then
		if currentFadeTime < 1 then
			currentFadeTime = currentFadeTime + p2 / p1.fadeInDuration
		elseif p1.fadeOutDuration > 0 then
			p1.sustain = false
		end
	end
	if not p1.sustain then
		currentFadeTime = currentFadeTime - p2 / p1.fadeOutDuration
	end
	if p1.sustain then
		p1.tick = tickValue + p2 * p1.Roughness * p1.roughMod
	else
		p1.tick = tickValue + p2 * p1.Roughness * p1.roughMod * currentFadeTime
	end
	p1.currentFadeTime = currentFadeTime
	return noiseOffset * p1.Magnitude * p1.magnMod * currentFadeTime
end
function t.StartFadeOut(p1, p2)
	if p2 == 0 then
		p1.currentFadeTime = 0
	end
	p1.fadeOutDuration = p2
	p1.fadeInDuration = 0
	p1.sustain = false
end
function t.StartFadeIn(p1, p2)
	if p2 == 0 then
		p1.currentFadeTime = 1
	end
	p1.fadeInDuration = p2 or p1.fadeInDuration
	p1.fadeOutDuration = 0
	p1.sustain = true
end
function t.GetScaleRoughness(p1)
	return p1.roughMod
end
function t.SetScaleRoughness(p1, p2)
	p1.roughMod = p2
end
function t.GetScaleMagnitude(p1)
	return p1.magnMod
end
function t.SetScaleMagnitude(p1, p2)
	p1.magnMod = p2
end
function t.GetNormalizedFadeTime(p1)
	return p1.currentFadeTime
end
function t.IsShaking(p1)
	return if p1.currentFadeTime > 0 then true else p1.sustain
end
function t.IsFadingOut(p1)
	return not p1.sustain and p1.currentFadeTime > 0
end
function t.IsFadingIn(p1)
	return p1.currentFadeTime < 1 and (p1.sustain and p1.fadeInDuration > 0) or false
end
function t.GetState(p1)
	if p1:IsFadingIn() then
		return t.CameraShakeState.FadingIn
	elseif p1:IsFadingOut() then
		return t.CameraShakeState.FadingOut
	elseif p1:IsShaking() then
		return t.CameraShakeState.Sustained
	else
		return t.CameraShakeState.Inactive
	end
end
return t

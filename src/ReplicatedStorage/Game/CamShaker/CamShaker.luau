local t = {}
t.__index = t
local profilebegin = debug.profilebegin
local profileend = debug.profileend
local Vector3New = Vector3.new
local CFrameNew = CFrame.new
local Angles = CFrame.Angles
local rad = math.rad
local zeroVector3 = Vector3New()
local CameraShakeInstance = require(script.Parent.CameraShakeInstance)
local CameraShakeState = CameraShakeInstance.CameraShakeState
t.CameraShakeInstance = CameraShakeInstance
t.Presets = require(script.Parent.CameraShakePresets)
function t.new(renderPriority, callback)
	assert(type(renderPriority) == "number", "RenderPriority must be a number (e.g.: Enum.RenderPriority.Camera.Value)")
	assert(type(callback) == "function", "Callback must be a function")
	return setmetatable({
		_running = false,
		_renderName = "CameraShaker",
		_renderPriority = renderPriority,
		_posAddShake = zeroVector3,
		_rotAddShake = zeroVector3,
		_camShakeInstances = {},
		_removeInstances = {},
		_callback = callback
	}, t)
end
function t.Start(self)
	if not self._running then
		self._running = true
		local _callback = self._callback
		game:GetService("RunService"):BindToRenderStep(self._renderName, self._renderPriority, function(deltaTime)
			profilebegin("CameraShakerUpdate")
			local shakeCFrame = self:Update(deltaTime)
			profileend()
			_callback(shakeCFrame)
		end)
	end
end
function t.Stop(self)
	if self._running then
		game:GetService("RunService"):UnbindFromRenderStep(self._renderName)
		self._running = false
	end
end
function t.StopSustained(self, fadeDuration)
	for k, v in pairs(self._camShakeInstances) do
		local fadeOutTime
		if v.fadeOutDuration == 0 then
			fadeOutTime = fadeDuration or v.fadeInDuration
			v:StartFadeOut(fadeOutTime)
		end
	end
end
function t.Update(self, deltaTime)
	local positionOffset = zeroVector3
	local rotationOffset = zeroVector3
	local _camShakeInstances = self._camShakeInstances
	for i = 1, #_camShakeInstances do
		local shakeInstance = _camShakeInstances[i]
		local shakeState = shakeInstance:GetState()
		if shakeState == CameraShakeState.Inactive and shakeInstance.DeleteOnInactive then
			self._removeInstances[#self._removeInstances + 1] = i
		elseif shakeState ~= CameraShakeState.Inactive then
			local shakeOffset = shakeInstance:UpdateShake(deltaTime)
			positionOffset = positionOffset + shakeOffset * shakeInstance.PositionInfluence
			rotationOffset = rotationOffset + shakeOffset * shakeInstance.RotationInfluence
		end
	end
	for j = #self._removeInstances, 1, -1 do
		table.remove(_camShakeInstances, self._removeInstances[j])
		self._removeInstances[j] = nil
	end
	return CFrameNew(positionOffset) * Angles(0, rad(rotationOffset.Y), 0) * Angles(rad(rotationOffset.X), 0, (rad(rotationOffset.Z)))
end
function t.Shake(self, shakeInstance)
	assert(if type(shakeInstance) == "table" then shakeInstance._camShakeInstance else false, "ShakeInstance must be of type CameraShakeInstance")
	self._camShakeInstances[#self._camShakeInstances + 1] = shakeInstance
	return shakeInstance
end
function t.ShakeSustain(self, shakeInstance)
	assert(if type(shakeInstance) == "table" then shakeInstance._camShakeInstance else false, "ShakeInstance must be of type CameraShakeInstance")
	self._camShakeInstances[#self._camShakeInstances + 1] = shakeInstance
	shakeInstance:StartFadeIn(shakeInstance.fadeInDuration)
	return shakeInstance
end
function t.ShakeOnce(self, frequency, amplitude, duration, posInfluence, rotInfluence)
	local shakeInstance = CameraShakeInstance.new(frequency, amplitude, duration)
	shakeInstance.PositionInfluence = if typeof(posInfluence) == "Vector3" and posInfluence then posInfluence else Vector3New(0.15, 0.15, 0.15)
	shakeInstance.RotationInfluence = if typeof(rotInfluence) == "Vector3" and rotInfluence then rotInfluence else Vector3New(1, 1, 1)
	self._camShakeInstances[#self._camShakeInstances + 1] = shakeInstance
	return shakeInstance
end
function t.StartShake(self, frequency, amplitude, duration, posInfluence, rotInfluence)
	local shakeInstance = CameraShakeInstance.new(frequency, amplitude, duration)
	shakeInstance.PositionInfluence = if typeof(posInfluence) == "Vector3" and posInfluence then posInfluence else Vector3New(0.15, 0.15, 0.15)
	shakeInstance.RotationInfluence = if typeof(rotInfluence) == "Vector3" and rotInfluence then rotInfluence else Vector3New(1, 1, 1)
	shakeInstance:StartFadeIn(duration)
	self._camShakeInstances[#self._camShakeInstances + 1] = shakeInstance
	return shakeInstance
end
return t

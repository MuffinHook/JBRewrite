-- Reviewed by Claude
-- variables reassigned
local CameraShakeInstance = require(script.Parent.CameraShakeInstance)
local presets = {
	Bump = function()
		local shakeInstance = CameraShakeInstance.new(2.5, 4, 0.1, 0.75)
		shakeInstance.PositionInfluence = Vector3.new(0.15, 0.15, 0.15)
		shakeInstance.RotationInfluence = Vector3.new(1, 1, 1)
		return shakeInstance
	end,
	Explosion = function()
		local shakeInstance = CameraShakeInstance.new(5, 10, 0, 1.5)
		shakeInstance.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
		shakeInstance.RotationInfluence = Vector3.new(4, 1, 1)
		return shakeInstance
	end,
	Earthquake = function()
		local shakeInstance = CameraShakeInstance.new(0.6, 3.5, 2, 10)
		shakeInstance.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
		shakeInstance.RotationInfluence = Vector3.new(1, 1, 4)
		return shakeInstance
	end,
	BadTrip = function()
		local shakeInstance = CameraShakeInstance.new(10, 0.15, 5, 10)
		shakeInstance.PositionInfluence = Vector3.new(0, 0, 0.15)
		shakeInstance.RotationInfluence = Vector3.new(2, 1, 4)
		return shakeInstance
	end,
	HandheldCamera = function()
		local shakeInstance = CameraShakeInstance.new(1, 0.25, 5, 10)
		shakeInstance.PositionInfluence = Vector3.new(0, 0, 0)
		shakeInstance.RotationInfluence = Vector3.new(1, 0.5, 0.5)
		return shakeInstance
	end,
	Vibration = function()
		local shakeInstance = CameraShakeInstance.new(0.4, 20, 2, 2)
		shakeInstance.PositionInfluence = Vector3.new(0, 0.15, 0)
		shakeInstance.RotationInfluence = Vector3.new(1.25, 0, 4)
		return shakeInstance
	end,
	RoughDriving = function()
		local shakeInstance = CameraShakeInstance.new(1, 2, 1, 1)
		shakeInstance.PositionInfluence = Vector3.new(0, 0, 0)
		shakeInstance.RotationInfluence = Vector3.new(1, 1, 1)
		return shakeInstance
	end
}
return setmetatable({}, {
	__index = function(self, index)
		local shakeInstance = presets[index]
		if type(shakeInstance) == "function" then
			return shakeInstance()
		end
		error("No preset found with index \"" .. index .. "\"")
	end
})

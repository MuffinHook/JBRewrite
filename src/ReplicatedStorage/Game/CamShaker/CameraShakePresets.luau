local CameraShakeInstance = require(script.Parent.CameraShakeInstance)
local t = {
	Bump = function() --[[ Name: Bump | Line: 23 | Upvalues: CameraShakeInstance (copy) ]]
		local v1 = CameraShakeInstance.new(2.5, 4, 0.1, 0.75)
		v1.PositionInfluence = Vector3.new(0.15, 0.15, 0.15)
		v1.RotationInfluence = Vector3.new(1, 1, 1)
		return v1
	end,
	Explosion = function() --[[ Name: Explosion | Line: 32 | Upvalues: CameraShakeInstance (copy) ]]
		local v1 = CameraShakeInstance.new(5, 10, 0, 1.5)
		v1.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
		v1.RotationInfluence = Vector3.new(4, 1, 1)
		return v1
	end,
	Earthquake = function() --[[ Name: Earthquake | Line: 41 | Upvalues: CameraShakeInstance (copy) ]]
		local v1 = CameraShakeInstance.new(0.6, 3.5, 2, 10)
		v1.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
		v1.RotationInfluence = Vector3.new(1, 1, 4)
		return v1
	end,
	BadTrip = function() --[[ Name: BadTrip | Line: 50 | Upvalues: CameraShakeInstance (copy) ]]
		local v1 = CameraShakeInstance.new(10, 0.15, 5, 10)
		v1.PositionInfluence = Vector3.new(0, 0, 0.15)
		v1.RotationInfluence = Vector3.new(2, 1, 4)
		return v1
	end,
	HandheldCamera = function() --[[ Name: HandheldCamera | Line: 59 | Upvalues: CameraShakeInstance (copy) ]]
		local v1 = CameraShakeInstance.new(1, 0.25, 5, 10)
		v1.PositionInfluence = Vector3.new(0, 0, 0)
		v1.RotationInfluence = Vector3.new(1, 0.5, 0.5)
		return v1
	end,
	Vibration = function() --[[ Name: Vibration | Line: 68 | Upvalues: CameraShakeInstance (copy) ]]
		local v1 = CameraShakeInstance.new(0.4, 20, 2, 2)
		v1.PositionInfluence = Vector3.new(0, 0.15, 0)
		v1.RotationInfluence = Vector3.new(1.25, 0, 4)
		return v1
	end,
	RoughDriving = function() --[[ Name: RoughDriving | Line: 77 | Upvalues: CameraShakeInstance (copy) ]]
		local v1 = CameraShakeInstance.new(1, 2, 1, 1)
		v1.PositionInfluence = Vector3.new(0, 0, 0)
		v1.RotationInfluence = Vector3.new(1, 1, 1)
		return v1
	end
}
return setmetatable({}, {
	__index = function(p1, p2) --[[ Name: __index | Line: 86 | Upvalues: t (copy) ]]
		local v1 = t[p2]
		if type(v1) == "function" then
			return v1()
		end
		error("No preset found with index \"" .. p2 .. "\"")
	end
})
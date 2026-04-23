local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RayCast = require(ReplicatedStorage.Module.RayCast)
local t = {}
t.__index = t
function t.new(p1) --[[ Line: 21 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)
	v2.Origin = p1
	v2.Target = nil
	v2.Velocity = nil
	v2._PrevUpdatePosition = v2.Origin
	v2._GetNow = os.clock
	v2.Birthdate = v2:_GetNow()
	v2.Gravity = workspace.Gravity
	v2.CollidableFunc = nil
	v2._GravityVector = Vector3.new(0, -v2.Gravity, 0)
	v2.IgnoreList = {}
	return v2
end
function t.CalculateVelocityToHitTargetWithSpeed(p1, p2, p3, p4, p5) --[[ Line: 35 ]]
	local v1 = p2 - p1
	local v2 = (v1.x * v1.x + v1.z * v1.z) ^ 0.5
	local v3 = p3 * p3 * p3 * p3 - p4 * (p4 * v2 * v2 + 2 * v1.y * p3 * p3)
	local v4
	if v3 >= 0 then
		local v5 = v3 ^ 0.5
		local v6 = math.atan((p3 * p3 + v5) / (p4 * v2))
		local v7 = math.atan((p3 * p3 - v5) / (p4 * v2))
		v4 = if p5 then math.max(v6, v7) else math.min(v6, v7)
	else
		v4 = 0.7853981633974483
	end
	local v10 = p3 * v1.x / v2 * math.cos(v4)
	local v11 = p3 * math.sin(v4)
	return Vector3.new(v10, v11, p3 * v1.z / v2 * math.cos(v4)), v2 / (p3 * math.cos(v4))
end
function t.HitTargetWithSpeed(p1, p2, p3, p4) --[[ Line: 68 | Upvalues: t (copy) ]]
	p1.Target = p2
	local v1, v2 = t.CalculateVelocityToHitTargetWithSpeed(p1.Origin, p2, p3, p1.Gravity, p4)
	p1.Velocity = v1
	p1.Duration = v2
	return true
end
function t.CalculateElapsedPosition(p1, p2) --[[ Line: 80 ]]
	assert(p2 ~= nil)
	return p1.Origin + p1.Velocity * p2 + 0.5 * p1._GravityVector * p2 * p2
end
function t.Step(p1, p2, p3) --[[ Line: 85 | Upvalues: RayCast (copy) ]]
	assert(p2)
	assert(p1.Velocity)
	local v2 = p1:CalculateElapsedPosition(p2 - p1.Birthdate)
	local v3 = v2 - p3
	local v4, v5 = RayCast.RayIgnoreNonCollideWithIgnoreList(p3, v3.Unit, v3.Magnitude, p1.IgnoreList, nil, nil, p1.CollidableFunc)
	if v4 then
		return v5, true, v4
	else
		return v2, false
	end
end
function t.Update(p1) --[[ Line: 106 ]]
	local v1, v2 = p1:Step(p1:_GetNow(), p1._PrevUpdatePosition)
	p1._PrevUpdatePosition = v1
	return v1, v2
end
function t.CalculateNextInstantCollision(p1, p2) --[[ Line: 114 ]]
	local v1, v2 = p1:Update()
	if v2 then
		return v1, 0
	else
		local FallenPartsDestroyHeight = workspace.FallenPartsDestroyHeight
		local sum = p1:_GetNow()
		local v3 = sum
		local v4
		while true do
			sum = sum + p2
			local v5
			v4, v5 = p1:Step(sum, v1)
			if v5 or v4.y <= FallenPartsDestroyHeight then
				break
			end
			v1 = v4
		end
		return v4, sum - v3
	end
end
function t.GetElapsed(p1) --[[ Line: 131 ]]
	return p1:_GetNow() - p1.Birthdate
end
return t
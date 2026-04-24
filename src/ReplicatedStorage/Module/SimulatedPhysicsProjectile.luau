-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RayCast = require(ReplicatedStorage.Module.RayCast)
local t = {}
t.__index = t
function t.new(p1)
	local table2 = setmetatable({}, t)
	table2.Origin = p1
	table2.Target = nil
	table2.Velocity = nil
	table2._PrevUpdatePosition = table2.Origin
	table2._GetNow = os.clock
	table2.Birthdate = table2:_GetNow()
	table2.Gravity = workspace.Gravity
	table2.CollidableFunc = nil
	table2._GravityVector = Vector3.new(0, -table2.Gravity, 0)
	table2.IgnoreList = {}
	return table2
end
function t.CalculateVelocityToHitTargetWithSpeed(p1, p2, p3, p4, p5)
	local delta = p2 - p1
	local table2 = (delta.x * delta.x + delta.z * delta.z) ^ 0.5
	local var3 = p3 * p3 * p3 * p3 - p4 * (p4 * table2 * table2 + 2 * delta.y * p3 * p3)
	local v4
	if var3 >= 0 then
		local var5 = var3 ^ 0.5
		local var6 = math.atan((p3 * p3 + var5) / (p4 * table2))
		local var7 = math.atan((p3 * p3 - var5) / (p4 * table2))
		v4 = if p5 then math.max(var6, var7) else math.min(var6, var7)
	else
		v4 = 0.7853981633974483
	end
	local var10 = p3 * delta.x / table2 * math.cos(v4)
	local var11 = p3 * math.sin(v4)
	return Vector3.new(var10, var11, p3 * delta.z / table2 * math.cos(v4)), table2 / (p3 * math.cos(v4))
end
function t.HitTargetWithSpeed(p1, p2, p3, p4)
	p1.Target = p2
	local delta, table2 = t.CalculateVelocityToHitTargetWithSpeed(p1.Origin, p2, p3, p1.Gravity, p4)
	p1.Velocity = delta
	p1.Duration = table2
	return true
end
function t.CalculateElapsedPosition(p1, p2)
	assert(p2 ~= nil)
	return p1.Origin + p1.Velocity * p2 + 0.5 * p1._GravityVector * p2 * p2
end
function t.Step(p1, p2, p3)
	assert(p2)
	assert(p1.Velocity)
	local table2 = p1:CalculateElapsedPosition(p2 - p1.Birthdate)
	local var3 = table2 - p3
	local v4, var5 = RayCast.RayIgnoreNonCollideWithIgnoreList(p3, var3.Unit, var3.Magnitude, p1.IgnoreList, nil, nil, p1.CollidableFunc)
	if v4 then
		return var5, true, v4
	else
		return table2, false
	end
end
function t.Update(p1)
	local delta, table2 = p1:Step(p1:_GetNow(), p1._PrevUpdatePosition)
	p1._PrevUpdatePosition = delta
	return delta, table2
end
function t.CalculateNextInstantCollision(p1, p2)
	local delta, table2 = p1:Update()
	if table2 then
		return delta, 0
	else
		local FallenPartsDestroyHeight = workspace.FallenPartsDestroyHeight
		local sum = p1:_GetNow()
		local var3 = sum
		local v4
		while true do
			sum = sum + p2
			local var5
			v4, var5 = p1:Step(sum, delta)
			if var5 or v4.y <= FallenPartsDestroyHeight then
				break
			end
			delta = v4
		end
		return v4, sum - var3
	end
end
function t.GetElapsed(p1)
	return p1:_GetNow() - p1.Birthdate
end
return t

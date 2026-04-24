-- Reviewed by Claude
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Binder = require(ReplicatedStorage.Std.Binder)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local PlaneConsts = require(ReplicatedStorage.Plane.PlaneConsts)
local PlaneUtils = require(ReplicatedStorage.Plane.PlaneUtils)
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(p1)
	local v1 = BaseObject.new(p1)
	setmetatable(v1, t)
	v1.maid:GiveTask(RxInstanceUtils.observeAttribute(p1, PlaneConsts.BORN_AT_ATTR_NAME, function(p1, p2)
		if p1 then
			p2:GiveTask(RunService.Heartbeat:Connect(function()
				v1:_update(p1)
			end))
		end
	end))
	v1._lastPosition = Vector3.new()
	return v1
end
function t._update(p1, p2)
	local v1 = workspace:GetServerTimeNow() - p2
	local v2 = p1:GetDuration()
	local v3 = math.cos(v1)
	local v4 = p1:GetPositionAt(v1)
	p1.obj:PivotTo(CFrame.new(v4, p1._lastPosition) * CFrame.Angles(0, math.pi, 0) * CFrame.Angles(0, 0, v3 * 0.4))
	p1._lastPosition = v4
	if v1 < 1 then
		local v5 = math.max(0, 1 - (v1 - 0) / 1)
		p1.obj.Engine.Transparency = v5
		p1.obj.Wings.Transparency = v5
	elseif v2 - 1 < v1 then
		local v6 = math.min(1, (v1 - v2 + 1) / 1)
		p1.obj.Engine.Transparency = v6
		p1.obj.Wings.Transparency = v6
	end
end
function t.SetOrigin(p1, p2)
	return PlaneUtils.setOrigin(p1.obj, p2)
end
function t.GetOrigin(p1)
	return PlaneUtils.getOrigin(p1.obj)
end
function t.SetTarget(p1, p2)
	return PlaneUtils.setTarget(p1.obj, p2)
end
function t.GetTarget(p1)
	return PlaneUtils.getTarget(p1.obj)
end
function t.SetSpeed(p1, p2)
	return PlaneUtils.setSpeed(p1.obj, p2)
end
function t.GetSpeed(p1)
	return PlaneUtils.getSpeed(p1.obj)
end
function t.SetTypeEnum(p1, p2)
	return PlaneUtils.setTypeEnum(p1.obj, p2)
end
function t.GetTypeEnum(p1)
	return PlaneUtils.getTypeEnum(p1.obj)
end
function t.SetBornAt(p1, p2)
	return PlaneUtils.setBornAt(p1.obj, p2)
end
function t.GetBornAt(p1)
	return PlaneUtils.getBornAt(p1.obj)
end
function t.GetDuration(p1)
	local v1 = p1:GetOrigin()
	local v2 = p1:GetTarget()
	local v3 = p1:GetSpeed()
	assert(v3 > 0, "speed must be > 0")
	return (v2 - v1).Magnitude / v3
end
function t.GetPositionAt(p1, p2)
	local v1 = p1:GetOrigin()
	if v1 then
		local v2 = p1:GetTarget()
		if v2 then
			return PlaneUtils.getPositionAt(p2, v1, v2, PlaneConsts.DRIFT_WIDTH, (p1:GetDuration()))
		end
	end
end
return Binder.new(PlaneConsts.TAG_NAME, t)

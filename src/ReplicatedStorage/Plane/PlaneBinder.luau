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
function t.new(p1) --[[ Line: 14 | Upvalues: BaseObject (copy), t (copy), RxInstanceUtils (copy), PlaneConsts (copy), RunService (copy) ]]
	local v1 = BaseObject.new(p1)
	setmetatable(v1, t)
	v1.maid:GiveTask(RxInstanceUtils.observeAttribute(p1, PlaneConsts.BORN_AT_ATTR_NAME, function(p1, p2) --[[ Line: 18 | Upvalues: RunService (ref), v1 (copy) ]]
		if p1 then
			p2:GiveTask(RunService.Heartbeat:Connect(function() --[[ Line: 22 | Upvalues: v1 (ref), p1 (copy) ]]
				v1:_update(p1)
			end))
		end
	end))
	v1._lastPosition = Vector3.new()
	return v1
end
function t._update(p1, p2) --[[ Line: 31 ]]
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
function t.SetOrigin(p1, p2) --[[ Line: 55 | Upvalues: PlaneUtils (copy) ]]
	return PlaneUtils.setOrigin(p1.obj, p2)
end
function t.GetOrigin(p1) --[[ Line: 58 | Upvalues: PlaneUtils (copy) ]]
	return PlaneUtils.getOrigin(p1.obj)
end
function t.SetTarget(p1, p2) --[[ Line: 61 | Upvalues: PlaneUtils (copy) ]]
	return PlaneUtils.setTarget(p1.obj, p2)
end
function t.GetTarget(p1) --[[ Line: 64 | Upvalues: PlaneUtils (copy) ]]
	return PlaneUtils.getTarget(p1.obj)
end
function t.SetSpeed(p1, p2) --[[ Line: 67 | Upvalues: PlaneUtils (copy) ]]
	return PlaneUtils.setSpeed(p1.obj, p2)
end
function t.GetSpeed(p1) --[[ Line: 70 | Upvalues: PlaneUtils (copy) ]]
	return PlaneUtils.getSpeed(p1.obj)
end
function t.SetTypeEnum(p1, p2) --[[ Line: 73 | Upvalues: PlaneUtils (copy) ]]
	return PlaneUtils.setTypeEnum(p1.obj, p2)
end
function t.GetTypeEnum(p1) --[[ Line: 76 | Upvalues: PlaneUtils (copy) ]]
	return PlaneUtils.getTypeEnum(p1.obj)
end
function t.SetBornAt(p1, p2) --[[ Line: 79 | Upvalues: PlaneUtils (copy) ]]
	return PlaneUtils.setBornAt(p1.obj, p2)
end
function t.GetBornAt(p1) --[[ Line: 82 | Upvalues: PlaneUtils (copy) ]]
	return PlaneUtils.getBornAt(p1.obj)
end
function t.GetDuration(p1) --[[ Line: 85 ]]
	local v1 = p1:GetOrigin()
	local v2 = p1:GetTarget()
	local v3 = p1:GetSpeed()
	assert(v3 > 0, "speed must be > 0")
	return (v2 - v1).Magnitude / v3
end
function t.GetPositionAt(p1, p2) --[[ Line: 94 | Upvalues: PlaneUtils (copy), PlaneConsts (copy) ]]
	local v1 = p1:GetOrigin()
	if v1 then
		local v2 = p1:GetTarget()
		if v2 then
			return PlaneUtils.getPositionAt(p2, v1, v2, PlaneConsts.DRIFT_WIDTH, (p1:GetDuration()))
		end
	end
end
return Binder.new(PlaneConsts.TAG_NAME, t)
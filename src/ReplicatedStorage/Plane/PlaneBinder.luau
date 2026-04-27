local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Binder = require(ReplicatedStorage.Std.Binder)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local PlaneConsts = require(ReplicatedStorage.Plane.PlaneConsts)
local PlaneUtils = require(ReplicatedStorage.Plane.PlaneUtils)
local PlaneBinder = {}
PlaneBinder.__index = PlaneBinder
setmetatable(PlaneBinder, BaseObject)
function PlaneBinder.new(parent)
	local self = BaseObject.new(parent)
	setmetatable(self, PlaneBinder)
	self.maid:GiveTask(RxInstanceUtils.observeAttribute(parent, PlaneConsts.BORN_AT_ATTR_NAME, function(bornAt, maid)
		if bornAt then
			maid:GiveTask(RunService.Heartbeat:Connect(function()
				self:_update(bornAt)
			end))
		end
	end))
	self._lastPosition = Vector3.new()
	return self
end
function PlaneBinder._update(self, birthTime)
	local elapsedTime = workspace:GetServerTimeNow() - birthTime
	local duration = self:GetDuration()
	local rollAngle = math.cos(elapsedTime)
	local currentPosition = self:GetPositionAt(elapsedTime)
	self.obj:PivotTo(CFrame.new(currentPosition, self._lastPosition) * CFrame.Angles(0, math.pi, 0) * CFrame.Angles(0, 0, rollAngle * 0.4))
	self._lastPosition = currentPosition
	if elapsedTime < 1 then
		local spawnTransparency = math.max(0, 1 - (elapsedTime - 0) / 1)
		self.obj.Engine.Transparency = spawnTransparency
		self.obj.Wings.Transparency = spawnTransparency
	elseif duration - 1 < elapsedTime then
		local despawnTransparency = math.min(1, (elapsedTime - duration + 1) / 1)
		self.obj.Engine.Transparency = despawnTransparency
		self.obj.Wings.Transparency = despawnTransparency
	end
end
function PlaneBinder.SetOrigin(self, origin)
	return PlaneUtils.setOrigin(self.obj, origin)
end
function PlaneBinder.GetOrigin(self)
	return PlaneUtils.getOrigin(self.obj)
end
function PlaneBinder.SetTarget(self, target)
	return PlaneUtils.setTarget(self.obj, target)
end
function PlaneBinder.GetTarget(self)
	return PlaneUtils.getTarget(self.obj)
end
function PlaneBinder.SetSpeed(self, speed)
	return PlaneUtils.setSpeed(self.obj, speed)
end
function PlaneBinder.GetSpeed(self)
	return PlaneUtils.getSpeed(self.obj)
end
function PlaneBinder.SetTypeEnum(self, typeEnum)
	return PlaneUtils.setTypeEnum(self.obj, typeEnum)
end
function PlaneBinder.GetTypeEnum(self)
	return PlaneUtils.getTypeEnum(self.obj)
end
function PlaneBinder.SetBornAt(self, bornAt)
	return PlaneUtils.setBornAt(self.obj, bornAt)
end
function PlaneBinder.GetBornAt(self)
	return PlaneUtils.getBornAt(self.obj)
end
function PlaneBinder.GetDuration(self)
	local origin = self:GetOrigin()
	local target = self:GetTarget()
	local speed = self:GetSpeed()
	assert(speed > 0, "speed must be > 0")
	return (target - origin).Magnitude / speed
end
function PlaneBinder.GetPositionAt(self, elapsedTime)
	local origin = self:GetOrigin()
	if origin then
		local target = self:GetTarget()
		if target then
			return PlaneUtils.getPositionAt(elapsedTime, origin, target, PlaneConsts.DRIFT_WIDTH, (self:GetDuration()))
		end
	end
end
return Binder.new(PlaneConsts.TAG_NAME, PlaneBinder)

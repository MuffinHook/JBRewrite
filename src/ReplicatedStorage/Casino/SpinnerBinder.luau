local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local DoorConsts = require(ReplicatedStorage.Door2.DoorConsts)
local ManifestBinder = require(ReplicatedStorage.ManifestBinder)
local SpinnerConsts = require(script.Parent.SpinnerConsts)
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(spinnerObj, manifest)
	local spinnerInstance = BaseObject.new(spinnerObj)
	setmetatable(spinnerInstance, t)
	spinnerInstance.manifest = manifest
	spinnerInstance._pos = 0
	spinnerInstance._vel = 0
	spinnerInstance:_updateSpinning()
	spinnerInstance.maid:GiveTask(spinnerObj:GetAttributeChangedSignal(SpinnerConsts.ENABLED_ATTR_NAME):Connect(function()
		spinnerInstance:_updateSpinning()
	end))
	spinnerInstance._fadeOut = false
	return spinnerInstance
end
function t._updateSpinning(self)
	if self.obj:GetAttribute(SpinnerConsts.ENABLED_ATTR_NAME) == true then
		local accelValue = self.obj:GetAttribute(SpinnerConsts.ACCEL_ATTR_NAME) or 1
		local dragPercent = self.obj:GetAttribute(SpinnerConsts.DRAG_PCT_ATTR_NAME) or 0.05
		self._fadeOut = false
		self.maid.spinning = RunService.Heartbeat:Connect(function(deltaTime)
			if not self._fadeOut then
				self._vel = self._vel + accelValue * 1 * deltaTime
			end
			self._vel = self._vel * (1 - dragPercent)
			self._pos = self._pos + self._vel * deltaTime
			self.manifest.innerModel:PivotTo(self.obj:GetPivot() * CFrame.Angles(0, self._pos, 0))
			if self._fadeOut and math.abs(self._vel) < 0.1 then
				self.maid.spinning = nil
			end
		end)
	else
		self._fadeOut = true
	end
end
return ManifestBinder.new(SpinnerConsts.TAG_NAME, {
	innerModel = DoorConsts.INNER_MODEL_NAME
}, t)
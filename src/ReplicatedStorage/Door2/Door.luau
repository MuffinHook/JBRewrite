-- Reviewed by Claude
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local DoorConsts = require(script.Parent.DoorConsts)
local DoorUtils = require(script.Parent.DoorUtils)
local Door = {}
Door.__index = Door
function Door.new(door, config)
	local self = {}
	setmetatable(self, Door)
	self._maid = Maid.new()
	self._updateCallback = nil
	self._maid:GiveTask(door:GetAttributeChangedSignal(DoorConsts.OPEN_ATTR_NAME):Connect(function()
		self:_updateEndJ(door, if door:GetAttribute(DoorConsts.OPEN_ATTR_NAME) == true then 1 else 0)
	end))
	self._maid:GiveTask(door:GetAttributeChangedSignal(DoorConsts.MAX_ANGLE_ATTR_NAME):Connect(function()
		local percentOpen = door:GetAttribute(DoorConsts.PCT_OPEN_ATTR_NAME)
		if percentOpen == nil then
			percentOpen = if door:GetAttribute(DoorConsts.OPEN_ATTR_NAME) then 1 else 0
		end
		self:_updateEndJ(door, percentOpen)
	end))
	self._maid:GiveTask(door:GetAttributeChangedSignal(DoorConsts.PCT_OPEN_ATTR_NAME):Connect(function()
		self:_updateEndJ(door, (door:GetAttribute(DoorConsts.PCT_OPEN_ATTR_NAME)))
	end))
	self._maid:GiveTask(RxInstanceUtils.observeProperty(door, "PrimaryPart", function(primaryPart, maid)
		if primaryPart then
			maid:GiveTask(RxInstanceUtils.observeProperty(config.innerModel, "PrimaryPart", function(primaryPart)
				if primaryPart then
					local percentOpen = door:GetAttribute(DoorConsts.PCT_OPEN_ATTR_NAME)
					if percentOpen == nil then
						percentOpen = if door:GetAttribute(DoorConsts.OPEN_ATTR_NAME) then 1 else 0
					end
					self._lastJ = percentOpen
					self:_updateEndJ(door, percentOpen, true)
				end
			end))
		end
	end))
	return self
end
function Door.SetUpdateCallback(self, callback)
	self._updateCallback = callback
	return function()
		if self._updateCallback == callback then
			self._updateCallback = nil
			return true
		else
			return false
		end
	end
end
function Door._updateEndJ(self, door, percentOpen, skipAnimation)
	local innerModel = door:FindFirstChild(DoorConsts.INNER_MODEL_NAME)
	local PrimaryPart = door.PrimaryPart
	local duration = door:GetAttribute(DoorConsts.DURATION_ATTR_NAME)
	local shouldSwing = door:GetAttribute(DoorConsts.SHOULD_SWING_ATTR_NAME)
	local maxAngle = door:GetAttribute(DoorConsts.MAX_ANGLE_ATTR_NAME)
	local motorObject = PrimaryPart:FindFirstChild(DoorConsts.MOTOR_OBJ_NAME)
	local easingDirection = Enum.EasingDirection[door:GetAttribute(DoorConsts.EASING_DIRECTION_ATTR_NAME)]
	local easingStyle = Enum.EasingStyle[door:GetAttribute(DoorConsts.EASING_STYLE_ATTR_NAME)]
	local maxValue = if shouldSwing then maxAngle else innerModel.PrimaryPart.Size.X
	local targetValue = percentOpen * maxValue
	if skipAnimation then
		self._lastValue = targetValue
		DoorUtils.setValue(door, targetValue)
		if self._updateCallback then
			self._updateCallback(targetValue)
		end
	else
		local valueDelta = targetValue - self._lastValue
		local animationDuration = math.abs(valueDelta) / math.abs(maxValue) * duration
		local startTime = os.clock()
		local previousProgress = 0
		self._maid._animator = RunService.Heartbeat:Connect(function()
			local currentTime = os.clock()
			local progress = TweenService:GetValue((currentTime - startTime) / animationDuration, easingStyle, easingDirection)
			local progressDelta = progress - previousProgress
			previousProgress = progress
			local currentValue = self._lastValue + valueDelta * progressDelta
			if animationDuration <= currentTime - startTime then
				currentValue = targetValue
				self._maid._animator = nil
			end
			self._lastValue = currentValue
			DoorUtils.setValueRaw(PrimaryPart, innerModel, motorObject, shouldSwing, currentValue)
			if self._updateCallback then
				self._updateCallback(currentValue, (math.abs(currentValue / valueDelta)))
			end
		end)
	end
end
function Door.Destroy(self)
	self._maid:Destroy()
	self._maid = nil
	setmetatable(self, nil)
end
return Door

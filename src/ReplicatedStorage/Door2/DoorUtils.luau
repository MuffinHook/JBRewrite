local DoorConsts = require(script.Parent.DoorConsts)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Joint = require(ReplicatedStorage.Std.Joint)
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local Players = game:GetService("Players")
local DoorUtils = {
	setup = function(door, shouldSetupMotor)
		local PrimaryPart = door.PrimaryPart
		if not PrimaryPart then
			error("Missing PrimaryPart for door: " .. door:GetFullName())
		end
		local Part = Instance.new("Part")
		Part.Size = Vector3.new(1, 1, 1)
		Part.Anchored = true
		Part.CFrame = PrimaryPart.CFrame
		Part.CanCollide = false
		Part.Transparency = 1
		local Model = Instance.new("Model")
		Model.PrimaryPart = PrimaryPart
		Model.Name = DoorConsts.INNER_MODEL_NAME
		for i, child in ipairs(door:GetChildren()) do
			if not (child:IsA("BasePart") or child:IsA("Model")) then
				task.delay(3, function()
					local isDevUser = false
					if RunService:IsServer() then
						local playerUserIds = TableUtils.map(Players:GetPlayers(), function(player)
							return player.UserId
						end)
						if table.find(playerUserIds, 2025110) or table.find(playerUserIds, 25881764) then
							isDevUser = true
						end
					elseif Players.LocalPlayer.UserId == 2025110 or Players.LocalPlayer.UserId == 25881764 then
						isDevUser = true
					end
					if isDevUser then
						warn("ONLY SHOWN FOR ALEX: [Door2] Not recommended to have non-basepart in Door model: " .. child.ClassName .. " @ " .. child:GetFullName())
					end
				end)
			end
			child.Parent = Model
		end
		Model.Parent = door
		Part.Parent = door
		door.PrimaryPart = Part
		if shouldSetupMotor then
			Joint.WeldAllTo(Model, PrimaryPart)
			local motorJoint = Joint.BlankMotor(PrimaryPart, Part)
			motorJoint.Name = DoorConsts.MOTOR_OBJ_NAME
			motorJoint.Parent = Part
		end
		return Model
	end,
	getOpen = function(door)
		return door:GetAttribute(DoorConsts.OPEN_ATTR_NAME)
	end,
	setOpen = function(door, isOpen)
		assert(isOpen ~= nil)
		door:SetAttribute(DoorConsts.OPEN_ATTR_NAME, isOpen)
	end,
	getPctOpen = function(door)
		return door:GetAttribute(DoorConsts.PCT_OPEN_ATTR_NAME)
	end,
	setPctOpen = function(door, pctOpen)
		assert(pctOpen ~= nil, "missing pctOpen")
		door:SetAttribute(DoorConsts.PCT_OPEN_ATTR_NAME, pctOpen)
	end,
	getDoorOpenChangedSignal = function(door)
		return door:GetAttributeChangedSignal(DoorConsts.OPEN_ATTR_NAME)
	end,
	getDoorPctOpenChangedSignal = function(door)
		return door:GetAttributeChangedSignal(DoorConsts.PCT_OPEN_ATTR_NAME)
	end,
	getDuration = function(door)
		return door:GetAttribute(DoorConsts.DURATION_ATTR_NAME)
	end,
	setDuration = function(door, duration)
		assert(duration ~= nil)
		door:SetAttribute(DoorConsts.DURATION_ATTR_NAME, duration)
	end,
	getShouldSwing = function(door)
		return door:GetAttribute(DoorConsts.SHOULD_SWING_ATTR_NAME)
	end,
	setShouldSwing = function(door, shouldSwing)
		assert(shouldSwing ~= nil)
		door:SetAttribute(DoorConsts.SHOULD_SWING_ATTR_NAME, shouldSwing)
	end,
	getMaxAngle = function(door)
		return door:GetAttribute(DoorConsts.MAX_ANGLE_ATTR_NAME)
	end,
	setMaxAngle = function(door, maxAngle)
		assert(maxAngle ~= nil)
		door:SetAttribute(DoorConsts.MAX_ANGLE_ATTR_NAME, maxAngle)
	end,
	getInnerModel = function(door)
		return door:FindFirstChild(DoorConsts.INNER_MODEL_NAME)
	end,
	promiseInnerModel = function(door)
		return waitForChild(door, DoorConsts.INNER_MODEL_NAME, 10)
	end,
	setValueRaw = function(primaryPart, innerModel, motorJoint, shouldSwing, value)
		local cframeTransform = if shouldSwing then CFrame.Angles(0, value, 0) else CFrame.new(value, 0, 0)
		if motorJoint then
			motorJoint.C1 = cframeTransform
		else
			innerModel:PivotTo(primaryPart.CFrame * cframeTransform)
		end
	end
}
function DoorUtils.setValue(door, value)
	local PrimaryPart = door.PrimaryPart
	local innerModel = door:FindFirstChild(DoorConsts.INNER_MODEL_NAME)
	local shouldSwing = door:GetAttribute(DoorConsts.SHOULD_SWING_ATTR_NAME)
	DoorUtils.setValueRaw(PrimaryPart, innerModel, PrimaryPart:FindFirstChild(DoorConsts.MOTOR_OBJ_NAME), shouldSwing, value)
end
function DoorUtils.setFreezeStateOnServer(door, freezeState)
	door:SetAttribute(DoorConsts.FREEZE_SERVER_STATE_ATTR_NAME, freezeState)
end
function DoorUtils.setSnapStateOnServer(door, snapState)
	door:SetAttribute(DoorConsts.SNAP_SERVER_STATE_ATTR_NAME, snapState)
end
function DoorUtils.setEasingDirection(door, easingDirection)
	assert(door ~= nil)
	assert(typeof(easingDirection) == "EnumItem")
	door:SetAttribute(DoorConsts.EASING_DIRECTION_ATTR_NAME, easingDirection.Name)
end
function DoorUtils.setEasingStyle(door, easingStyle)
	assert(door ~= nil)
	assert(typeof(easingStyle) == "EnumItem")
	door:SetAttribute(DoorConsts.EASING_STYLE_ATTR_NAME, easingStyle.Name)
end
return DoorUtils

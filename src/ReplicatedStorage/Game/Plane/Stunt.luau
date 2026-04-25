-- Reviewed by Claude
-- variables reassigned

local LocalPlayer = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.ActionButton.ActionButtonService)
require(ReplicatedStorage.Game.Item.Gun)

local BaseUserControlledPlane = require(ReplicatedStorage.Game.Plane.BaseUserControlledPlane)
local Audio = require(ReplicatedStorage.Std.Audio)

require(ReplicatedStorage.Std.Maid)

local TAU = math.pi * 2

local StuntClass = {
	__ClassName = "Stunt"
}

StuntClass.__index = StuntClass

function StuntClass.new(metadata)
	local self = setmetatable({}, StuntClass)

	self.Meta = metadata
	self.Model = metadata.Model

	self.Plane = BaseUserControlledPlane.new(metadata, {
		SUSPENSION_HEIGHT_FRONT = 4,
		SUSPENSION_HEIGHT_BACK = 4,
		COEFFICIENT_DRAG = 0.8,
		MAX_THRUST = 790,
		THROTTLE_WHEEL_TURN_MIN = 0.5,
		THROTTLE_TAKEOFF = 0.5,
		CAMERA_OFFSET_CF = CFrame.new(0, 10, 30),
		HEIGHT_MAX = 1100,
		WHEEL_VISUAL_RADIUS_FRONT = 1.3095,
		WHEEL_VISUAL_RADIUS_BACK = 0.7075
	})

	self.Maid = self.Plane.Maid
	self.Seats = self.Plane.Seats

	self.BoundingBox = self.Model.BoundingBox

	self.MotorAileronWingRight = metadata.MotorAileronWingRight
	self.MotorAileronWingLeft = metadata.MotorAileronWingLeft
	self.MotorAileronTailRight = metadata.MotorAileronTailRight
	self.MotorAileronTailLeft = metadata.MotorAileronTailLeft
	self.MotorAileronTail = metadata.MotorAileronTail
	self.MotorPropeller = metadata.MotorPropeller

	self.Plane.WheelsConf = metadata.WheelsConf

	return self
end

-- shared aileron + prop logic
local function UpdateAileronsAndProp(plane, deltaTime, state)
	local Joystickx = plane.Plane.Joystickx
	local Joysticky = plane.Plane.Joysticky

	local magnitude = (Joystickx * Joystickx + Joysticky * Joysticky) ^ 0.5
	local x = magnitude > 1 and Joystickx / magnitude or Joystickx
	local y = magnitude > 1 and Joysticky / magnitude or Joysticky

	local yaw = plane.Plane.InputYaw

	plane.MotorAileronWingRight.C0 = CFrame.new(0, 0, -1) * CFrame.Angles(0.3 * (-y - x), 0, 0)
	plane.MotorAileronWingLeft.C0 = CFrame.new(0, 0, -1) * CFrame.Angles(0.3 * (-y + x), 0, 0)

	plane.MotorAileronTailRight.C0 = CFrame.new(0, 0, -1) * CFrame.Angles(0.2 * (-y - x), 0, 0)
	plane.MotorAileronTailLeft.C0 = CFrame.new(0, 0, -1) * CFrame.Angles(0.2 * (-y + x), 0, 0)

	plane.MotorAileronTail.C0 =
		CFrame.new(0, 0, 1)
		* CFrame.Angles(-0.5235987755982988, 0, 0)
		* CFrame.Angles(0, 0.1 * x - 0.07 * yaw, 0)
		* CFrame.Angles(0.5235987755982988, 0, 0)

	-- propeller rotation
	state.PropRotation += (10 + 10 * plane.Plane.Throttle) * deltaTime
	if state.PropRotation > TAU then
		state.PropRotation -= TAU
	end

	plane.MotorPropeller.C0 = CFrame.new(0, 0, -1) * CFrame.Angles(0, 0, state.PropRotation)

	-- transparency
	local targetTransparency =
		math.floor(((1 - math.clamp(plane.Plane.Throttle, 0, 1) ^ 2) * 0.4 + 0.6) * 20) / 20

	if targetTransparency ~= state.PropTransparency then
		state.PropTransparency = targetTransparency
		plane.Meta.PropellerDisc.Transparency = targetTransparency
	end
end

local function MountLocalPlayer(plane, player, seat)
	local state = {
		PropRotation = 0,
		PropTransparency = 0
	}

	seat.Maid:GiveTask(RunService.Heartbeat:Connect(function(dt)
		UpdateAileronsAndProp(plane, dt, state)

		local throttle = plane.Plane.Throttle
		plane.SoundPropeller.Volume = throttle * throttle
	end))

	seat.Maid:GiveTask(function()
		plane.Meta.PropellerDisc.Transparency = 1
	end)
end

local function MountThirdPlayer(plane, player, seat)
	local propRotation = 0

	seat.Maid:GiveTask(RunService.Heartbeat:Connect(function(dt)
		propRotation += 10 * dt
		if propRotation > TAU then
			propRotation -= TAU
		end

		plane.MotorPropeller.C0 = CFrame.new(0, 0, -1) * CFrame.Angles(0, 0, propRotation)

		local speed = plane.BoundingBox.Velocity.Magnitude
		plane.SoundPropeller.Volume = 1 - math.exp(-speed / 50)
	end))

	plane.Plane:SetParticlesEnabled(true)
end

function StuntClass.MountPlayer(plane, player, seat)
	plane.Plane:MountPlayer(player, seat)

	local sound = Audio.ObjectLocal(plane.Model.BoundingBox, 9058676938, {
		Looped = true,
		Volume = 0,
		Pitch = 1
	})

	sound.MaxDistance = 3000
	sound.EmitterSize = 20

	plane.SoundPropeller = sound

	if player == LocalPlayer then
		MountLocalPlayer(plane, player, seat)
	else
		MountThirdPlayer(plane, player, seat)
	end
end

function StuntClass.UnmountSeat(plane, seat)
	assert(seat)
	assert(seat.Occupied)

	plane.SoundPropeller:Destroy()
	plane.SoundPropeller = nil

	if seat.Player ~= LocalPlayer then
		plane.Plane:SetParticlesEnabled(false)
	end

	return plane.Plane:UnmountSeat(seat)
end

function StuntClass.Destroy(plane)
	plane.Plane:Destroy()
end

return StuntClass
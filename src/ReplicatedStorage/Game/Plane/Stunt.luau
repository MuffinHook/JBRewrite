-- Reviewed by Claude
local LocalPlayer = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.ActionButton.ActionButtonService)
require(ReplicatedStorage.Game.Item.Gun)
local BaseUserControlledPlane = require(ReplicatedStorage.Game.Plane.BaseUserControlledPlane)
local Audio = require(ReplicatedStorage.Std.Audio)
require(ReplicatedStorage.Std.Maid)
local t = {
	__ClassName = "Stunt"
}
t.__index = t
function t.new(p1)
	local v2 = setmetatable({}, t)
	v2.Meta = p1
	v2.Model = p1.Model
	v2.Plane = BaseUserControlledPlane.new(p1, {
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
	v2.Maid = v2.Plane.Maid
	v2.Seats = v2.Plane.Seats
	v2.BoundingBox = v2.Model.BoundingBox
	v2.MotorAileronWingRight = p1.MotorAileronWingRight
	v2.MotorAileronWingLeft = p1.MotorAileronWingLeft
	v2.MotorAileronTailRight = p1.MotorAileronTailRight
	v2.MotorAileronTailLeft = p1.MotorAileronTailLeft
	v2.MotorAileronTail = p1.MotorAileronTail
	v2.MotorPropeller = p1.MotorPropeller
	v2.Plane.WheelsConf = p1.WheelsConf
	return v2
end
local function MountLocalPlayer(p1, p2, p3)
	local PlaneGui = p1.Plane.PlaneGui
	local MotorAileronWingRight = p1.MotorAileronWingRight
	local MotorAileronWingLeft = p1.MotorAileronWingLeft
	local MotorAileronTailRight = p1.MotorAileronTailRight
	local MotorAileronTailLeft = p1.MotorAileronTailLeft
	local MotorAileronTail = p1.MotorAileronTail
	local MotorPropeller = p1.MotorPropeller
	local v1 = 0
	local v2 = 0
	local function HeartbeatAilerons(p12)
		local Joystickx = p1.Plane.Joystickx
		local Joysticky = p1.Plane.Joysticky
		local v12 = (Joystickx * Joystickx + Joysticky * Joysticky) ^ 0.5
		local v22 = v12 > 1 and Joystickx / v12 or Joystickx
		local v3 = v12 > 1 and Joysticky / v12 or Joysticky
		MotorAileronWingRight.C0 = CFrame.new(0, 0, -1) * CFrame.Angles(0.3 * (-v3 - v22), 0, 0)
		MotorAileronWingLeft.C0 = CFrame.new(0, 0, -1) * CFrame.Angles(0.3 * (-v3 + v22), 0, 0)
		MotorAileronTailRight.C0 = CFrame.new(0, 0, -1) * CFrame.Angles(0.2 * (-v3 - v22), 0, 0)
		MotorAileronTailLeft.C0 = CFrame.new(0, 0, -1) * CFrame.Angles(0.2 * (-v3 + v22), 0, 0)
		MotorAileronTail.C0 = CFrame.new(0, 0, 1) * CFrame.Angles(-0.5235987755982988, 0, 0) * CFrame.Angles(0, 0.1 * v22 - 0.07 * p1.Plane.InputYaw, 0) * CFrame.Angles(0.5235987755982988, 0, 0)
		v1 = v1 + (10 + 10 * p1.Plane.Throttle) * p12
		if v1 > 6.283185307179586 then
			v1 = v1 - 6.283185307179586
		end
		MotorPropeller.C0 = CFrame.new(0, 0, -1) * CFrame.Angles(0, 0, v1)
		local v5 = math.floor(((1 - math.clamp(p1.Plane.Throttle, 0, 1) ^ 2) * 0.4 + 0.6) * 20) / 20
		if v5 ~= v2 then
			v2 = v5
			p1.Meta.PropellerDisc.Transparency = v5
		end
	end
	local function HeartbeatSounds(p12)
		local Throttle = p1.Plane.Throttle
		p1.SoundPropeller.Volume = Throttle * Throttle
	end
	local function Heartbeat(p12)
		HeartbeatAilerons(p12)
		local Throttle = p1.Plane.Throttle
		p1.SoundPropeller.Volume = Throttle * Throttle
	end
	p3.Maid:GiveTask(RunService.Heartbeat:Connect(Heartbeat))
	p3.Maid:GiveTask(function()
		p1.Meta.PropellerDisc.Transparency = 1
	end)
end
local function MountThirdPlayer(p1, p2, p3)
	local MotorPropeller = p1.MotorPropeller
	local v1 = 0
	local function Heartbeat(p12)
		v1 = v1 + 10 * p12
		if v1 > 6.283185307179586 then
			v1 = v1 - 6.283185307179586
		end
		MotorPropeller.C0 = CFrame.new(0, 0, -1) * CFrame.Angles(0, 0, v1)
		p1.SoundPropeller.Volume = 1 - math.exp(-p1.BoundingBox.Velocity.Magnitude / 50)
	end
	p3.Maid:GiveTask(RunService.Heartbeat:Connect(Heartbeat))
	p1.Plane:SetParticlesEnabled(true)
end
function t.MountPlayer(p1, p2, p3)
	p1.Plane:MountPlayer(p2, p3)
	local v1 = Audio.ObjectLocal(p1.Model.BoundingBox, 9058676938, {
		Looped = true,
		Volume = 0,
		Pitch = 1
	})
	v1.MaxDistance = 3000
	v1.EmitterSize = 20
	p1.SoundPropeller = v1
	if p2 == LocalPlayer then
		MountLocalPlayer(p1, p2, p3)
	else
		MountThirdPlayer(p1, p2, p3)
	end
end
local function UnmountLocalPlayer(p1, p2) end
local function UnmountThirdPlayer(p1, p2, p3)
	p1.Plane:SetParticlesEnabled(false)
end
function t.UnmountSeat(p1, p2)
	assert(p2)
	assert(p2.Occupied)
	p1.SoundPropeller:Destroy()
	p1.SoundPropeller = nil
	if p2.Player ~= LocalPlayer then
		local Player = p2.Player
		p1.Plane:SetParticlesEnabled(false)
	end
	return p1.Plane:UnmountSeat(p2)
end
function t.Destroy(p1)
	p1.Plane:Destroy()
end
return t

-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local Joint = require(ReplicatedStorage.Std.Joint)
local Spring = require(ReplicatedStorage.Std.Spring)
local RayCast = require(ReplicatedStorage.Module.RayCast)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local Gun = require(script.Parent.Gun)
local v2 = CFrame.new()
local function FromAxisAngle(p1)
	local X = p1.X
	local Y = p1.Y
	local Z = p1.Z
	local v1 = (X * X + Y * Y + Z * Z) ^ 0.5
	if v1 > 0.00001 then
		local v22 = math.sin(v1 * 0.5) / v1
		return CFrame.new(0, 0, 0, v22 * X, v22 * Y, v22 * Z, (math.cos(v1 * 0.5)))
	else
		return v2
	end
end
local t = {
	__ClassName = "Flintlock"
}
t.__index = t
setmetatable(t, Gun)
function t.new(p1, p2, p3)
	local v1 = Gun.new(p1, p2, p3)
	setmetatable(v1, t)
	v1:Setup(p3)
	return v1
end
function t.SetupModel(p1)
	Gun.SetupModel(p1)
	local Lever = p1.Model.Motion.Lever
	local v1 = Joint.Motor(Lever, p1.BoundingBox)
	Lever.Anchored = false
	local v2 = Spring.new(Vector3.new(0, 0, 0), Vector3.new(), 0.8, 20)
	local v3 = Spring.new(0, 0, 0.9, 20)
	p1.MotorLever = v1
	p1.SpringLever = v2
	p1.SpringKnockback = v3
end
function t.UpdateItemSprings(p1)
	Gun.UpdateItemSprings(p1)
	p1.LeverPosition = p1.SpringLever:Update()
	p1.KnockbackPosition = p1.SpringKnockback:Update()
end
local lastUpdateTime = os.clock()
function t.UpdateItemJoints(p1)
	Gun.UpdateItemJoints(p1)
	p1.MotorLever.C1 = FromAxisAngle(p1.LeverPosition)
	if p1.KnockbackPosition > 0.1 and not (VehicleUtils.GetLocalVehiclePacket() or p1.Humanoid.Sit) then
		p1.RootPart.CFrame = p1.RootPart.CFrame * CFrame.new(0, 0, p1.KnockbackPosition * 60 * (os.clock() - lastUpdateTime))
	end
	lastUpdateTime = os.clock()
end
function t.SetupArmWelds(p1)
	Joint.Weld(p1.Model.Skeleton.RightArm, p1.BoundingBox)
	p1.Model.Skeleton.RightArm.Anchored = false
end
function t.UpdateArmIK(p1)
	local IK = p1.IK
	IK.RightArm = p1.Model.Skeleton.RightArm.Position
	IK.RightAngle = p1.Config.Motion.RightElbowAngle
end
function t.ShootSound(p1, p2)
	if not p2 then
		Audio.ObjectLocal(p1.Tip, p1.Config.Sound.flintlock_shoot, {
			Pitch = 0.7,
			Volume = 0.7
		})
		p1.SpringLever:Accelerate(Vector3.new(30, 0, 0))
		if RayCast.RayIgnoreNonCollide(p1.RootPart.Position, -p1.RootPart.CFrame.LookVector, 5, p1.Character) == nil then
			p1.SpringKnockback:Accelerate(50)
		end
	end
end
function t.ReloadDropAmmoSound(p1)
	Audio.ObjectLocal(p1.Tip, p1.Config.Sound.flintlock_reload_open, {
		RollOffMaxDistance = 129
	})
end
function t.ReloadRefillAmmoSound(p1)
	Audio.ObjectLocal(p1.Tip, p1.Config.Sound.flintlock_reload_close, {
		RollOffMaxDistance = 129
	})
end
return t

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local Joint = require(ReplicatedStorage.Std.Joint)
local Spring = require(ReplicatedStorage.Std.Spring)
local RayCast = require(ReplicatedStorage.Module.RayCast)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local Gun = require(script.Parent.Gun)
local identityCFrame = CFrame.new()
local function FromAxisAngle(axisAngle)
	local X = axisAngle.X
	local Y = axisAngle.Y
	local Z = axisAngle.Z
	local magnitude = (X * X + Y * Y + Z * Z) ^ 0.5
	if magnitude > 0.00001 then
		local sinHalf = math.sin(magnitude * 0.5) / magnitude
		return CFrame.new(0, 0, 0, sinHalf * X, sinHalf * Y, sinHalf * Z, (math.cos(magnitude * 0.5)))
	else
		return identityCFrame
	end
end
local t = {
	__ClassName = "Flintlock"
}
t.__index = t
setmetatable(t, Gun)
function t.new(model, config, gunConfig)
	local self = Gun.new(model, config, gunConfig)
	setmetatable(self, t)
	self:Setup(gunConfig)
	return self
end
function t.SetupModel(self)
	Gun.SetupModel(self)
	local Lever = self.Model.Motion.Lever
	local motorLever = Joint.Motor(Lever, self.BoundingBox)
	Lever.Anchored = false
	local leverSpring = Spring.new(Vector3.new(0, 0, 0), Vector3.new(), 0.8, 20)
	local knockbackSpring = Spring.new(0, 0, 0.9, 20)
	self.MotorLever = motorLever
	self.SpringLever = leverSpring
	self.SpringKnockback = knockbackSpring
end
function t.UpdateItemSprings(self)
	Gun.UpdateItemSprings(self)
	self.LeverPosition = self.SpringLever:Update()
	self.KnockbackPosition = self.SpringKnockback:Update()
end
local lastUpdateTime = os.clock()
function t.UpdateItemJoints(self)
	Gun.UpdateItemJoints(self)
	self.MotorLever.C1 = FromAxisAngle(self.LeverPosition)
	if self.KnockbackPosition > 0.1 and not (VehicleUtils.GetLocalVehiclePacket() or self.Humanoid.Sit) then
		self.RootPart.CFrame = self.RootPart.CFrame * CFrame.new(0, 0, self.KnockbackPosition * 60 * (os.clock() - lastUpdateTime))
	end
	lastUpdateTime = os.clock()
end
function t.SetupArmWelds(self)
	Joint.Weld(self.Model.Skeleton.RightArm, self.BoundingBox)
	self.Model.Skeleton.RightArm.Anchored = false
end
function t.UpdateArmIK(self)
	local IK = self.IK
	IK.RightArm = self.Model.Skeleton.RightArm.Position
	IK.RightAngle = self.Config.Motion.RightElbowAngle
end
function t.ShootSound(self, isRemote)
	if not isRemote then
		Audio.ObjectLocal(self.Tip, self.Config.Sound.flintlock_shoot, {
			Pitch = 0.7,
			Volume = 0.7
		})
		self.SpringLever:Accelerate(Vector3.new(30, 0, 0))
		if RayCast.RayIgnoreNonCollide(self.RootPart.Position, -self.RootPart.CFrame.LookVector, 5, self.Character) == nil then
			self.SpringKnockback:Accelerate(50)
		end
	end
end
function t.ReloadDropAmmoSound(self)
	Audio.ObjectLocal(self.Tip, self.Config.Sound.flintlock_reload_open, {
		RollOffMaxDistance = 129
	})
end
function t.ReloadRefillAmmoSound(self)
	Audio.ObjectLocal(self.Tip, self.Config.Sound.flintlock_reload_close, {
		RollOffMaxDistance = 129
	})
end
return t

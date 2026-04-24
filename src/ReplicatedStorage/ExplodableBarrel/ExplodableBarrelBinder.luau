-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local C4Utils = require(ReplicatedStorage.Game.C4.C4Utils)
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Binder = require(ReplicatedStorage.Std.Binder)
local GeomUtils = require(ReplicatedStorage.Std.GeomUtils)
local Joint = require(ReplicatedStorage.Std.Joint)
local PartUtils = require(ReplicatedStorage.Std.PartUtils)
local ExplodableBarrel = {}
ExplodableBarrel.__index = ExplodableBarrel
setmetatable(ExplodableBarrel, BaseObject)
function ExplodableBarrel.new(barrel)
	local instance = BaseObject.new(barrel)
	setmetatable(instance, ExplodableBarrel)
	instance.exploded = false
	local Visual = barrel:FindFirstChild("Visual")
	instance.visualModel = assert(Visual, "no visual model found")
	local ExplodeRemote = barrel:FindFirstChild("ExplodeRemote")
	instance.maid:GiveTask(ExplodeRemote.OnClientEvent:Connect(function()
		instance:Explode()
	end))
	return instance
end
function ExplodableBarrel.Explode(self)
	if self.exploded then
		warn("barrel already exploded")
	else
		self.exploded = true
		local clonedModel = self.visualModel:Clone()
		task.delay(5, function()
			clonedModel:Destroy()
		end)
		PartUtils.setCanTouch(clonedModel, false)
		self.visualModel:Destroy()
		clonedModel.Parent = workspace
		local PrimaryPart = clonedModel.PrimaryPart
		Joint.WeldAllTo(clonedModel, PrimaryPart)
		C4Utils.explosionVisual(PrimaryPart.Position)
		local Attachment = Instance.new("Attachment")
		Attachment.Parent = PrimaryPart
		local VectorForce = Instance.new("VectorForce")
		VectorForce.Attachment0 = Attachment
		VectorForce.RelativeTo = Enum.ActuatorRelativeTo.World
		VectorForce.Force = Vector3.new(0, workspace.Gravity * PrimaryPart.AssemblyMass * 0.5, 0)
		VectorForce.Parent = PrimaryPart
		PrimaryPart.AssemblyLinearVelocity = PrimaryPart.AssemblyLinearVelocity + Vector3.new(0, math.sqrt(2 * workspace.Gravity * 0.5 * 20), 0)
		PrimaryPart.AssemblyAngularVelocity = PrimaryPart.AssemblyAngularVelocity + GeomUtils.randomPointInSphere() * 10
	end
end
return Binder.new("ExplodableBarrel", ExplodableBarrel)

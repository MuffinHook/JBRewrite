local ReplicatedStorage = game:GetService("ReplicatedStorage")
local C4Utils = require(ReplicatedStorage.Game.C4.C4Utils)
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Binder = require(ReplicatedStorage.Std.Binder)
local GeomUtils = require(ReplicatedStorage.Std.GeomUtils)
local Joint = require(ReplicatedStorage.Std.Joint)
local PartUtils = require(ReplicatedStorage.Std.PartUtils)
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(p1) --[[ Line: 13 | Upvalues: BaseObject (copy), t (copy) ]]
	local v1 = BaseObject.new(p1)
	setmetatable(v1, t)
	v1.exploded = false
	local Visual = p1:FindFirstChild("Visual")
	v1.visualModel = assert(Visual, "no visual model found")
	local ExplodeRemote = p1:FindFirstChild("ExplodeRemote")
	v1.maid:GiveTask(ExplodeRemote.OnClientEvent:Connect(function() --[[ Line: 21 | Upvalues: v1 (copy) ]]
		v1:Explode()
	end))
	return v1
end
function t.Explode(p1) --[[ Line: 27 | Upvalues: PartUtils (copy), Joint (copy), C4Utils (copy), GeomUtils (copy) ]]
	if p1.exploded then
		warn("barrel already exploded")
	else
		p1.exploded = true
		local v1 = p1.visualModel:Clone()
		task.delay(5, function() --[[ Line: 35 | Upvalues: v1 (copy) ]]
			v1:Destroy()
		end)
		PartUtils.setCanTouch(v1, false)
		p1.visualModel:Destroy()
		v1.Parent = workspace
		local PrimaryPart = v1.PrimaryPart
		Joint.WeldAllTo(v1, PrimaryPart)
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
return Binder.new("ExplodableBarrel", t)
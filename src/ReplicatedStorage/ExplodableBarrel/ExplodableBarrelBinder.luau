local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
function module_upvr.new(arg1) -- Line 13
    local any_new_result1_upvr = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1_upvr, module_upvr)
    any_new_result1_upvr.exploded = false
    any_new_result1_upvr.visualModel = assert(arg1:FindFirstChild("Visual"), "no visual model found")
    any_new_result1_upvr.maid:GiveTask(arg1:FindFirstChild("ExplodeRemote").OnClientEvent:Connect(function() -- Line 21
        any_new_result1_upvr:Explode()
    end))
    return any_new_result1_upvr
end
local PartUtils_upvr = require(ReplicatedStorage.Std.PartUtils)
local Joint_upvr = require(ReplicatedStorage.Std.Joint)
local C4Utils_upvr = require(ReplicatedStorage.Game.C4.C4Utils)
local GeomUtils_upvr = require(ReplicatedStorage.Std.GeomUtils)
function module_upvr.Explode(arg1) -- Line 27
    if arg1.exploded then
        warn("barrel already exploded")
    else
        arg1.exploded = true
        local clone_upvr = arg1.visualModel:Clone()
        task.delay(5, function() -- Line 35
            clone_upvr:Destroy()
        end)
        PartUtils_upvr.setCanTouch(clone_upvr, false)
        arg1.visualModel:Destroy()
        clone_upvr.Parent = workspace
        local PrimaryPart = clone_upvr.PrimaryPart
        Joint_upvr.WeldAllTo(clone_upvr, PrimaryPart)
        C4Utils_upvr.explosionVisual(PrimaryPart.Position)
        local Attachment = Instance.new("Attachment")
        Attachment.Parent = PrimaryPart
        local VectorForce = Instance.new("VectorForce")
        VectorForce.Attachment0 = Attachment
        VectorForce.RelativeTo = Enum.ActuatorRelativeTo.World
        VectorForce.Force = Vector3.new(0, workspace.Gravity * PrimaryPart.AssemblyMass * 0.5, 0)
        VectorForce.Parent = PrimaryPart
        PrimaryPart.AssemblyLinearVelocity += Vector3.new(0, math.sqrt(2 * workspace.Gravity * 0.5 * 20), 0)
        PrimaryPart.AssemblyAngularVelocity += GeomUtils_upvr.randomPointInSphere() * 10
    end
end
return require(ReplicatedStorage.Std.Binder).new("ExplodableBarrel", module_upvr)
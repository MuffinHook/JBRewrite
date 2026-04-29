local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Interval = require(ReplicatedStorage.Std.Interval)
local CollectionService = game:GetService("CollectionService")
local C4Utils = require(ReplicatedStorage.Game.C4.C4Utils)
return {
	init = function()
		local DestructibleBinder = require(script.Parent.DestructibleBinder)
		DestructibleBinder:GetClassAddedSignal():Connect(function(destructible)
			local prefab = destructible:GetPrefab()
			if CollectionService:HasTag(prefab, "Tree") then
				destructible._maid:GiveTask(destructible:GetOnHitSignal():Connect(function()
					local MeshPart = destructible:GetInst().MeshPart
					MeshPart.CanCollide = false
					local particleEffect = ReplicatedStorage.Resource.Destructible.LeavesParticle:Clone()
					local Attachment = Instance.new("Attachment")
					Attachment.Parent = MeshPart
					particleEffect.Color = ColorSequence.new(MeshPart.Color)
					particleEffect.Parent = Attachment
					particleEffect:Emit(3)
					particleEffect.Enabled = true
					task.delay(1.5, function()
						particleEffect.Enabled = false
					end)
				end))
			elseif CollectionService:HasTag(prefab, "Powerline") then
				destructible._maid:GiveTask(destructible:GetOnHitSignal():Connect(function()
					local inst = destructible:GetInst()
					for i, child in ipairs(inst:GetChildren()) do
						if child:IsA("BasePart") and child.Name == "Town_Wire" then
							child.CanCollide = false
						end
					end
					local MeshPart = inst.MeshPart
					MeshPart.Attachment.EmitFifteen:Emit(15)
					MeshPart.Attachment.EmitOne:Emit(1)
				end))
			elseif CollectionService:HasTag(prefab, "GasPump") then
				destructible._maid:GiveTask(destructible:GetOnHitSignal():Connect(function()
					C4Utils.explosionVisual(destructible:GetInst().Base.Position)
				end))
			end
		end)
		DestructibleBinder:Start()
		local function handleInsts()
			for inst in DestructibleBinder:GetAllSet() do
				inst:Update()
			end
		end
		Interval.every(2):Connect(handleInsts)
	end
}

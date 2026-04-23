local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Interval = require(ReplicatedStorage.Std.Interval)
local CollectionService = game:GetService("CollectionService")
local C4Utils = require(ReplicatedStorage.Game.C4.C4Utils)
return {
	init = function() --[[ Name: init | Line: 7 | Upvalues: CollectionService (copy), ReplicatedStorage (copy), C4Utils (copy), Interval (copy) ]]
		local DestructibleBinder = require(script.Parent.DestructibleBinder)
		DestructibleBinder:GetClassAddedSignal():Connect(function(p1) --[[ Line: 9 | Upvalues: CollectionService (ref), ReplicatedStorage (ref), C4Utils (ref) ]]
			local v1 = p1:GetPrefab()
			if CollectionService:HasTag(v1, "Tree") then
				p1._maid:GiveTask(p1:GetOnHitSignal():Connect(function() --[[ Line: 12 | Upvalues: p1 (copy), ReplicatedStorage (ref) ]]
					local MeshPart = p1:GetInst().MeshPart
					MeshPart.CanCollide = false
					local v1 = ReplicatedStorage.Resource.Destructible.LeavesParticle:Clone()
					local Attachment = Instance.new("Attachment")
					Attachment.Parent = MeshPart
					v1.Color = ColorSequence.new(MeshPart.Color)
					v1.Parent = Attachment
					v1:Emit(3)
					v1.Enabled = true
					delay(1.5, function() --[[ Line: 25 | Upvalues: v1 (copy) ]]
						v1.Enabled = false
					end)
				end))
			elseif CollectionService:HasTag(v1, "Powerline") then
				p1._maid:GiveTask(p1:GetOnHitSignal():Connect(function() --[[ Line: 30 | Upvalues: p1 (copy) ]]
					local v1 = p1:GetInst()
					for i, v in ipairs(v1:GetChildren()) do
						if v:IsA("BasePart") and v.Name == "Town_Wire" then
							v.CanCollide = false
						end
					end
					local MeshPart = v1.MeshPart
					MeshPart.Attachment.EmitFifteen:Emit(15)
					MeshPart.Attachment.EmitOne:Emit(1)
				end))
			elseif CollectionService:HasTag(v1, "GasPump") then
				p1._maid:GiveTask(p1:GetOnHitSignal():Connect(function() --[[ Line: 45 | Upvalues: p1 (copy), C4Utils (ref) ]]
					C4Utils.explosionVisual(p1:GetInst().Base.Position)
				end))
			end
		end)
		DestructibleBinder:Start()
		local function handleInsts() --[[ Line: 53 | Upvalues: DestructibleBinder (copy) ]]
			for v1 in DestructibleBinder:GetAllSet() do
				v1:Update()
			end
		end
		Interval.every(2):Connect(handleInsts)
	end
}
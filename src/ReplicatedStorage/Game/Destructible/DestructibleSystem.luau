local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module = {}
local CollectionService_upvr = game:GetService("CollectionService")
local C4Utils_upvr = require(ReplicatedStorage_upvr.Game.C4.C4Utils)
local Interval_upvr = require(ReplicatedStorage_upvr.Std.Interval)
function module.init() -- Line 7
    local DestructibleBinder_upvr = require(script.Parent.DestructibleBinder)
    DestructibleBinder_upvr:GetClassAddedSignal():Connect(function(arg1) -- Line 9
        local any_GetPrefab_result1 = arg1:GetPrefab()
        if CollectionService_upvr:HasTag(any_GetPrefab_result1, "Tree") then
            arg1._maid:GiveTask(arg1:GetOnHitSignal():Connect(function() -- Line 12
                local MeshPart = arg1:GetInst().MeshPart
                MeshPart.CanCollide = false
                local clone_upvr = ReplicatedStorage_upvr.Resource.Destructible.LeavesParticle:Clone()
                local Attachment = Instance.new("Attachment")
                Attachment.Parent = MeshPart
                clone_upvr.Color = ColorSequence.new(MeshPart.Color)
                clone_upvr.Parent = Attachment
                clone_upvr:Emit(3)
                clone_upvr.Enabled = true
                delay(1.5, function() -- Line 25
                    clone_upvr.Enabled = false
                end)
            end))
        else
            if CollectionService_upvr:HasTag(any_GetPrefab_result1, "Powerline") then
                arg1._maid:GiveTask(arg1:GetOnHitSignal():Connect(function() -- Line 30
                    local any_GetInst_result1 = arg1:GetInst()
                    for _, v in ipairs(any_GetInst_result1:GetChildren()) do
                        if v:IsA("BasePart") and v.Name == "Town_Wire" then
                            v.CanCollide = false
                        end
                    end
                    local MeshPart_2 = any_GetInst_result1.MeshPart
                    MeshPart_2.Attachment.EmitFifteen:Emit(15)
                    MeshPart_2.Attachment.EmitOne:Emit(1)
                end))
                return
            end
            if CollectionService_upvr:HasTag(any_GetPrefab_result1, "GasPump") then
                arg1._maid:GiveTask(arg1:GetOnHitSignal():Connect(function() -- Line 45
                    C4Utils_upvr.explosionVisual(arg1:GetInst().Base.Position)
                end))
            end
        end
    end)
    DestructibleBinder_upvr:Start()
    Interval_upvr.every(2):Connect(function() -- Line 53, Named "handleInsts"
        for i in DestructibleBinder_upvr:GetAllSet(), nil do
            i:Update()
        end
    end)
end
return module
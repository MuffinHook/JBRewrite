local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Maid_upvr = require(ReplicatedStorage_upvr.Std.Maid)
local DestructibleConsts_upvr = require(script.Parent.DestructibleConsts)
local Folder_upvr = Instance.new("Folder")
Folder_upvr.Parent = workspace
local module_2_upvr = {}
module_2_upvr.__index = module_2_upvr
function module_2_upvr.new(arg1) -- Line 21
    local module = {}
    setmetatable(module, module_2_upvr)
    module._obj = arg1
    module._objName = arg1.Name
    module._maid = Maid_upvr.new()
    module:_setup(arg1, module._maid)
    return module
end
local Signal_upvr = require(ReplicatedStorage_upvr.Std.Signal)
function module_2_upvr.GetOnHitSignal(arg1) -- Line 32
    if not arg1._onHitSignal then
        arg1._onHitSignal = Signal_upvr.new()
        arg1._maid:GiveTask(arg1._onHitSignal)
    end
    return arg1._onHitSignal
end
function module_2_upvr.GetInst(arg1) -- Line 39
    return arg1._instValue.Value
end
function module_2_upvr.GetPrefab(arg1) -- Line 42
    return ReplicatedStorage_upvr:FindFirstChild(DestructibleConsts_upvr.PREFAB_FOLDER_NAME):FindFirstChild(arg1._objName)
end
local RxInstanceUtils_upvr = require(ReplicatedStorage_upvr.Std.RxInstanceUtils)
function module_2_upvr._setup(arg1, arg2, arg3) -- Line 46
    if not arg2:FindFirstChild(DestructibleConsts_upvr.INSTANCE_VALUE_NAME) then
        local ObjectValue = Instance.new("ObjectValue")
        ObjectValue.Name = DestructibleConsts_upvr.INSTANCE_VALUE_NAME
        ObjectValue.Value = nil
        ObjectValue.Parent = arg2
    end
    arg1._instValue = ObjectValue
    arg1._wasTouched = false
    arg3:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(arg2, DestructibleConsts_upvr.BROADCAST_COLLIDE_REMOTE_NAME, function(arg1_2, arg2_2) -- Line 61
        arg1._broadcastCollideRemote = arg1_2
        arg2_2:GiveTask(arg1_2.OnClientEvent:Connect(function(arg1_3) -- Line 63
            if arg1._wasTouched then
            else
                arg1:_handleHitPosition(arg1_3)
            end
        end))
    end))
    arg3:GiveTask(ObjectValue.Changed:Connect(function() -- Line 73
        arg1:_handleInst()
    end))
    arg1:_handleInst()
end
local Debris_upvr = game:GetService("Debris")
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
function module_2_upvr._handleHitPosition(arg1, arg2) -- Line 78
    arg1._wasTouched = true
    local Value = arg1._instValue.Value
    if not Value then
    else
        if arg1._onHitSignal then
            arg1._onHitSignal:Fire()
        end
        local PrimaryPart = Value.PrimaryPart
        PrimaryPart.Anchored = false
        local var17 = (arg2 + PrimaryPart.Position) * 0.5
        local Unit = (PrimaryPart.Position - arg2).Unit
        PrimaryPart:ApplyImpulseAtPosition(Unit * PrimaryPart.AssemblyMass * 30, var17)
        local Part = Instance.new("Part")
        Part.Name = "CrashParticles"
        Part.Transparency = 1
        Part.Anchored = true
        Part.CanCollide = false
        Part.CFrame = CFrame.lookAt(var17, var17 + Unit)
        Part.Size = Vector3.new(4, 1, 1)
        Part.Parent = workspace
        local clone = ReplicatedStorage_upvr.Resource.CrashParticle:Clone()
        clone.Parent = Part
        clone:Emit(10)
        Debris_upvr:AddItem(Part, 5)
        Audio_upvr.ObjectLocal(PrimaryPart, 7018764077, {
            Volume = 0.15;
            RollOffMaxDistance = 128;
            PlaybackSpeed = math.random() * 0.1 + 0.95;
        })
        task.wait()
        Value:BreakJoints()
        task.wait(DestructibleConsts_upvr.DURATION)
        Value:Destroy()
    end
end
local any_new_result1_upvr = require(ReplicatedStorage_upvr.Std.RateLimiter).new(50)
local CurrentCamera_upvr = workspace.CurrentCamera
function module_2_upvr._handleInst(arg1) -- Line 122
    debug.profilebegin("DestructibleSpawn.handleInst")
    local _instValue_upvr = arg1._instValue
    local _obj = arg1._obj
    local Value_2 = _instValue_upvr.Value
    if not any_new_result1_upvr:CanUseBudget(1) then
    else
        local Magnitude = (CurrentCamera_upvr.CFrame.p - _obj.Value.p).Magnitude
        if not Value_2 and Magnitude < DestructibleConsts_upvr.MAX_DIST_TO_LOAD then
            any_new_result1_upvr:UseBudget(1)
            local any_new_result1 = Maid_upvr.new()
            arg1._maid._instMaid = any_new_result1
            any_new_result1:GiveTask(function() -- Line 138
                arg1._wasTouched = false
            end)
            local clone_2 = ReplicatedStorage_upvr:FindFirstChild(DestructibleConsts_upvr.PREFAB_FOLDER_NAME):FindFirstChild(_obj.Name):Clone()
            clone_2:SetPrimaryPartCFrame(_obj.Value)
            clone_2.Parent = Folder_upvr
            _instValue_upvr.Value = clone_2
            any_new_result1:GiveTask(clone_2.PrimaryPart.Touched:Connect(function(arg1_4) -- Line 151
                if arg1_4:IsDescendantOf(Folder_upvr) then
                else
                    if not arg1_4:IsDescendantOf(workspace:FindFirstChild("Vehicles")) then return end
                    if arg1._wasTouched then return end
                    arg1._wasTouched = true
                    local Position = arg1_4.Position
                    arg1._broadcastCollideRemote:FireServer(Position)
                    arg1:_handleHitPosition(Position)
                end
            end))
            any_new_result1:GiveTask(clone_2.AncestryChanged:Connect(function(arg1_5, arg2) -- Line 169
                if not arg2 then
                    _instValue_upvr.Value = nil
                end
            end))
        elseif Value_2 and DestructibleConsts_upvr.MAX_DIST_TO_LOAD < Magnitude then
            any_new_result1_upvr:UseBudget(1)
            Value_2:Destroy()
        end
        debug.profileend()
    end
end
module_2_upvr.Update = module_2_upvr._handleInst
function module_2_upvr.Destroy(arg1) -- Line 181
    arg1._maid = nil
    arg1._maid:Destroy()
    setmetatable(arg1, nil)
end
return module_2_upvr
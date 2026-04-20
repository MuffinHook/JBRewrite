local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_upvr = {}
module_upvr.__index = module_upvr
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local DoorUtils_upvr = require(ReplicatedStorage.Door2.DoorUtils)
local Promise_upvr = require(ReplicatedStorage.Std.Promise)
local RunService_upvr = game:GetService("RunService")
local Joint_upvr = require(ReplicatedStorage.Std.Joint)
local PlankConsts_upvr = require(script.Parent.PlankConsts)
function module_upvr.new(arg1) -- Line 14
    local module_upvr_2 = {}
    setmetatable(module_upvr_2, module_upvr)
    module_upvr_2._maid = Maid_upvr.new()
    module_upvr_2._obj = arg1
    module_upvr_2._maid:GiveTask(function() -- Line 20
        module_upvr_2._obj = nil
    end)
    local var12_upvw
    local var13_upvw
    local tbl_upvr = {}
    module_upvr_2._maid:GiveTask(DoorUtils_upvr.getDoorOpenChangedSignal(arg1):Connect(function() -- Line 27
        if DoorUtils_upvr.getOpen(arg1) then
            if var12_upvw then return end
            var13_upvw = {}
            var12_upvw = Promise_upvr.delay(DoorUtils_upvr.getDuration(arg1)):andThen(function() -- Line 35
                local Model = Instance.new("Model")
                for _, v in ipairs(arg1:GetDescendants()) do
                    if v:IsA("BasePart") then
                        local clone_upvr = v:Clone()
                        clone_upvr.Parent = Model
                        local var24_upvw
                        var24_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 43
                            if not clone_upvr:IsDescendantOf(workspace) then
                                var24_upvw:Disconnect()
                            elseif clone_upvr.Position.Y < -146.542 then
                                var24_upvw:Disconnect()
                                local BodyForce = Instance.new("BodyForce")
                                BodyForce.Force = Vector3.new(0, 1, 0) * clone_upvr:GetMass() * workspace.Gravity * 0.9
                                BodyForce.Parent = clone_upvr
                                clone_upvr.AssemblyLinearVelocity = Vector3.new(0, 4, 0)
                            end
                        end)
                        table.insert(var13_upvw, clone_upvr)
                        tbl_upvr[v] = v.Transparency
                        v.Transparency = 1
                    end
                end
                Model.Parent = workspace
                Joint_upvr.WeldAllTo(Model, Model:GetChildren()[1])
            end):andThenCall(Promise_upvr.delay, PlankConsts_upvr.REGEN_DURATION):finally(function() -- Line 69
                for _, v_2 in ipairs(arg1:GetDescendants()) do
                    if tbl_upvr[v_2] then
                        v_2.Transparency = tbl_upvr[v_2]
                    end
                end
                for _, v_3 in ipairs(var13_upvw) do
                    v_3:Destroy()
                end
                var13_upvw = nil
            end):finally(function() -- Line 80
                var12_upvw = nil
            end)
        end
    end))
    return module_upvr_2
end
function module_upvr.Destroy(arg1) -- Line 88
    arg1._maid = nil
    arg1._maid:Destroy()
end
return module_upvr
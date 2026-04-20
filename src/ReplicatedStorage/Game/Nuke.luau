local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module_upvr = {}
module_upvr.__index = module_upvr
local Maid_upvr = require(ReplicatedStorage_upvr.Std.Maid)
local Signal_upvr = require(ReplicatedStorage_upvr.Std.Signal)
function module_upvr.new() -- Line 9
    local module = {}
    setmetatable(module, module_upvr)
    local clone = ReplicatedStorage_upvr.Resource.Nuke:Clone()
    clone.PrimaryPart = clone.Base
    clone.Parent = workspace
    module.Model = clone
    module.Maid = Maid_upvr.new()
    module.OnImpact = Signal_upvr.new()
    module.Maid:GiveTask(module.OnImpact)
    return module
end
local SimulatedPhysicsProjectile_upvr = require(ReplicatedStorage_upvr.Module.SimulatedPhysicsProjectile)
function module_upvr.Launch(arg1, arg2) -- Line 27
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if arg2 == nil then
    else
    end
    assert(true)
    if arg2.Origin == nil then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    assert(true)
    if arg2.Target == nil then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_upvr.RenderStepped(arg1) -- Line 45
    local any_GetElapsed_result1 = arg1.ProjPhysics:GetElapsed()
    local any_CalculateElapsedPosition_result1 = arg1.ProjPhysics:CalculateElapsedPosition(any_GetElapsed_result1)
    arg1.ProjPhysics._PrevUpdatePosition = any_CalculateElapsedPosition_result1
    arg1.Model:SetPrimaryPartCFrame(CFrame.new(arg1.ProjPhysics._PrevUpdatePosition, any_CalculateElapsedPosition_result1))
    if arg1.ProjPhysics.Duration < any_GetElapsed_result1 then
        arg1.OnImpact:Fire()
        arg1:Destroy()
    end
end
local RunService_upvr = game:GetService("RunService")
function module_upvr.SetupRuntime(arg1) -- Line 59
    arg1.LastHeartbeat = tick()
    arg1.Maid:GiveTask(RunService_upvr.RenderStepped:Connect(function() -- Line 61
        arg1:RenderStepped()
    end))
end
function module_upvr.Destroy(arg1) -- Line 65
    arg1.Model:Destroy()
    arg1.Model = nil
    arg1.Maid:Destroy()
    arg1.Maid = nil
end
return module_upvr
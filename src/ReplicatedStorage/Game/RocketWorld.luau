local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
local tbl_upvr = {
    explosion_large_02 = 2205008239;
    nitro_loop = 9058734199;
    nitro_ignite = 1386598740;
}
local module_upvr = {}
module_upvr.__index = module_upvr
local Maid_upvr = require(ReplicatedStorage_upvr.Std.Maid)
local Signal_upvr = require(ReplicatedStorage_upvr.Std.Signal)
function module_upvr.new() -- Line 17
    local module = {}
    setmetatable(module, module_upvr)
    module.Maid = Maid_upvr.new()
    module.OnRocketQueueEmptied = Signal_upvr.new()
    module.OnRocketExploded = Signal_upvr.new()
    module:Setup()
    return module
end
function module_upvr.CreatePart(arg1, arg2, arg3) -- Line 28
    local clone = ReplicatedStorage_upvr.Resource.ItemSystem.Projectiles.Rocket:Clone()
    clone.CFrame = CFrame.new(Vector3.new(), arg3) + arg2
    clone.Parent = workspace
    arg1:AddSmoke(clone)
    Audio_upvr.ObjectLocal(clone, tbl_upvr.nitro_ignite, {
        Pitch = 0.7;
        TimePosition = 0.6;
        Volume = 0.3;
    })
    local any_ObjectLocal_result1 = Audio_upvr.ObjectLocal(clone, tbl_upvr.nitro_loop, {
        Pitch = 0.6;
        Volume = 1;
    })
    any_ObjectLocal_result1.Looped = true
    any_ObjectLocal_result1.EmitterSize = 25
    any_ObjectLocal_result1.Parent = clone
    return clone
end
function module_upvr.AddSmoke(arg1, arg2) -- Line 44
    ReplicatedStorage_upvr.Resource.ItemSystem.Projectiles.RocketFire:Clone().Parent = arg2
    ReplicatedStorage_upvr.Resource.ItemSystem.Projectiles.RocketSmoke:Clone().Parent = arg2
end
function module_upvr.Launch(arg1, arg2, arg3, arg4) -- Line 50
    assert(arg2)
    assert(arg3)
    assert(arg4)
    local tbl = {}
    tbl[1] = arg2
    tbl[2] = arg3
    tbl[3] = arg4
    tbl[4] = arg1:CreatePart(arg2, arg3)
    tbl[5] = 6
    table.insert(arg1.ListRocket, tbl)
end
local RunService_upvr = game:GetService("RunService")
function module_upvr.Setup(arg1) -- Line 66
    arg1.ListRocket = {}
    arg1.IgnoreList = {}
    local any_Connect_result1_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 70
        arg1:Update()
    end)
    arg1.Maid:GiveTask(function() -- Line 74
        if 0 < #arg1.ListRocket then
            arg1.OnRocketQueueEmptied:Connect(function() -- Line 77
                any_Connect_result1_upvw:Disconnect()
                any_Connect_result1_upvw = nil
                arg1.OnRocketQueueEmptied:Destroy()
                arg1.OnRocketQueueEmptied = nil
                arg1.OnRocketExploded:Destroy()
                arg1.OnRocketExploded = nil
            end)
        else
            any_Connect_result1_upvw:Disconnect()
            any_Connect_result1_upvw = nil
            arg1.OnRocketQueueEmptied:Destroy()
            arg1.OnRocketQueueEmptied = nil
            arg1.OnRocketExploded:Destroy()
            arg1.OnRocketExploded = nil
        end
    end)
end
local RayCast_upvr = require(ReplicatedStorage_upvr.Module.RayCast)
function module_upvr.Update(arg1) -- Line 95
    local tick_result1 = tick()
    local var47 = tick_result1 - (arg1.LastUpdate or tick_result1)
    arg1.LastUpdate = tick_result1
    local len = #arg1.ListRocket
    for i = len, 1, -1 do
        local var49 = arg1.ListRocket[i]
        local _2 = var49[2]
        local _3 = var49[3]
        local _4_2 = var49[4]
        local _5 = var49[5]
        if 0 < _5 then
            local var54
            if nil == nil then
                local any_RayIgnoreNonCollideWithIgnoreList_result1_2, any_RayIgnoreNonCollideWithIgnoreList_result2_2, _, _ = RayCast_upvr.RayIgnoreNonCollideWithIgnoreList(var49[1], _2, _3 * var47, arg1.IgnoreList)
                var54 = any_RayIgnoreNonCollideWithIgnoreList_result2_2
                if any_RayIgnoreNonCollideWithIgnoreList_result1_2 ~= nil then
                    _5 = 0
                end
            end
            _4_2.CFrame = CFrame.new(Vector3.new(), _2) + var54
            _4_2.Velocity = _2 * _3
            var49[1] = var54
            var49[2] = _2
            var49[3] = _3
            var49[5] = _5 - var47
        else
            _4_2.Transparency = 1
            game.Debris:AddItem(_4_2, 1)
            for _, v in next, _4_2:GetChildren() do
                if v:IsA("Sound") then
                    Audio_upvr.FadeOut(v, 0.3)
                elseif v:IsA("ParticleEmitter") then
                    v.Enabled = false
                end
            end
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            arg1:ExplodeAt(var49[1])
            var49[4] = nil
            table.remove(arg1.ListRocket, i)
        end
    end
    if 0 < len and #arg1.ListRocket == 0 then
        arg1.OnRocketQueueEmptied:Fire()
    end
end
local RocketLauncherUtils_upvr = require(ReplicatedStorage_upvr.RocketLauncher.RocketLauncherUtils)
function module_upvr.ExplodeAt(arg1, arg2) -- Line 147
    RocketLauncherUtils_upvr.explodeAt(arg2)
    arg1.OnRocketExploded:Fire(arg2)
end
function module_upvr.Destroy(arg1) -- Line 151
    arg1.Maid:Destroy()
    arg1.Maid = nil
end
return module_upvr
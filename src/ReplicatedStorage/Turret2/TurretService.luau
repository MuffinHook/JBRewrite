local module = {}
local Binder_upvr = require(game:GetService("ReplicatedStorage").Std.Binder)
local Turret_upvr = require(script.Parent.Turret)
local TurretConsts_upvr = require(script.Parent.TurretConsts)
local RunService_upvr = game:GetService("RunService")
function module.init() -- Line 7
    local any_new_result1 = Binder_upvr.new("Turret2", Turret_upvr)
    any_new_result1:GetClassAddedSignal():Connect(function(arg1) -- Line 9
        local SOME_2_upvr = arg1.Model:FindFirstChild(TurretConsts_upvr.TARGET_PTR_NAME)
        arg1.Maid:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 11
            if SOME_2_upvr.Value then
                local Value = SOME_2_upvr.Value
                assert(Value:IsA("BasePart"))
                arg1:PointAt(Value.Position)
            else
                arg1:PointAt()
            end
            arg1:Update()
        end))
        arg1.Maid:GiveTask(arg1.onLocalPlayerHit:Connect(function() -- Line 21
            local SOME = arg1.Model:FindFirstChild(TurretConsts_upvr.REPORT_HIT_REMOTE_NAME)
            assert(SOME)
            SOME:FireServer()
        end))
    end)
    any_new_result1:Start()
end
return module
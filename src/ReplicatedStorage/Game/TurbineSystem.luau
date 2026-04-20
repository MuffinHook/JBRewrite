local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {}
local Binder_upvr = require(ReplicatedStorage.Std.Binder)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
local RunService_upvr = game:GetService("RunService")
function module.init() -- Line 8
    local cframe_upvr = CFrame.new(0.292251587, -68.3681335, 4.94998169, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    Binder_upvr.new("Turbine", function(arg1) -- Line 11
        local any_new_result1 = Maid_upvr.new()
        any_new_result1:GiveTask(RxInstanceUtils_upvr.observeProperty(arg1, "PrimaryPart", function(arg1_2, arg2) -- Line 13
            if not arg1_2 then
            else
                arg2:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(arg1_2, "Blade->Base", function(arg1_3, arg2_2) -- Line 18
                    local os_clock_result1_upvr = os.clock()
                    local var14_upvr = math.random() * math.pi * 2
                    arg2_2:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 21
                        arg1_3.C1 = cframe_upvr:Inverse() * CFrame.Angles(0, 0, -0.3 * (os.clock() - os_clock_result1_upvr) + var14_upvr) * cframe_upvr
                    end))
                end))
            end
        end))
        return any_new_result1
    end):Start()
end
return module
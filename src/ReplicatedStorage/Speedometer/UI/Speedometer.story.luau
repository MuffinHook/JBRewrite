local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Roact_upvr = require(ReplicatedStorage.Roact)
local RunService_upvr = game:GetService("RunService")
return function(arg1) -- Line 6
    local any_new_result1_upvr = Maid_upvr.new()
    local any_createBinding_result1_2, any_createBinding_result2_upvr_2 = Roact_upvr.createBinding(123456)
    local any_createBinding_result1_3, any_createBinding_result2_upvr = Roact_upvr.createBinding(878)
    local any_createBinding_result1_4, any_createBinding_result2_upvr_4 = Roact_upvr.createBinding(0.3)
    local any_createBinding_result1, any_createBinding_result2_upvr_3 = Roact_upvr.createBinding(0.5)
    any_new_result1_upvr:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 13
        local var16 = math.sin(os.clock() * 2) * 0.5 + 0.5
        any_createBinding_result2_upvr(var16 * 500)
        any_createBinding_result2_upvr_3(var16)
        any_createBinding_result2_upvr_4(math.cos(os.clock()) * 0.5 + 0.5)
        any_createBinding_result2_upvr_2((math.cos(os.clock() * 0.1) * 0.5 + 0.5) * 1000000)
    end))
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(require(script.Parent.Speedometer), {
        distance = any_createBinding_result1_2;
        speed = any_createBinding_result1_3;
        barRatio = any_createBinding_result1_4;
        accelRatio = any_createBinding_result1;
        size = UDim2.new(0.5, 0, 0.5, 0);
        position = UDim2.new(0.25, 0, 0.25, 0);
        color = Color3.fromRGB(252, 40, 47);
        passengers = {{
            Name = "badcc";
        }, {
            Name = "asimo3089";
        }, {
            Name = "TWENTYMOREMINUTES";
        }};
    }), arg1)
    return function() -- Line 39
        Roact_upvr.unmount(any_mount_result1_upvr)
        any_new_result1_upvr:DoCleaning()
    end
end
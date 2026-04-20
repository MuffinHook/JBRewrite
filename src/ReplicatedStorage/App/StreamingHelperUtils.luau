local module = {
    yieldForAllValuesPopulated = function(arg1) -- Line 5, Named "yieldForAllValuesPopulated"
        local current_thread_upvr = coroutine.running()
        for _, v_upvr in arg1:GetDescendants() do
            if v_upvr:IsA("ValueBase") and v_upvr.Value == nil then
                local var8_upvw
                local task_delay_result1_upvw = task.delay(5, function() -- Line 13
                    var8_upvw:Disconnect()
                    var8_upvw = nil
                    warn("[StreamingHelperUtils] Timed out waiting for value to populate: ", v_upvr:GetFullName())
                    task.spawn(current_thread_upvr)
                end)
                var8_upvw = v_upvr.Changed:Connect(function() -- Line 19
                    if v_upvr.Value ~= nil then
                        var8_upvw:Disconnect()
                        var8_upvw = nil
                        task.cancel(task_delay_result1_upvw)
                        task_delay_result1_upvw = nil
                        task.spawn(current_thread_upvr)
                    end
                end)
                coroutine.yield()
            end
        end
    end;
    yieldForObjValuePopulated = function(arg1) -- Line 33, Named "yieldForObjValuePopulated"
        if arg1.Value == nil then
            local var13_upvw
            local current_thread_upvr_2 = coroutine.running()
            var13_upvw = arg1.Changed:Connect(function() -- Line 38
                if arg1.Value ~= nil then
                    var13_upvw:Disconnect()
                    var13_upvw = nil
                    task.spawn(current_thread_upvr_2)
                end
            end)
            coroutine.yield()
        end
    end;
}
local Maid_upvr = require(game:GetService("ReplicatedStorage").Std.Maid)
function module.createTableFromObjectValuesAndListen(arg1, arg2) -- Line 48
    local var16 = false
    local var17
    if typeof(arg1) == "Instance" then
        var16 = arg1:IsA("Folder")
    end
    assert(var16, "Invalid objectValues passed")
    if not var17 then
        var17 = {}
    end
    local any_new_result1_upvr = Maid_upvr.new()
    local function recursiveHelper_upvr(arg1_2, arg2_2) -- Line 54, Named "recursiveHelper"
        local function processObject_upvr(arg1_3) -- Line 55, Named "processObject"
            local var24_upvw
            if arg1_3:GetAttribute("_TypeOfName") == "number" then
                var24_upvw = tonumber(arg1_3.Name)
            end
            if arg1_3:IsA("Folder") then
                local var25 = arg2_2[var24_upvw]
                if not var25 then
                    var25 = {}
                    arg2_2[var24_upvw] = var25
                end
                recursiveHelper_upvr(arg1_3, var25)
            else
                arg2_2[var24_upvw] = arg1_3.Value
                any_new_result1_upvr:GiveTask(arg1_3.Changed:Connect(function() -- Line 70
                    arg2_2[var24_upvw] = arg1_3.Value
                end))
            end
        end
        for _, v_2 in arg1_2:GetChildren() do
            processObject_upvr(v_2)
        end
        any_new_result1_upvr:GiveTask(arg1_2.ChildAdded:Connect(function(arg1_4) -- Line 78
            processObject_upvr(arg1_4)
        end))
    end
    recursiveHelper_upvr(arg1, var17)
    return var17, any_new_result1_upvr
end
return module
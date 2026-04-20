local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
if require(ReplicatedStorage_upvr.App.RunUtils).getWorld() ~= require(ReplicatedStorage_upvr.App.RunConsts).MAIN_WORLD_NAME then
else
    local function _() -- Line 7, Named "getRunnerModule"
        local Live2024_2 = ReplicatedStorage_upvr:FindFirstChild("Live2024")
        if not Live2024_2 then
            return nil
        end
        local Runner_2 = Live2024_2:FindFirstChild("Runner")
        if not Runner_2 or not Runner_2:IsA("ModuleScript") then
            return nil
        end
        return Runner_2
    end
    while true do
        local var4_upvw
        local pcall_result1_2, pcall_result2_2 = pcall(function() -- Line 20
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            local Live2024 = ReplicatedStorage_upvr:FindFirstChild("Live2024")
            local var7
            if not Live2024 then
                var7 = nil
                -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
            end
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            local Runner = Live2024:FindFirstChild("Runner")
            if not Runner or not Runner:IsA("ModuleScript") then
                var7 = nil
            else
                var7 = Runner
            end
            var4_upvw = var7
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        end)
        if not pcall_result1_2 then
            warn(pcall_result2_2)
        end
        if var4_upvw then
            task.wait(1)
            local pcall_result1, pcall_result2 = pcall(function() -- Line 29
                print("gonna start!")
                require(var4_upvw).start()
            end)
            if not pcall_result1 then
                warn(pcall_result2)
            end
            return
        end
        task.wait(1)
    end
end
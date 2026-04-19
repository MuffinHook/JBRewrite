-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMWCExpdmUyMDI0DkZpbmRGaXJzdENoaWxkBlJ1bm5lcgxNb2R1bGVTY3JpcHQDSXNBD2dldFJ1bm5lck1vZHVsZQdyZXF1aXJlBXByaW50DGdvbm5hIHN0YXJ0IQVzdGFydARnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UDQXBwCVJ1bkNvbnN0cwhSdW5VdGlscwhnZXRXb3JsZA9NQUlOX1dPUkxEX05BTUUFcGNhbGwEd2FybgR0YXNrBHdhaXQABAUAAQAAABX7AAAAbwIAALwAAAMBAAAAnwADAisAAgDGAQAAggECAG8DAgC8AQADAQAAAJ8BAwIOAQUAbwQDALwCAf4EAAAAnwIDAisCAgDGAgAAggICAIIBAgAFAwEDAgMDAwQDBQAHBgEYAAAAAAABAQACAAAAAQAAAAAAAQACCAAAAAAGAAIAAAAX+wEBAG8DAAC8AQEDAQAAAJ8BAwIrAQIAxgAAAGUADQBvBAIAvAIBAwEAAACfAgMCDgIFAG8FAwC8AwL+BAAAAJ8DAwIrAwIAxgAAAGUAAQBSAAIA3gAAAIIAAQAFAwEDAgMDAwQDBQAUAAEYAAAAAAABAQACAAAAAQAAAAAAAQACBQEIAAAAAAMAAQAAAAykAAEAAAAAQPsBAACfAAICpAEDAAAAIEBvAgQAnwECAU0BAPwFAAAAnwEBAYIAAQAGAwcEAAAAQAMIBAAAIEADCQMKAB0AARgAAAAAAQAAAAEAAAEeAAAAAAkAAAEAAEWjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgDBBgAAAE0CAm8HAAAAnwECAqQCBQAAAEBATQMAwQYAAABNAwNCCAAAAJ8CAgJNAwJxCQAAAJ8DAQJNBAHjCgAAAPEDAgAEAAAAggABAMADCwASAAAAxgQAAKQFDQAAAMBA2QYBABIBBP8SAAAAnwUCAysFBACkBw8AAADgQFIIBgCfBwIBDgQSAKQHEgAARACBjAgBAJ8HAgGkBw0AAADAQNkIAgASAQT/nwcCA1IFBwBSBggAKwUEAKQHDwAAAOBAUggGAJ8HAgHBBAAAggABAKQHEgAARACBjAgBAJ8HAgHBBAAASADb/4IAAQATAwsEAAAAQAMMAw0DBwQAAEBAAw4DDwMQAxEDEgYAAxMEAADAQAMUBAAA4EADFQMWBABEAIEDAAECAQABGAAAAAAAAAABAAAAAAAAAQAAAAAAAAEAAAAAAAABAgAMAQAAAAAAAwEAAAACAgAAAAEAAAAAAAAFAQAAAAIAAgAAAADrFwEAAAAAAxpcdQ1E/NIV9Hj3mg6ctKxqRGJ5KJgfDA==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:29:43
-- Luau version 6, Types version 3
-- Time taken: 0.002996 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
if require(ReplicatedStorage_upvr.App.RunUtils).getWorld() ~= require(ReplicatedStorage_upvr.App.RunConsts).MAIN_WORLD_NAME then
else
    local function _() -- Line 7, Named "getRunnerModule"
        --[[ Upvalues[1]:
            [1]: ReplicatedStorage_upvr (readonly)
        ]]
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
            --[[ Upvalues[2]:
                [1]: var4_upvw (read and write)
                [2]: ReplicatedStorage_upvr (readonly)
            ]]
            -- KONSTANTERROR: [0] 1. Error Block 15 start (CF ANALYSIS FAILED)
            local Live2024 = ReplicatedStorage_upvr:FindFirstChild("Live2024")
            local var7
            if not Live2024 then
                var7 = nil
                -- KONSTANTWARNING: GOTO [21] #19
            end
            -- KONSTANTERROR: [0] 1. Error Block 15 end (CF ANALYSIS FAILED)
            -- KONSTANTERROR: [8] 8. Error Block 16 start (CF ANALYSIS FAILED)
            local Runner = Live2024:FindFirstChild("Runner")
            if not Runner or not Runner:IsA("ModuleScript") then
                var7 = nil
            else
                var7 = Runner
            end
            var4_upvw = var7
            -- KONSTANTERROR: [8] 8. Error Block 16 end (CF ANALYSIS FAILED)
        end)
        if not pcall_result1_2 then
            warn(pcall_result2_2)
        end
        if var4_upvw then
            task.wait(1)
            local pcall_result1, pcall_result2 = pcall(function() -- Line 29
                --[[ Upvalues[1]:
                    [1]: var4_upvw (read and write)
                ]]
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
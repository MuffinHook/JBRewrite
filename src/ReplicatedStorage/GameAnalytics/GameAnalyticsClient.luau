-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMaC0dldEZ1bGxOYW1lBXBjYWxsEkdhbWVBbmFseXRpY3NFcnJvcgpGaXJlU2VydmVyEklzVGVuRm9vdEludGVyZmFjZQdDb25zb2xlDFRvdWNoRW5hYmxlZAxNb3VzZUVuYWJsZWQGTW9iaWxlB0Rlc2t0b3ALZ2V0UGxhdGZvcm0HcmVxdWlyZQZzY3JpcHQGUGFyZW50DUdhbWVBbmFseXRpY3MGUG9zdGllBUVycm9yB0Nvbm5lY3QLc2V0Q2FsbGJhY2sKaW5pdENsaWVudARnYW1lCkd1aVNlcnZpY2UKR2V0U2VydmljZRBVc2VySW5wdXRTZXJ2aWNlEVJlcGxpY2F0ZWRTdG9yYWdlDVNjcmlwdENvbnRleHQABQIAAgAAAAb7AAEAvAAAsgAAAACfAAIC3gAAAIIAAQABAwEAGAABGAAAAAAAARkAAAAACwMBAAAAFysCAQCCAAEAxgMAAKQEAQAAAABA2QUAABIBA/8SAAIAnwQCAysEAgDBAwAAggABAPsGAABNBgZaAgAAAFIIAABSCQEAUgoDALwGBmsDAAAAnwYFAcEDAACCAAEABAMCBAAAAEADAwMEAQASAAEYAAEDAQAAAAAAAwEAAwAAAAAAAAAAAQATAAAAAAIAAgAAABP7AAAAvAAAbAAAAACfAAICDgACAG8AAQCCAAIA+wABAE0AAH8CAAAADgAGAPsAAQBNAABQAwAAACsAAgBvAAQAggACAG8ABQCCAAIABgMFAwYDBwMIAwkDCgAjCwEYAAAAAAABAAEAAAAAAAAAAQACACQAAAAABQAEAAAAHKQAAQAAAABApAEDAAAAIEBNAQEkBAAAAE0BAR0FAAAATQEBdQYAAACfAAIC+wEAAE0BAd4HAAAAwAMIABICAQC8AQHHCQAAAJ8BAwHAAQoAEgICABICAwBNAgBfCwAAAG8DDABSBAEAnwIDAYIAAQANAwwEAAAAQAMNBAAAIEADDgMPAxADEQYBAxIGAgMTAwsCAQIPFAEYAAAAAAAAAAAAAAACAAAAAAAAABEAAAsAAAAAARAAAAAABwAAAQIAI6MAAAD/AAEAAAAAAKQBAQAAAABAbwMCALwBARYDAAAAnwEDAqQCAQAAAABAbwQEALwCAhYDAAAAnwIDAqQDAQAAAABAbwUFALwDAxYDAAAAnwMDAqQEAQAAAABAbwYGALwEBBYDAAAAnwQDAsAFBwASAAQAEgADABIAAQASAAIAMAUAKggAAACCAAIACQMVBAAAAEADFgMXAxgDGQMaBgMDFAEDAQABGAAAAAIAAAAAAAEAAAAAAAEAAAAAAAEAAAAAAAkAAAAAAAAiAQAAAAAEVBRfenhZ9hYTwKe7GDv9rCQMSA5m0DV7

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:30:12
-- Luau version 6, Types version 3
-- Time taken: 0.001852 seconds

local module = {}
local ScriptContext_upvr = game:GetService("ScriptContext")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local GuiService_upvr = game:GetService("GuiService")
local UserInputService_upvr = game:GetService("UserInputService")
function module.initClient() -- Line 15
    --[[ Upvalues[4]:
        [1]: ScriptContext_upvr (readonly)
        [2]: ReplicatedStorage_upvr (readonly)
        [3]: GuiService_upvr (readonly)
        [4]: UserInputService_upvr (readonly)
    ]]
    ScriptContext_upvr.Error:Connect(function(arg1, arg2, arg3) -- Line 18
        --[[ Upvalues[1]:
            [1]: ReplicatedStorage_upvr (copied, readonly)
        ]]
        if not arg3 then
        else
            local var7_upvw
            local pcall_result1, pcall_result2 = pcall(function() -- Line 24
                --[[ Upvalues[2]:
                    [1]: var7_upvw (read and write)
                    [2]: arg3 (readonly)
                ]]
                var7_upvw = arg3:GetFullName()
            end)
            if not pcall_result1 then return end
            ReplicatedStorage_upvr.GameAnalyticsError:FireServer(arg1, arg2, var7_upvw)
        end
    end)
    require(script.Parent.GameAnalytics.Postie).setCallback("getPlatform", function() -- Line 35, Named "getPlatform"
        --[[ Upvalues[2]:
            [1]: GuiService_upvr (copied, readonly)
            [2]: UserInputService_upvr (copied, readonly)
        ]]
        if GuiService_upvr:IsTenFootInterface() then
            return "Console"
        end
        if UserInputService_upvr.TouchEnabled and not UserInputService_upvr.MouseEnabled then
            return "Mobile"
        end
        return "Desktop"
    end)
end
return module
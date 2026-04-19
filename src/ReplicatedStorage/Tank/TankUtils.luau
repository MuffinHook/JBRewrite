-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMUCHByaW9yaXR5C0dldENoaWxkcmVuBE5hbWUEU2VhdAlQYXNzZW5nZXISQ29udHJvbEd1blByaW9yaXR5DkZpbmRGaXJzdENoaWxkCEludFZhbHVlA0lzQQVWYWx1ZQpQbGF5ZXJOYW1lBnBsYXllcgV0YWJsZQZpbnNlcnQEc29ydAlnZXREcml2ZXIJZ2V0R3VubmVyBGdhbWUHUGxheWVycwpHZXRTZXJ2aWNlAAQFAgAAAAAJTQMA7QAAAABNBAHtAAAAALcEAgADAAAAqQIAAakCAQCCAgIAAQMBABsAARgAAAAAAAAAAAAcAAAAAA4BAgAAAEb/AQAAAAAAALwCAGgAAAAAnwICBGQCKwBNBwa6AQAAAPAHBQACAAAATQcGugEAAADwByQAAwAAgG8JBAC8BwYDBQAAAJ8HAwIOBx4AbwoGALwIB/4HAAAAnwgDAg4IGQBNCAfsCAAAAG8LCQC8CQYDBQAAAJ8JAwIOCRIA+woAAE0MCewIAAAAvAoKAwUAAACfCgMCDgoLAOINDAAwCg0ZCgAAADAIDe0LAAAAnjQBBA0AAABSDAEApAsPAAA40ICfCwMBbgLU/wIAAACkAhEAAEDQgFIDAQDABBIAnwIDARwCAQCMAwAAYAMFAAIAAAATAgEATQICGQoAAACCAgIA+wIBAE0CArQTAAAAUgMAAJ8CAgCCAgAAFAMCAwMDBAMFAwYDBwMIAwkDCgMLAwwDAQUCCgsDDQMOBAA40IADDwQAQNCABgADEAEAAxEBGAAAAgAAAAEAAAAAAAAAAQAAAAIAAAAAAAEAAQAAAAECAAAAAAABAgEAAQAAAAD+AAD0ABUAAAAAAwAAAAEAAAADAAAAAAAEAAAAAAoBAQAAABm8AQBoAAAAAJ8BAgRkAREATQYFugEAAADwBg4AAgAAgG8IAwC8BgUDBAAAAJ8GAwIOBggA+wcAAE0JBuwFAAAAvAcHAwQAAACfBwMCDgcBAIIHAgBuAe7/AgAAAMYBAACCAQIABgMCAwMDBAMLAwcDCgAkEAEYAAAAAAEAAAABAAAAAQEAAAAAAAEB+gALACUAAAAAAwAAAQIAE6MAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwL/AQIAAAAAAMACBAASAAAAEgABADACAW8FAAAAwAIGABIAAAAwAgG0BwAAAIIBAgAIAxIEAAAAQAMTAxQGAQMRBgIDEAIBAgEAARgAAAAAAAAAAQABAAAAACEAAAAOAQAAAAADcoOSP5FaVY/7u83H9YosfAKbhUtAR/g+

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:46:54
-- Luau version 6, Types version 3
-- Time taken: 0.005844 seconds

local Players_upvr = game:GetService("Players")
local module_3_upvr = {}
function module_3_upvr.getGunner(arg1) -- Line 3
    --[[ Upvalues[2]:
        [1]: Players_upvr (readonly)
        [2]: module_3_upvr (readonly)
    ]]
    local module_2 = {}
    for _, v in arg1:GetChildren() do
        if v.Name == "Seat" or v.Name == "Passenger" then
            local ControlGunPriority_3 = v:FindFirstChild("ControlGunPriority")
            if ControlGunPriority_3 and ControlGunPriority_3:IsA("IntValue") then
                local PlayerName = v:FindFirstChild("PlayerName")
                if PlayerName then
                    local SOME = Players_upvr:FindFirstChild(PlayerName.Value)
                    if SOME then
                        table.insert(module_2, {
                            player = SOME;
                            priority = ControlGunPriority_3.Value;
                        })
                    end
                end
            end
        end
    end
    table.sort(module_2, function(arg1_4, arg2) -- Line 27
        local var37
        if arg2.priority >= arg1_4.priority then
            var37 = false
        else
            var37 = true
        end
        return var37
    end)
    if 0 < #module_2 then
        return module_2[1].player
    end
    return module_3_upvr.getDriver(arg1)
end
function module_3_upvr.getDriver(arg1) -- Line 36
    --[[ Upvalues[1]:
        [1]: Players_upvr (readonly)
    ]]
    for _, v_2 in arg1:GetChildren() do
        if v_2.Name == "Seat" then
            local PlayerName_3 = v_2:FindFirstChild("PlayerName")
            if PlayerName_3 then
                local SOME_3 = Players_upvr:FindFirstChild(PlayerName_3.Value)
                if SOME_3 then
                    return SOME_3
                end
            end
        end
    end
    return nil
end
return module_3_upvr
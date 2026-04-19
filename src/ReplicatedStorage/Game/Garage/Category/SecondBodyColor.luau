-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMJBU1vZGVsClNlY29uZEJvZHkORmluZEZpcnN0Q2hpbGQETWFrZQRUYW5rClRoZVJhdHRsZXIFTUNMMzYJTUNMMzZGUkVFBVNsb29wAAIGAQAAAAAlTQEAOwAAAAArAQEAggABAG8EAQCpBQEAvAIBAwIAAACfAgQCKwIaAKkCAQBNAwCtAwAAAPADFgAEAAAAqQIBAE0DAK0DAAAA8AMRAAUAAACpAgEATQMArQMAAADwAwwABgAAAKkCAQBNAwCtAwAAAPADBwAHAAAATQMArQMAAADwAwIACAAAAKkCAAGpAgEAggICAAkDAQMCAwMDBAMFAwYDBwMIAwkAAQABGAAAAQECAAAAAAAAAQAAAAABAAAAAAEAAAAAAQAAAAEAAAAAAAACAAAAAAEAAAECAAOjAAAAwAAAAIIAAgABBgABAAEAARgAAAABAAAAAAEQTK66j6bBYHp1iedGtD3LYFS5ziKIxLs=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:36:48
-- Luau version 6, Types version 3
-- Time taken: 0.003613 seconds

return function(arg1) -- Line 1
    local Model_5 = arg1.Model
    if not Model_5 then return end
    local SecondBody = Model_5:FindFirstChild("SecondBody", true)
    if not SecondBody then
        SecondBody = true
        if arg1.Make ~= "Tank" then
            SecondBody = true
            if arg1.Make ~= "TheRattler" then
                SecondBody = true
                if arg1.Make ~= "MCL36" then
                    SecondBody = true
                    if arg1.Make ~= "MCL36FREE" then
                        if arg1.Make ~= "Sloop" then
                            SecondBody = false
                        else
                            SecondBody = true
                        end
                    end
                end
            end
        end
    end
    return SecondBody
end
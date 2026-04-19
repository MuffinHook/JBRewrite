-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMHBU1vZGVsDkZpbmRGaXJzdENoaWxkB1dpbmRvd3MISW50ZXJpb3IOU2Vjb25kSW50ZXJpb3IEVHlwZQdDaGFzc2lzAAIIAQAAAAAjTQEAOwAAAAArAQIAqQIAAIICAgBvBAAAvAIBAwEAAACfAgMCKwICAKkDAACCAwIAqQMBAG8GAgCpBwEAvAQBAwEAAACfBAQCUgMEAG8GAwC8BAIDAQAAAJ8EAwIrBAQAbwYEALwEAgMBAAAAnwQDAk0FABEFAAAA8AUDAAYAAIArBAEAqQMAAIIDAgAHAwEDAgMDAwQDBQMGAwcAAQABGAAAAQEAAgAAAAEBAAMBAAAAAAACAAAAAAAAAAABAAAAAAEDAgAAAAABAAABAgADowAAAMAAAACCAAIAAQYAAQABAAEYAAAAAQAAAAAB7aD9S7ZG8AIBeoo8T3kZUZ246j/fZJdK

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:36:53
-- Luau version 6, Types version 3
-- Time taken: 0.001159 seconds

return function(arg1) -- Line 1
    local Model = arg1.Model
    local var3
    if not Model then
        return false
    end
    var3 = "Model"
    if not Model:FindFirstChild(var3) then
        return false
    end
    var3 = Model:FindFirstChild("Windows", true)
    var3 = Model:FindFirstChild(var3):FindFirstChild("Interior")
    if not var3 then
        var3 = Model:FindFirstChild(var3):FindFirstChild("SecondInterior")
    end
    local var5
    if arg1.Type == "Chassis" and not var3 then
        var5 = false
    end
    return var5
end
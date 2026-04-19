-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMMBHRpY2sKRGlzY29ubmVjdAR1dGY4BGNoYXIJY29kZXBvaW50A2xlbgAJSGVhcnRiZWF0B0Nvbm5lY3QEZ2FtZQpSdW5TZXJ2aWNlCkdldFNlcnZpY2UAAwoABgAAABykAAEAAAAAQJ8AAQL7AgAAJgEAAvsDAQDsAgEDjAMBAGADBgACAAAAjAIBAPsDAgC8AwMaAgAAAJ8DAgH7AwMApAQFAAAQMICkBQcAABgwgPsGBACMBwEA+wkFAAkIAgmfBQQAnwQAAJ8DAAGCAAEACAMBBAAAAEADAgMDAwQEABAwgAMFBAAYMIAACgABGAAAAAEAAQABAAABAQAAAAMAAAAAAAAAAAAAAAELAAAAAAoDAQAAAB2QAgIApAMCAAAAEECfAwECpAQFAAAQMIBSBQAAnwQCAuwFBAJSBgEAbwcGAJ8GAgHGBgAA+wcAAE0HB/0HAAAA2QkAABIAAwASAAUAEgEG/xIAAQASAAAAEgAEALwHB8cIAAAAnwcDAlIGBwDBBgAAggYCAAkCAAAAAAAAOUADAQQAABBAAwMDBgQAEDCAAwcDCAMJAQADAAEYAAEAAAEAAAABAQAAAQEAAAAAAAAAAAAAAAAACwAEAAAAAAMAAAECAAqjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCwAEEABIAAACCAQIABQMKBAAAAEADCwMMBgEBAQEAARgAAAAAAAAAAgAAAQAAAAACSpX2EUw6BgVWSxyn8c6RjzqN4WV4UZwQ

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:34:51
-- Luau version 6, Types version 3
-- Time taken: 0.001272 seconds

local RunService_upvr = game:GetService("RunService")
return function(arg1, arg2, arg3) -- Line 3
    --[[ Upvalues[1]:
        [1]: RunService_upvr (readonly)
    ]]
    local utf8_len_result1_upvr = utf8.len(arg1)
    arg2("")
    local tick_result1_upvr = tick()
    local var6_upvr = utf8_len_result1_upvr / (arg3 or 25)
    local var7_upvw
    var7_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 10
        --[[ Upvalues[6]:
            [1]: tick_result1_upvr (readonly)
            [2]: var6_upvr (readonly)
            [3]: var7_upvw (read and write)
            [4]: arg2 (readonly)
            [5]: arg1 (readonly)
            [6]: utf8_len_result1_upvr (readonly)
        ]]
        local var8 = (tick() - tick_result1_upvr) / var6_upvr
        if 1 < var8 then
            var8 = 1
            var7_upvw:Disconnect()
        end
        arg2(utf8.char(utf8.codepoint(arg1, 1, var8 * utf8_len_result1_upvr)))
    end)
    return var7_upvw
end
-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMEASMGc2VsZWN0BXBhaXJzBGpvaW4AAgoAAAEAAB+jAAAA/wAAAAAAAACMAwEAbwUAALs5BQOkBAIAAAAQQN0GAACfBAACUgEEAIwCAQCoAREAuzkDBKQEAgAAABBAUgUDAN0GAACfBAACRwQJAAAAAACkBQQAAAAwQFIGBACfBQIEFwUBAGoJAAhuBf7/AgAAAIsB7/+CAAIABQMBAwIEAAAQQAMDBAAAMEAAAQQBGAABAAIAAAAAAAAAAAABAAAAAAABAAEAAAAAAf8A/QkBAAAAAAEAAAECAAOjAAAAwAAAAIIAAgABBgABAAEAARgAAA8BAAAAAAE=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:31:41
-- Luau version 6, Types version 3
-- Time taken: 0.001094 seconds

return function(...) -- Line 1, Named "join"
    local module = {}
    for i = 1, select('#', ...) do
        local selected_arg = select(i, ...)
        if selected_arg ~= nil then
            for i_2, v in pairs(selected_arg) do
                module[i_2] = v
            end
        end
    end
    return module
end
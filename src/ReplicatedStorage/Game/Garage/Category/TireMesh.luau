-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMGBFR5cGUHQ2hhc3NpcwRNYWtlB1ZvbHQ0eDQJRHVuZUJ1Z2d5Ck1vdG9yY3ljbGUAAgMBAAAAABVNAgARAAAAAPACBgABAACAqQEBAE0CAK0CAAAA8AIMAAMAAICpAQEATQIAEQAAAADwAgcABAAAAE0CABEAAAAA8AICAAUAAACpAQABqQEBAIIBAgAGAwEDAgMDAwQDBQMGAAEAARgAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAEAAAECAAOjAAAAwAAAAIIAAgABBgABAAEAARgAAAABAAAAAAE=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:36:51
-- Luau version 6, Types version 3
-- Time taken: 0.000927 seconds

return function(arg1) -- Line 1
    local var2
    local function INLINED() -- Internal function, doesn't exist in bytecode
        var2 = true
        return arg1.Make == "Volt4x4"
    end
    local function INLINED_2() -- Internal function, doesn't exist in bytecode
        var2 = true
        return arg1.Type ~= "DuneBuggy"
    end
    if arg1.Type ~= "Chassis" or INLINED() or INLINED_2() then
        if arg1.Type ~= "Motorcycle" then
            var2 = false
        else
            var2 = true
        end
    end
    return var2
end
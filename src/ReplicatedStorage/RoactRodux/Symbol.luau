-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMMBHR5cGUGc3RyaW5nLFN5bWJvbHMgbXVzdCBiZSBjcmVhdGVkIHVzaW5nIGEgc3RyaW5nIG5hbWUhBmFzc2VydAhuZXdwcm94eQpTeW1ib2woJXMpBmZvcm1hdAxnZXRtZXRhdGFibGUKX190b3N0cmluZwVuYW1lZA5Vbm5hbWVkIFN5bWJvbAd1bm5hbWVkAAUBAAEAAAAC+wAAAIIAAgAAABYAARgAABcAAAAABQEAAAAHAAABAwIVAiK7KAADUgQAAKQDAQAAAABAnwMCAvADAgACAAAAqQIAAakCAQCBAQIEAwAAAG8DAwCkAQUAAABAQJ8BAwGkAQcAAABgQKkCAQCfAQICbwIIAFIEAAC8AgKNCQAAAJ8CAwK7PAEDUgQBAKQDCwAAAKBAnwMCAtkEAAASAAIAMAQDBgwAAACCAQIADQMBBAAAAEADAgMDAwQEAABAQAMFBAAAYEADBgMHAwgEAACgQAMJAQAPCgEYAAAAAAAAAAAAAAAAAAAAAgAAAAIAAAAAAgAAAAAAAAAABBAAAAAAAQAAAAAAAm8AAACCAAIAAQMLACQAARgAACUAAAAAAwAAAAAADaQAAQAAAABAqQEBAJ8AAgK7PAADUgIAAKQBAwAAACBAnwECAsACBAAwAgEGBQAAAIIAAgAGAwUEAAAAQAMIBAAAIEAGAgMJAQIhDAEYAAAAAAIAAAAAAAAABCIAAAAAAgAAAQIACqMAAAD/AAIAAAAAAMABAAAwAQBRAQAAAMABAgAwAQDtAwAAAIIAAgAEBgEDCgYDAwwCAQMBAAEYAAYACAAAEgAACgEAAAAABEid2sQkBvE9EQ17UszwZwI4hc2welmwxQ==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:31:38
-- Luau version 6, Types version 3
-- Time taken: 0.001888 seconds

return {
    named = function(arg1) -- Line 15, Named "named"
        local var2_upvr
        if type(arg1) ~= "string" then
            var2_upvr = false
        else
            var2_upvr = true
        end
        assert(var2_upvr, "Symbols must be created using a string name!")
        var2_upvr = true
        local newproxy_result1_2 = newproxy(var2_upvr)
        var2_upvr = "Symbol(%s)":format(arg1)
        getmetatable(newproxy_result1_2).__tostring = function() -- Line 22
            --[[ Upvalues[1]:
                [1]: var2_upvr (readonly)
            ]]
            return var2_upvr
        end
        return newproxy_result1_2
    end;
    unnamed = function() -- Line 33, Named "unnamed"
        local newproxy_result1 = newproxy(true)
        getmetatable(newproxy_result1).__tostring = function() -- Line 36
            return "Unnamed Symbol"
        end
        return newproxy_result1
    end;
}
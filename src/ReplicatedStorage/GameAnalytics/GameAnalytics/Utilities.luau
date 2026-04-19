-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMHE2lzU3RyaW5nTnVsbE9yRW1wdHkGaXBhaXJzGXN0cmluZ0FycmF5Q29udGFpbnNTdHJpbmcFcGFpcnMGdHlwZW9mBXRhYmxlCWNvcHlUYWJsZQAEBAIAAAAACFYCAQArAgUAHAMBAA0DAgAAAAAAqQIAAakCAQCCAgIAAQIAAAAAAAAAAAADAQEYAAAAAAAAAAAEAAAAAAkDAAAAABIcAwEADQMDAAAAAICpAwAAggMCAKQDAgAAABBAUgQBAJ8DAgRRAwQAmgcDAAIAAACpCAEAgggCAG4D+/8CAACAqQMAAIIDAgADAgAAAAAAAAAAAwIEAAAQQAAHAwEYAAAAAQADAAAAAAEAAQD+AAYACAAAAAALAgAAAAAY/wIAAAAAAACkAwEAAAAAQFIEAQCfAwIEFwMOALssBwNSCQcApAgDAAAAIECfCAIC8AgHAAQAAIBSCgcAvAgANQUAAACfCAMCaggCBmUAAQBqBwIGbgPx/wIAAACCAgIABgMEBAAAAEADBQQAACBAAwYDBwAVBwEYAAABAAAAAAEAAAAAAAABAAAAAAAC/AAHFgAAAAACAAABAgANowAAAP8AAwAAAAAAwAEAADABAK0BAAAAwAECADABAD0DAAAAwAEEADABADUFAAAAggACAAYGAAMBBgEDAwYCAwcDAAECAQABGAAAAAIAAAQAAA4AAAwBAAAAAAPA+WYg0gO5kMQj+AC3sdv+sOFxVPI9DCE=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:30:09
-- Luau version 6, Types version 3
-- Time taken: 0.001797 seconds

return {
    isStringNullOrEmpty = function(arg1, arg2) -- Line 3, Named "isStringNullOrEmpty"
        local var2 = not arg2
        if not var2 then
            if #arg2 ~= 0 then
                var2 = false
            else
                var2 = true
            end
        end
        return var2
    end;
    stringArrayContainsString = function(arg1, arg2, arg3) -- Line 7, Named "stringArrayContainsString"
        if #arg2 == 0 then
            return false
        end
        for _, v in ipairs(arg2) do
            if v == arg3 then
                return true
            end
        end
        return false
    end;
    copyTable = function(arg1, arg2) -- Line 21, Named "copyTable"
        for i_2, v_2 in pairs(arg2) do
            if typeof(v_2) == "table" then
                ({})[i_2] = arg1:copyTable(v_2)
            else
                -- KONSTANTERROR: Expression was reused, decompilation is incorrect
                ;({})[i_2] = v_2
            end
        end
        -- KONSTANTERROR: Expression was reused, decompilation is incorrect
        return {}
    end;
}
-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMFBnN0cmluZwNsZW4EYnl0ZQRtYXRoA21pbgACFAIAAAAAV7srAANSAwAApAICAAAEAICfAgICuysBA1IEAQCkAwIAAAQAgJ8DAgL/BAAAAAAAAMYFAAANAgIAAwAAgIIDAgANAwIAAwAAgIICAgCaAAMAAQAAAIwGAACCBgIAjAgAAFIGAgCMBwEAqAYHAP8JAAAAAAAAagkECIcJBAiMCgAAaggJCosG+f+MCAAAUgYDAIwHAQCoBgQAjAoAAIcJBApqCAkIiwb8/4wIAQBSBgIAjAcBAKgGJgCMCwEAUgkDAIwKAQCoCSEAUg4IALwMANwEAAAAnwwDAlIPCwC8DQHcBAAAAJ8NAwKaDAMADQAAAIwFAABlAAEAjAUBAIcMBAh4EQgFhxAEEYcPEAuVDg8FhxEECHgSCwWHEBESlQ8QBXgTCAWHEgQTeBMLBYcREhNDEBEFTBMAAqQNCAAAHGCAnw0EAmoNDAuLCd//iwba/4cHBAKHBgcDggYCAAkDAQMCBAAEAIACAAAAAAAAAAADAwIAAAAAAADwPwMEAwUEABxggAACAAEYAAAAAAABAAAAAAEAAQMAAQEAAQEAAQAEAAAAAQAAAQAA/gQAAAABAAD/BQAAAAEAAAABAAAAAAAAAAAAAQACAwAAAAAAAAAAAAAAAAAAAAAAAPn/DQAAAwAAAAABAAABAgADowAAAMAAAACCAAIAAQYAAQABAAEYAAEAAQAAAAABy3NLqodbaBOLV86KhqvQlrtrXN75tyGr

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:39:30
-- Luau version 6, Types version 3
-- Time taken: 0.002214 seconds

return function(arg1, arg2) -- Line 2
    local string_len_result1_2 = string.len(arg1)
    local string_len_result1 = string.len(arg2)
    local module = {}
    if string_len_result1_2 == 0 then
        return string_len_result1
    end
    if string_len_result1 == 0 then
        return string_len_result1_2
    end
    if arg1 == arg2 then
        return 0
    end
    for i = 0, string_len_result1_2 do
        module[i] = {}
        module[i][0] = i
    end
    for i_2 = 0, string_len_result1 do
        module[0][i_2] = i_2
    end
    for i_3 = 1, string_len_result1_2 do
        for i_4 = 1, string_len_result1 do
            local var13
            if arg1:byte(i_3) == arg2:byte(i_4) then
                var13 = 0
            else
                var13 = 1
            end
            module[i_3][i_4] = math.min(module[i_3 - 1][i_4] + 1, module[i_3][i_4 - 1] + 1, module[i_3 - 1][i_4 - 1] + var13)
        end
    end
    return module[string_len_result1_2][string_len_result1]
end
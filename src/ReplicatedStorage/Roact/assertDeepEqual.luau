-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMSBnR5cGVvZih7MX0gaXMgb2YgdHlwZSAlcywgYnV0IHsyfSBpcyBvZiB0eXBlICVzBmZvcm1hdAV0YWJsZQVwYWlycwN7MX0HezF9WyVzXQh0b3N0cmluZwRnc3ViA3syfQd7Mn1bJXNdCnsxfSB+PSB7Mn0JZGVlcEVxdWFsBWZpcnN0BnNlY29uZB5WYWx1ZXMgd2VyZSBub3QgZGVlcC1lcXVhbC4KJXMFZXJyb3IPYXNzZXJ0RGVlcEVxdWFsAAMRAgEAAEgAAREPAwIXAg8CDBEDDTkCAw1GAg8KMh0PCC0iDwktIg8GKiUPByolAw1kAgMNcQIPCl0dDwhYIg8JWCIPBlUlDwdVJQ8CJFqFAbssAANSAwAApAIBAAAAAECfAgICuywBA1IEAQCkAwEAAAAAQJ8DAgLxAhIAAwAAAG8CAgC7LAADUgUAAKQEAQAAAABAnwQCArssAQNSBgEApAUBAAAAAECfBQICvAICjQMAAACfAgQCqQMAAFIEAgCCAwMAuywAA1IDAACkAgEAAAAAQJ8CAgLwAlsABAAAgP8CAAAAAAAApAMGAAAAUEBSBAAAnwMCBBcDJACpCAEAaggCBvsIAABSCQcAhwoBBp8IAwMrCB0AbwwHAG8NCAC7PwYDUhAGAKQPCgAAAJBAnw8CArwNDY0DAAAAnw0DALwKCcwLAAAAnwoAAm8MDABvDQ0Auz8GA1IQBgCkDwoAAACQQJ8PAgK8DQ2NAwAAAJ8NAwC8CgrMCwAAAJ8KAAKpCwAAUgwKAIILAwBuA9v/AgAAAKQDBgAAAFBAUgQBAJ8DAgQXAyQAhwgCBisIIgD7CAAAUgkHAIcKAAafCAMDKwgdAG8MBwBvDQgAuz8GA1IQBgCkDwoAAACQQJ8PAgK8DQ2NAwAAAJ8NAwC8CgnMCwAAAJ8KAAJvDAwAbw0NALs/BgNSEAYApA8KAAAAkECfDwICvA0NjQMAAACfDQMAvAoKzAsAAACfCgACqQsAAFIMCgCCCwMAbgPb/wIAAACpAwEAggMCAJoAAwABAAAAqQIBAIICAgCpAgAAbwMOAIICAwAPAwEEAAAAQAMCAwMDBAMFBAAAUEADBgMHAwgEAACQQAMJAwoDCwMMAAkNARgAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAEAAAMAAAAAAAABAAIAAAAAAQACAAAAAQIAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAgAA9wANAAAAAAEAAQAAAAICAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAIAAPcADgADAAEABAAACgAAAAAJAgEAABgAAQUPAwURAg8EBRQPBQ8KDwIAGg8DABoa+wIAAFIDAABSBAEAnwIDAysCFABvBgAAbwcBALwEA8wCAAAAnwQEAm8GAwBvBwQAvAQEzAIAAACfBAQCbwUFAFIHBAC8BQWNBgAAAJ8FAwKkBggAAABwQFIHBQCMCAIAnwYDAYIAAQAJAwYDDgMJAwoDDwMQAwMDEQQAAHBAADgSARgAAAAAAgEAAAAAAAAAAAACAAAAAAIAAAAAAjkAAAAAAgAAAQILAAACDwABBQ8BAwMGowAAAMAAAAASAAAAwAEBABIAAACCAQIAAgYABgECAAEBAAEYAAgALwAMAQAAAAAC3buTAR4sWYzvf/mVrl2yEBnwToXBE1CGUNx/JZ/yBbzusinP4hOYIA==

local function v0(v1, v2) --[[ Line: 9 ]] --[[ Name: deepEqual ]]
    -- upvalues: v0 (copy)
    if typeof(v1) ~= typeof(v2) then
        return false, (("{1} is of type %s, but {2} is of type %s"):format(typeof(v1), (typeof(v2))));
    elseif typeof(v1) == "table" then
        local v3 = {};
        for v4, v5 in pairs(v1) do
            v3[v4] = true;
            local v6, v7 = v0(v5, v2[v4]);
            if not v6 then
                return false, (v7:gsub("{1}", ("{1}[%s]"):format((tostring(v4)))):gsub("{2}", ("{2}[%s]"):format((tostring(v4)))));
            end;
        end;
        for v8, v9 in pairs(v2) do
            if not v3[v8] then
                local v10, v11 = v0(v9, v1[v8]);
                if not v10 then
                    return false, (v11:gsub("{1}", ("{1}[%s]"):format((tostring(v8)))):gsub("{2}", ("{2}[%s]"):format((tostring(v8)))));
                end;
            end;
        end;
        return true;
    elseif v1 == v2 then
        return true;
    else
        return false, "{1} ~= {2}";
    end;
end;
return function(v12, v13) --[[ Line: 56 ]] --[[ Name: assertDeepEqual ]]
    -- upvalues: v0 (copy)
    local v14, v15 = v0(v12, v13);
    if not v14 then
        local v16 = ("Values were not deep-equal.\n%s"):format((v15:gsub("{1}", "first"):gsub("{2}", "second")));
        error(v16, 2);
    end;
end;
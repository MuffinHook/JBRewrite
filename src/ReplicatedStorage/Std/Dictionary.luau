-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMIBE5vbmUBIwZzZWxlY3QFcGFpcnMFbWVyZ2UIbmV3cHJveHkMZ2V0bWV0YXRhYmxlCl9fdG9zdHJpbmcAAwEAAAAAAAJvAAAAggACAAEDAQAHAAEYAAAIAAAAAAsAAQEAGAABBQ8PCBkIDwkZCA8EDRYPAwMgDwABJCWjAAAA/wAAAAAAAACMAwEAbwUAALs5BQOkBAIAAAAQQN0GAACfBAACUgEEAIwCAQCoARcAuzkDBKQEAgAAABBAUgUDAN0GAACfBAACRwQPAAAAAACkBQQAAAAwQFIGBACfBQIEFwUHAPsKAACaCQQACgAAAMYKAABqCgAIZQABAGoJAAhuBfj/AgAAAIsB6f+CAAIABQMCAwMEAAAQQAMEBAAAMEAACwUBGAABAAIAAAAAAAAAAAABAAAAAAACAAEAAAAAAQAAAQAAAvwA/A4LAAAAAAMAAAECCwAAAg8AARQPAQ0IFaMAAACkAAEAAAAAQKkBAQCfAAICuzwAA1ICAACkAQMAAAAgQJ8BAgLAAgQAMAIBBgUAAADAAQYAEgAAAOICCQAwAAI/BwAAADABAh8IAAAAggICAAoDBgQAAABAAwcEAAAgQAYAAwgGAQMBAwUFAgcIAgABAQABGAAFAAAAAQAAAAAAAAAEABQBAAEAAAEAAAAAAqSGcoZA4J1FlkIYEv985SW+Ssne9rqfmzy0ysmuBmMReeAeUE+2OfI=

local v0 = newproxy(true);
getmetatable(v0).__tostring = function() --[[ Line: 7 ]]
    return "None";
end;
return {
    None = v0, 
    merge = function(...) --[[ Line: 11 ]] --[[ Name: merge ]]
        -- upvalues: v0 (copy)
        local v1 = {};
        for v2 = 1, select("#", ...) do
            local v3 = select(v2, ...);
            if v3 ~= nil then
                for v4, v5 in pairs(v3) do
                    if v5 == v0 then
                        v1[v4] = nil;
                    else
                        v1[v4] = v5;
                    end;
                end;
            end;
        end;
        return v1;
    end
};
-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMIASMGc2VsZWN0BXBhaXJzBmFzc2lnbgdyZXF1aXJlBnNjcmlwdAZQYXJlbnQETm9uZQACCwEBAQAUAAEEDw8IFwgPCRcIDwQLFg8DASAjowEAAIwDAQBvBQAAuzkFA6QEAgAAABBA3QYAAJ8EAAJSAQQAjAIBAKgBFwC7OQMEpAQCAAAAEEBSBQMA3QYAAJ8EAAJHBA8AAAAAAKQFBAAAADBAUgYEAJ8FAgQXBQcA+woAAJoJBAAKAAAAxgoAAGoKAAhlAAEAagkACG4F+P8CAAAAiwHp/4IAAgAFAwEDAgQAABBAAwMEAAAwQAAJBAEYAAEAAAAAAAAAAAABAAAAAAACAAEAAAAAAQAAAQAAAvwA/A4JAAAAAAQAAAECCwAAAg8AAQwPAQoDDaMAAACkAAEAAAAAQKQDAwAAACBATQIDJAQAAABNAQI/BQAAAJ8AAgLAAQYAEgAAAIIBAgAHAwUEAAAAQAMGBAAAIEADBwMIBgABAAEAARgAAAAAAAAAAAAACAASAQAAAAABXmxZ0DXw6rxsqDNEstVSLelIUAOYMVRthSkkv+iDtxpEqR5oDS5vDQ==

local v0 = require(script.Parent.None);
return function(v1, ...) --[[ Line: 9 ]] --[[ Name: assign ]]
    -- upvalues: v0 (copy)
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
end;
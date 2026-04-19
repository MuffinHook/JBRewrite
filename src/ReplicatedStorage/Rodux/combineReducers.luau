-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMCBXBhaXJzD2NvbWJpbmVSZWR1Y2VycwADCwIBAAAQAAEDDw8GCgYPBwoGDwIEDxNHAAMAAAAAgP8AAAAAAAAA/wIAAAAAAACkAwEAAAAAQPsEAACfAwIEFwMFAFIIBwCHCQAGUgoBAJ8IAwJqCAIGbgP6/wIAAACCAgIAAgMBBAAAAEAABQABGAAAAQADAAIAAAAAAgAAAAD+AAUHAAAAAAIBAAAAAAPZAQAAEgAAAIIBAgAAAQAEAgEYAAAABQAAAAABAAABAgcAAAEPAAECA6MAAADAAAAAggACAAEGAQEBAQABGAADEgEAAAAAAhHL4b/+OOLfIw+LK6wnqOveTLSABqdSNMYd7aRzJZWTBSwAwsWo5lw=

return function(v0) --[[ Line: 4 ]] --[[ Name: combineReducers ]]
    return function(v1, v2) --[[ Line: 5 ]]
        -- upvalues: v0 (copy)
        if v1 == nil then
            v1 = {};
        end;
        local v3 = {};
        for v4, v5 in pairs(v0) do
            v3[v4] = v5(v1[v4], v2);
        end;
        return v3;
    end;
end;
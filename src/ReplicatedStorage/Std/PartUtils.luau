-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMQC3NldFByb3BlcnR5CEFuY2hvcmVkC3NldEFuY2hvcmVkCkNhbkNvbGxpZGUNc2V0Q2FuQ29sbGlkZQhDYW5RdWVyeQtzZXRDYW5RdWVyeQhDYW5Ub3VjaAtzZXRDYW5Ub3VjaAxtaXNzaW5nIHJvb3QGYXNzZXJ0CEJhc2VQYXJ0A0lzQQZpcGFpcnMOR2V0RGVzY2VuZGFudHMXc2V0UHJvcGVydHlXaXRoUm9sbGJhY2sACAYCAQAACAQBAAUCBwEPCPsDAABNAgPQAAAAAFIDAABvBAEAUgUBAJ8CBACCAgAAAgMBAwIABQMBGAAAAAAAAAAABgAAAAAGAgEAAAgEAQAFAgcBDwj7AwAATQID0AAAAABSAwAAbwQBAFIFAQCfAgQAggIAAAIDAQMEAAgFARgAAAAAAAAAAAkAAAAABgIBAAAIBAEABQIHAQ8I+wMAAE0CA9AAAAAAUgMAAG8EAQBSBQEAnwIEAIICAAACAwEDBgALBwEYAAAAAAAAAAAMAAAAAAYCAQAACAQBAAUCBwEPCPsDAABNAgPQAAAAAFIDAABvBAEAUgUBAJ8CBACCAgAAAgMBAwgADgkBGAAAAAAAAAAADwAAAAALAwAAABAFAAIFAwcDDw8GFgcPBxYHIEcAAgAAAACAqQQAAakEAQCBAQQEAAAAAG8FAACkAwIAAAAQQJ8DAwFvBQMAvAMA/gQAAACfAwMCDgMBAGoCAAGkAwYAAABQQLwEAEcHAAAAnwQCAJ8DAARRAwYAbwoDALwIB/4EAAAAnwgDAg4IAQBqAgcBbgP5/wIAAICCAAEACAMKAwsEAAAQQAMMAw0DDgQAAFBAAw8AEQEBGAAAAAAAAAAAAAABAAAAAAECAAAAAAAAAQAAAAAB/gAFEgAAAAAHAAMAAA4AAwIPDwMPAwMKDwQDChD7AAAAxgEAAMYCAABkAAkA+wUBAJoEBQAFAAAA+wUCAMYGAABqBgMFZQACAPsFAgBqBAMFbgD2/wIAAACCAAEAAAArAAEYAAAAAAEAAAEAAAACAPwABywAAAAADAMBAAAdBQEFBQMHAw8PDwQHCA8JGwgPBxUODwgVDg8DACoq/wMAAAAAAABvBgAAvAQA/gEAAACfBAMCDgQIAIcFAAFHBQMAAAAAgPsEAABlAAEAhwQAAWoEAwBqAgABpAQDAAAAIEC8BQBHBAAAAJ8FAgCfBAAEUQQNAG8LAAC8CQj+AQAAAJ8JAwIOCQgAhwoIAUcKAwAAAACA+wkAAGUAAQCHCQgBagkDCGoCCAFuBPL/AgAAgNkEAAASAAMAEgIAABIAAQCCBAIABQMMAw0DDgQAACBAAw8BBR0QARgAAAEAAAAAAQAAAAAAAQECAAAAAAAAAQAAAAABAAAAAAABAfwABwAAAAAeAAAAAAMAAAECCwAAAg8AARwPARYHHaMAAAD/AAQAAAAAAMABAAASAAAAMAEAHwEAAADAAQIAEgAAADABABYDAAAAwAEEABIAAAAwAQDZBQAAAMABBgASAAAAMAEAVQcAAADAAQgAMAEA0AkAAAD/AQAAAAAAAMACCgASAAEAMAIA6AsAAACCAAIADAYAAwMGAQMFBgIDBwYDAwkGBAMBBgYDEAYAAQIDBAYBAAEYAAEAAwAAAAMAAAADAAAAAwAAAAMAAAsAAQAAABkBAAAAAAdd9PRUG/LQ0G8wnsA0zbKfF8+NxjlMrdTGUHjQo4T/1m+AELp9/act

local v0 = {};
v0.setAnchored = function(v1, v2) --[[ Line: 5 ]] --[[ Name: setAnchored ]]
    -- upvalues: v0 (copy)
    return v0.setProperty(v1, "Anchored", v2);
end;
v0.setCanCollide = function(v3, v4) --[[ Line: 8 ]] --[[ Name: setCanCollide ]]
    -- upvalues: v0 (copy)
    return v0.setProperty(v3, "CanCollide", v4);
end;
v0.setCanQuery = function(v5, v6) --[[ Line: 11 ]] --[[ Name: setCanQuery ]]
    -- upvalues: v0 (copy)
    return v0.setProperty(v5, "CanQuery", v6);
end;
v0.setCanTouch = function(v7, v8) --[[ Line: 14 ]] --[[ Name: setCanTouch ]]
    -- upvalues: v0 (copy)
    return v0.setProperty(v7, "CanTouch", v8);
end;
v0.setProperty = function(v9, v10, v11) --[[ Line: 17 ]] --[[ Name: setProperty ]]
    assert(v9 ~= nil, "missing root");
    if v9:IsA("BasePart") then
        v9[v10] = v11;
    end;
    for _, v13 in ipairs(v9:GetDescendants()) do
        if v13:IsA("BasePart") then
            v13[v10] = v11;
        end;
    end;
end;
local v14 = {};
v0.setPropertyWithRollback = function(v15, v16, v17) --[[ Line: 29 ]] --[[ Name: setPropertyWithRollback ]]
    -- upvalues: v14 (copy)
    local v18 = {};
    if v15:IsA("BasePart") then
        v18[v15] = if v15[v16] == nil then v14 else v15[v16];
        v15[v16] = v17;
    end;
    for _, v20 in ipairs(v15:GetDescendants()) do
        if v20:IsA("BasePart") then
            v18[v20] = if v20[v16] == nil then v14 else v20[v16];
            v20[v16] = v17;
        end;
    end;
    return function() --[[ Line: 43 ]]
        -- upvalues: v18 (copy), v14 (ref), v16 (copy)
        for v21, v22 in v18 do
            if v22 == v14 then
                v21[v16] = nil;
            else
                v21[v16] = v22;
            end;
        end;
    end;
end;
return v0;
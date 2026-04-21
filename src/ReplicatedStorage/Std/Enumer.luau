-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMPBF9tYXAFZXJyb3IgRW51bSBkb2VzIG5vdCBjb250YWluIGl0ZW06IGAlc2AGZm9ybWF0B19faW5kZXgGX2FycmF5DEdldEVudW1JdGVtcxBHZXRWYWx1ZUZyb21FbnVtEENhbm5vdCBpdGVyIGVudW0EbmV4dAZfX2l0ZXIFdGFibGUGZnJlZXplCGlzZnJvemVuDHNldG1ldGF0YWJsZQAGBgIBAAAIAAEBDwMDEgIX+wMAAIcCAwEOAgMA+wMAAIcCAwGCAgIATQMACAAAAACHAgMBDgIEAE0DAAgAAAAAhwIDAYICAgCkAgIAAAAQQG8DAwBSBQEAvAMDjQQAAACfAwMAnwIAAYIAAQAFAwEDAgQAABBAAwMDBAAGBQEYAAAAAQAAAQAAAAEAAAACAAAAAAAAAAIHAAAAAAIBAAAAAANNAQDEAAAAAIIBAgABAwYADwcBGAAAABAAAAAABAIAAAAABE0DAMQAAAAAhwIDAYICAgABAwYAEggBGAAAAAATAAAAAAMBAAAAAAmkAQEAAAAAQG8CAgCfAQIBpAEEAAAAMEBNAgAIBQAAAIIBAwAGAwIEAAAAQAMJAwoEAAAwQAMBABULARgAAAAABQAAAAAWAAAAAAgBAQAAEAABAw8PBQsEDwYLBA8BAC0t/wECAAAAAAAwAAHEAAAAAP8CAAAAAAAAMAIBCAEAAABSAgAAxgMAAMYEAABkAgMATQcBCAEAAABqBQcGbgL8/wIAAACkAgQAAAwggE0DAQgBAAAAnwICAaQCBgAAFCCATQMBxAAAAACfAgICKwIFAKQCBAAADCCATQMBxAAAAACfAgIB+wQAAJ49AQQEAAAAUgMBAKQCCAAAAHBAnwIDAaQCBAAADCCAUgMBAJ8CAgGCAQIACQMGAwEDDAMNBAAMIIADDgQAFCCAAw8EAABwQAAdAAEYAAABAAEAAAABAAAAAQAA/wADAAAAAAEAAAAAAAEAAAAAAgAAAAAAAAEAAAABHgAAAAACAAABAgcAAAEPAAESE6MAAAD/AAMAAAAAAMABAAASAAAAMAEAbgEAAADAAQIAMAEAFgMAAADAAQQAMAEAywUAAADAAQYAMAEATAcAAADAAQgAEgAAAIIBAgAJBgADBQYBAwcGAgMIBgMDCwYEBQABAgMEAQABGAAEAAEAAAAJAAADAAADAAAIAAABAAAAAAWpdYjqZGL785ux4n6vuRYed/CAgtLC7PK5EZY1s5sDxiUe/UaW5jwv

local v0 = {};
v0.__index = function(v1, v2) --[[ Line: 6 ]] --[[ Name: __index ]]
    -- upvalues: v0 (copy)
    if v0[v2] then
        return v0[v2];
    elseif v1._map[v2] then
        return v1._map[v2];
    else
        error(string.format(("Enum does not contain item: `%s`"), v2));
        return;
    end;
end;
v0.GetEnumItems = function(v3) --[[ Line: 15 ]] --[[ Name: GetEnumItems ]]
    return v3._array;
end;
v0.GetValueFromEnum = function(v4, v5) --[[ Line: 18 ]] --[[ Name: GetValueFromEnum ]]
    return v4._array[v5];
end;
v0.__iter = function(v6) --[[ Line: 21 ]] --[[ Name: __iter ]]
    error("Cannot iter enum");
    return next, v6._map;
end;
return function(v7) --[[ Line: 29 ]]
    -- upvalues: v0 (copy)
    local v8 = {
        _array = v7, 
        _map = {}
    };
    for v9, v10 in v7 do
        v8._map[v10] = v9;
    end;
    table.freeze(v8._map);
    if not table.isfrozen(v8._array) then
        table.freeze(v8._array);
    end;
    setmetatable(v8, v0);
    table.freeze(v8);
    return v8;
end;
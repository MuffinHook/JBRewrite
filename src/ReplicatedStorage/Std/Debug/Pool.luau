-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMODHNldG1ldGF0YWJsZQVfcG9vbAhfZ2V0SW5zdAxfZGVzdHJveUluc3QDbmV3BXRhYmxlBnJlbW92ZQNHZXQERnJlZQhQb3B1bGF0ZQZpbnNlcnQGaXBhaXJzB0Rlc3Ryb3kHX19pbmRleAAGBgIBAAAIAAEBDw8CABIS/wIDAAAAAAD7BQAAnj0CBAUAAABSBAIApAMBAAAAAECfAwMB/wMAAAAAAAAwAwJZAgAAADAAAm0DAAAAMAECMwQAAACCAgIABQMBBAAAAEADAgMDAwQABAUBGAAAAQAAAAAAAAIAAAABAAEAAgUAAAAAAwEAAAAHAAABDwEMBBBNAgBZAAAAABwBAgCMAgAAYAIHAAEAAACkAQMAAAgQgE0CAFkAAAAAnwECAIIBAABNAQBtBAAAAJ8BAQKCAQIABQMCAwYDBwQACBCAAwMADggBGAAAAAAAAAEAAAAAAAIAAAEPAAAAAAkCAAAACwAAAg8FBAcPBAALDYwEAQBSAgEAjAMBAKgCCABNBQBtAAAAAJ8FAQJSCAUAvAYAgwEAAACfBgMBiwL4/4IAAQACAwMDCQAWCgEYAAAAAAEAAAEAAAD+BBcAAAAABQIAAAAACU0DAFkAAAAAnjQDBAEAAABSBAEApAIDAAAIEICfAgMBggABAAQDAgMGAwsEAAgQgAAcCQEYAAAAAAAAAAABHQAAAAAIAQAAAAsAAAIPBAUFDwUFBRCkAQEAAAAAQE0CAFkCAAAAnwECBFEBBABNBgAzAwAAAFIHBQCfBgIBbgH7/wIAAIDGAQAAMAEAWQIAAACCAAEABAMMBAAAAEADAgMEAB8NARgAAAAAAAABAAAA/wADAAABIAAAAAACAAABAgcAAAEPAAEVFqMAAAD/AAQAAAAAADAAAG4AAAAAwAEBABIAAAAwAQDvAgAAAMABAwAwAQB/BAAAAMABBQAwAQAZBgAAAMABBwAwAQCDCAAAAMABCQAwAQBQCgAAAIIAAgALAw4GAAMFBgEDCAYCAwoGAwMJBgQDDQUAAQIDBAEAARgAAQABAAEAAAAKAAAIAAAGAAADAAAGAQAAAAAFWy3jbEF5zndp6Yn4tQJaYrZzIl41zl7te1nDT7KGNx8syMGJ3ewbQQ==

local v0 = {};
v0.__index = v0;
v0.new = function(v1, v2) --[[ Line: 4 ]] --[[ Name: new ]]
    -- upvalues: v0 (copy)
    local v3 = {};
    setmetatable(v3, v0);
    v3._pool = {};
    v3._getInst = v1;
    v3._destroyInst = v2;
    return v3;
end;
v0.Get = function(v4) --[[ Line: 14 ]] --[[ Name: Get ]]
    if #v4._pool > 0 then
        return table.remove(v4._pool);
    else
        return (v4._getInst());
    end;
end;
v0.Populate = function(v5, v6) --[[ Line: 22 ]] --[[ Name: Populate ]]
    for _ = 1, v6 do
        v5:Free((v5._getInst()));
    end;
end;
v0.Free = function(v8, v9) --[[ Line: 28 ]] --[[ Name: Free ]]
    table.insert(v8._pool, v9);
end;
v0.Destroy = function(v10) --[[ Line: 31 ]] --[[ Name: Destroy ]]
    for _, v12 in ipairs(v10._pool) do
        v10._destroyInst(v12);
    end;
    v10._pool = nil;
end;
return v0;
-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMLGFJvYWN0SG9zdENoYW5nZUV2ZW50KCVzKQRuYW1lBmZvcm1hdApfX3Rvc3RyaW5nD0hvc3RDaGFuZ2VFdmVudAxzZXRtZXRhdGFibGUHX19pbmRleAdyZXF1aXJlBnNjcmlwdAZQYXJlbnQEVHlwZQADBAEAAAAHAAABAwEDAgdvAQAATQMAWgEAAAC8AQGNAgAAAJ8BAwCCAQAAAwMBAwIDAwATBAEYAAAAAAAAABQAAAAABgIDAAAKAAMBDw8PDwIAExP/AgIAAAAAAPsDAAD7BQAATQQFZgAAAABqBAIDMAECWgEAAAD7BQEAnj0CBAUAAABSBAIApAMDAAAAIECfAwMB+wMCAGoCAwGCAgIABAMFAwIDBgQAACBAABkHARgAAAEAAAAAAQADAAAAAAAAAQACGgAAAAAHAAABAg8AAAMPAAEfDwEMFA8CDhIgowAAAKQAAQAAAABApAQDAAAAIEBNAwQkBAAAAE0CAyQEAAAATQECEQUAAACfAAIC/wEAAAAAAADiAgcAwAMIADADAgYGAAAA4gUKAMAGCwASAAAAEgACABIAAQAwBgVuCQAAAJ49AQQFAAAAUgQBAKQDDQAAAMBAnwMDAYIBAgAOAwgEAAAAQAMJBAAAIEADCgMLAwQFAQYGAAMHBQEJBgEDBgQAAMBAAgABAQABGAANAAAAAAAAAAAAAAIAAgEAAAUBAAAAAAAAAAD/AAAOAQAAAAACWIvxz2+RXjNqT5tb5GLQhiIFaaz0nu4sMLuyCzw5b67WP8CkxPkqaw==

local v0 = require(script.Parent.Parent.Type);
local v1 = {};
local v3 = {
    __tostring = function(v2) --[[ Line: 19 ]] --[[ Name: __tostring ]]
        return string.format(("RoactHostChangeEvent(%s)"), v2.name);
    end
};
setmetatable(v1, {
    __index = function(_, v5) --[[ Line: 25 ]] --[[ Name: __index ]]
        -- upvalues: v0 (copy), v3 (copy), v1 (copy)
        local v6 = {
            [v0] = v0.HostChangeEvent, 
            name = v5
        };
        setmetatable(v6, v3);
        v1[v5] = v6;
        return v6;
    end
});
return v1;
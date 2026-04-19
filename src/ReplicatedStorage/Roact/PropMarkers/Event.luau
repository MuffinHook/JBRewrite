-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMLElJvYWN0SG9zdEV2ZW50KCVzKQRuYW1lBmZvcm1hdApfX3Rvc3RyaW5nCUhvc3RFdmVudAxzZXRtZXRhdGFibGUHX19pbmRleAdyZXF1aXJlBnNjcmlwdAZQYXJlbnQEVHlwZQADBAEAAAAHAAABAwEDAgdvAQAATQMAWgEAAAC8AQGNAgAAAJ8BAwCCAQAAAwMBAwIDAwAVBAEYAAAAAAAAABYAAAAABgIDAAAKAAMBDw8PDwIAExP/AgIAAAAAAPsDAAD7BQAATQQFKgAAAABqBAIDMAECWgEAAAD7BQEAnj0CBAUAAABSBAIApAMDAAAAIECfAwMB+wMCAGoCAwGCAgIABAMFAwIDBgQAACBAABsHARgAAAEAAAAAAQADAAAAAAAAAgACHAAAAAAHAAABAg8AAAMPAAEfDwEMFA8CDhIgowAAAKQAAQAAAABApAQDAAAAIEBNAwQkBAAAAE0CAyQEAAAATQECEQUAAACfAAIC/wEAAAAAAADiAgcAwAMIADADAgYGAAAA4gUKAMAGCwASAAAAEgACABIAAQAwBgVuCQAAAJ49AQQFAAAAUgQBAKQDDQAAAMBAnwMDAYIBAgAOAwgEAAAAQAMJBAAAIEADCgMLAwQFAQYGAAMHBQEJBgEDBgQAAMBAAgABAQABGAAPAAAAAAAAAAAAAAIAAgEAAAUBAAAAAAAAAAD/AAAPAQAAAAACnGSat/+oVP2uoPAjx9/XSR9a/3dWc13AyDNYq7fFiJmkBSymFPyD2A==

local v0 = require(script.Parent.Parent.Type);
local v1 = {};
local v3 = {
    __tostring = function(v2) --[[ Line: 21 ]] --[[ Name: __tostring ]]
        return ("RoactHostEvent(%s)"):format(v2.name);
    end
};
setmetatable(v1, {
    __index = function(_, v5) --[[ Line: 27 ]] --[[ Name: __index ]]
        -- upvalues: v0 (copy), v3 (copy), v1 (copy)
        local v6 = {
            [v0] = v0.HostEvent, 
            name = v5
        };
        setmetatable(v6, v3);
        v1[v5] = v6;
        return v6;
    end
});
return v1;
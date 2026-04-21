-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMRB2N1cnJlbnQIZ2V0VmFsdWUHX19pbmRleAVlcnJvci9DYW5ub3QgYXNzaWduIHRvIHRoZSAnY3VycmVudCcgcHJvcGVydHkgb2YgcmVmcwpfX25ld2luZGV4DFJvYWN0UmVmKCVzKQh0b3N0cmluZwZmb3JtYXQKX190b3N0cmluZwZjcmVhdGUMc2V0bWV0YXRhYmxlCWNyZWF0ZVJlZgdyZXF1aXJlBnNjcmlwdAZQYXJlbnQHQmluZGluZwAFBAIBAAAEAAEADwrwAQYAAAAAgPsCAAC8AgLTAQAAAJ8CAgCCAgAA+wMAAIcCAwGCAgIAAgMBAwIAEAMBGAAAAQAAAAACAAARAAAAAAYDAQAABAABAA8K8AEGAAAAAICkAwIAAAAQQG8EAwCMBQIAnwMDAfsDAABqAgMBggABAAQDAQMEBAAAEEADBQAXBgEYAAABAAAAAAMAARgAAAAABgEBAAAIAAEBDwMBCQINbwEAAPsEAAC8BATTAQAAAJ8EAgBMPwACpAMDAAAAIECfAwACvAEBjQQAAACfAQMAggEAAAUDBwMCAwgEAAAgQAMJAB4KARgAAAAAAAAAAAAAAAAAHwAAAAAHAAEAABAAAQMPDwAAGw8BABsPAgUWG/sBAABNAAF2AAAAAMYBAACfAAID/wIAAAAAAADiBQQA2QYAABIAAAAwBgVuAQAAANkGAQASAAAAMAYFzgIAAADZBgIAEgAAADAGBQYDAAAAnj0CBAUAAABSBAIApAMGAAAAUECfAwMBggICAAcDCwMDAwYDCgUDAQIDAwwEAABQQAMAAQIHDQEYAAAAAAACAAUBAAAABwAAAAcAAAAAAADxAAAUCAAAAAAEAAABAgsAAAIPAAEMDwEKAw2jAAAApAABAAAAAECkAwMAAAAgQE0CAyQEAAAATQECqAUAAACfAAICwAEGABIAAACCAQIABwMOBAAAAEADDwQAACBAAxADEQYDAQMBAAEYAAQAAAAAAAAAAAIAHwEAAAAABCfzU3jeroUDFTc57CwGuf5JgHircVnTjKkLD5Pwx0xbR0BUs0eBiWY=

local v0 = require(script.Parent.Binding);
return function() --[[ Line: 7 ]] --[[ Name: createRef ]]
    -- upvalues: v0 (copy)
    local v1, _ = v0.create(nil);
    local v3 = {};
    setmetatable(v3, {
        __index = function(_, v5) --[[ Line: 16 ]] --[[ Name: __index ]]
            -- upvalues: v1 (copy)
            if v5 == "current" then
                return v1:getValue();
            else
                return v1[v5];
            end;
        end, 
        __newindex = function(_, v7, v8) --[[ Line: 23 ]] --[[ Name: __newindex ]]
            -- upvalues: v1 (copy)
            if v7 == "current" then
                error("Cannot assign to the 'current' property of refs", 2);
            end;
            v1[v7] = v8;
        end, 
        __tostring = function(_) --[[ Line: 30 ]] --[[ Name: __tostring ]]
            -- upvalues: v1 (copy)
            return string.format(("RoactRef(%s)"), (tostring(v1:getValue())));
        end
    });
    return v3;
end;
-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMMDHNldG1ldGF0YWJsZQZ0YXJnZXQCa1ACa0kCa0QIX2xhc3RFcnIMX2ludGVncmFsRXJyA25ldwZVcGRhdGUJU2V0VGFyZ2V0BVJlc2V0B19faW5kZXgABQcEAQAADgYBAQUEDwICAg8PBAEaG5AAAAD/BQQAAAAAAPsGAACePQUDBgAAAKQEAgAAABBAnwQDAjAABAwDAAAAkAUBBDAFBF0FAAAAkAUCADAFBGYGAAAAkAUDADAFBMoHAAAAWwUAADAFBKYIAAAAWwUAADAFBAYJAAAAggQCAAoCAAAAAAAAAAADAQQAABBAAwICAAAAAAAA8D8DAwMEAwUDBgMHABsIARgAAQAAAAAAAAABAAEAAAEAAAEAAAEAAAEAAAIcAAAAAAoDAAAAIAUABgUDBA8CDwMAHQ8ECRQPBQ8ODwYSCw8HFwYPCBoDHU0EAAwAAAAAJgMEAU0EAAYBAAAACQUDAkMEBAUwBAAGAQAAAE0GAKYCAAAAJgUDBuwEBQIwAwCmAgAAAE0GAF0DAAAACQUGA00HAGYEAAAATQgABgEAAAAJBgcITQgAygUAAAAJBwgEQwkFBkMICQeCCAIABgMCAwcDBgMDAwQDBQAoCQEYAAAAAQAAAAAAAQAAAAEAAQAAAQAAAAABAAABAAEpAAAAAAICAAAAAAMwAQAMAAAAAIIAAQABAwIAMwoBGAAAATQAAAAAAgEAAAAAC00BAKYAAAAAWwEBATABAKYAAAAATQEABgIAAABbAQEBMAEABgIAAACCAAEAAwMGAgAAAAAAAAAAAwcANgsBGAAAAAAAAQAAAAABNwAAAAACAAABAgcAAAEPAAESE6MAAAD/AAQAAAAAADAAAG4AAAAAwAEBABIAAAAwAQDvAgAAAMABAwAwAQAmBAAAAMABBQAwAQCXBgAAAMABBwAwAQB/CAAAAIIAAgAJAwwGAAMIBgEDCQYCAwoGAwMLBAABAgMBAAEYAAEAAQAYAAAADQAACwAAAwAABQEAAAAABL/bMjNdyZfBjR9YpwRYe/qYXpFX6i6AxFyLJ/Sczg/N7z3A2f/coKo=

local v0 = {};
v0.__index = v0;
v0.new = function(v1, v2, v3, v4) --[[ Line: 27 ]] --[[ Name: new ]]
    -- upvalues: v0 (copy)
    v1 = v1 or 0;
    local v5 = setmetatable({}, v0);
    v5.target = v1;
    v5.kP = v2 or 1;
    v5.kI = v3 or 0;
    v5.kD = v4 or 0;
    v5._lastErr = v1 * 0;
    v5._integralErr = v1 * 0;
    return v5;
end;
v0.Update = function(v6, v7, v8) --[[ Line: 40 ]] --[[ Name: Update ]]
    local v9 = v6.target - v7;
    v6._integralErr = v6._integralErr + v9 * v8;
    local v10 = (v9 - v6._lastErr) / v8;
    v6._lastErr = v9;
    local v11 = v6.kP * v9;
    local v12 = v6.kI * v6._integralErr;
    local v13 = v6.kD * v10;
    return v11 + v12 + v13;
end;
v0.SetTarget = function(v14, v15) --[[ Line: 51 ]] --[[ Name: SetTarget ]]
    v14.target = v15;
end;
v0.Reset = function(v16) --[[ Line: 54 ]] --[[ Name: Reset ]]
    v16._lastErr = v16._lastErr * 0;
    v16._integralErr = v16._integralErr * 0;
end;
return v0;
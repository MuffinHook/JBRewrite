-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMQEG1pc3NpbmcgcG9zaXRpb24GYXNzZXJ0CU1hZ25pdHVkZRxkaXJlY3Rpb24gaXMgbm90IHVuaXQgbGVuZ3RoFmxlbmd0aCBpcyBub3Qgbm9uIHplcm8WcmFkaXVzIGlzIG5vdCBub24gemVybw1SYXljYXN0UGFyYW1zA25ldxpGaWx0ZXJEZXNjZW5kYW50c0luc3RhbmNlcwl3b3Jrc3BhY2UKU3BoZXJlY2FzdAhJbnN0YW5jZQpDYW5Db2xsaWRlBXRhYmxlBmluc2VydApjb2xsaWRhYmxlAAIPBgAAABcIAAMFBggCCAKHhQ8GMi4CBzQsDwg1K2CBAQAFAAAAAFIHAABvCAAApAYCAAAAEECfBgMBTQkCqgQAAAB4CAkDbwkFANQIAgAJAAAAqQcAAakHAQCBAQcEBgAAAG8IBgCkBgIAAAAQQJ8GAwGMCAAAtwgCAAMAAACpBwABqQcBAIEBBwQHAAAAbwgHAKQGAgAAABBAnwYDAYwIAAC3CAIAAQAAAKkHAAGpBwEAgQEHBAgAAABvCAgApAYCAAAAEECfBgMBKwQEAKQGCwAAKJCAnwYBAlIEBgArBAEAggABAE0GBH0MAAAAjAcAAMYIAABvCQUAfQknAAMAAACMCQoAfQckAAkAAACkCQ4AAADQQFILAABSDAEACQ0CA1IOBAC8CQlYDwAAAJ8JBgJSCAkADggYAA4FBQBSCQUATQoI9BAAAACfCQICKwkSACsFBQBNCgj0EAAAAE0JCtMRAAAAKwkMAE0LCPQQAAAAnjQGBAsAAABSCgYApAkUAABMIIGfCQMBMAYEfQwAAACVBwcDSADX/4IIAgAVAwEDAgQAABBAAgAAAAAAAPA/AwMC/Knx0k1iUD8DBAMFAwYDBwMIBAAokIADCQMKBAAA0EADCwMMAw0DDgMPBABMIIEABRABGAAAAAAAAAABAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAQAAAAAAAAAAAAACAQAAAAMBAgACAQEAAAAAAAEAAAAAAAAAAAABAwEAAAAAAAEAAAAACQAAAAAAAAAEAAHrFw0AAAAAAgAAAQIHAAABDwABBgejAAAA/wABAAAAAADAAQAAMAEAmgEAAACCAAIAAgYAAxABAAEAARgAAQADAAAxAQAAAAABpuUUgQI5EPeUIX4VOnKCh9A4xcYaFhASZHMUiyIYeNqedmDldhPU6g==

return {
    collidable = function(v0, v1, v2, v3, v4, v5) --[[ Line: 5 ]] --[[ Name: collidable ]]
        assert(v0, "missing position");
        assert(v2.Magnitude - 1 <= 0.001, "direction is not unit length");
        assert(v3 > 0, "length is not non zero");
        assert(v1 > 0, "radius is not non zero");
        if not v4 then
            v4 = RaycastParams.new();
        end;
        if not v4 then
            return;
        else
            local l_FilterDescendantsInstances_0 = v4.FilterDescendantsInstances;
            local v7 = 0;
            local v8 = nil;
            while v3 >= 0.001 and v7 <= 10 do
                v8 = workspace:Spherecast(v0, v1, v2 * v3, v4);
                if v8 and (not v5 or not v5(v8.Instance)) and (v5 or not v8.Instance.CanCollide) then
                    table.insert(l_FilterDescendantsInstances_0, v8.Instance);
                    v4.FilterDescendantsInstances = l_FilterDescendantsInstances_0;
                    v7 = v7 + 1;
                else
                    break;
                end;
            end;
            return v8;
        end;
    end
};
-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMPBXBvaW50BG5hbWUhbWluaW1hcCBwb2ludCBtaXNzaW5nIHVuaXF1ZSBuYW1lBmFzc2VydAZpcGFpcnMFdGFibGUGaW5zZXJ0D2FkZE1pbmltYXBQb2ludBJyZW1vdmVNaW5pbWFwUG9pbnQEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUFUm9kdXgNY3JlYXRlUmVkdWNlcgADCwIAAAAAL00EAeIAAAAATQQEWgEAAABHBAIAAAAAgKkDAAGpAwEAgQEDBAIAAABvBAIApAIEAAAAMECfAgMB/wIAAAAAAACkAwYAAABQQFIEAACfAwIEUQMPAE0IB1oBAAAATQkB4gAAAABNCQlaAQAAAPEICAAJAAAAnjQCBQcAAABSCQIAUgoHAKQICQAAIHCAnwgDAW4D8P8CAACATQUB4gAAAACeNAIEBQAAAFIEAgCkAwkAACBwgJ8DAwGCAgIACgMBAwIDAwMEBAAAMEADBQQAAFBAAwYDBwQAIHCAAAUIARgAAAAAAAAAAAAAAAAAAAIAAQAAAAABAAAAAAAAAAEAAAAAAAD+AAYAAAAAAAAAAQYAAAAACwIAAAAAI00EAVoAAAAARwQCAAAAAICpAwABqQMBAIEBAwQBAAAAbwQBAKQCAwAAACBAnwIDAf8CAAAAAAAApAMFAAAAQEBSBAAAnwMCBFEDDQBNCAdaAAAAAE0JAVoAAAAA8QgIAAkAAACeNAIFBwAAAFIJAgBSCgcApAgIAAAcYICfCAMBbgPy/wIAAICCAgIACQMCAwMDBAQAACBAAwUEAABAQAMGAwcEABxggAASCQEYAAAAAAAAAAAAAAAAAQABAAAAAAEAAAAAAAEAAAAAAAD+AAUTAAAAAAYAAAECABmjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgCnBgAAAJ8BAgJNAgHWBwAAAP8DAAAAAAAA4gQKAMAFCwAwBQQRCAAAAMAFDAAwBQQ6CQAAAJ8CAwCCAgAADQMKBAAAAEADCwMMAw0EAABAQAMOAw8DCAMJBQIICQYABgECAAEBAAEYAAAAAAAAAAEAAAAAAgAAAAABAAANAADyAAEAAAAAAonK6VudU3SYVi1cPNLIZ/v50v4vuw6DWg==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:40:35
-- Luau version 6, Types version 3
-- Time taken: 0.002857 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    addMinimapPoint = function(arg1, arg2) -- Line 5, Named "addMinimapPoint"
        local var6
        if arg2.point.name == nil then
            var6 = false
        else
            var6 = true
        end
        assert(var6, "minimap point missing unique name")
        local module = {}
        var6 = ipairs(arg1)
        local ipairs_result1, ipairs_result2, ipairs_result3_2 = ipairs(arg1)
        for _, v in ipairs_result1, ipairs_result2, ipairs_result3_2 do
            if v.name ~= arg2.point.name then
                table.insert(module, v)
            end
        end
        ipairs_result1 = table.insert
        ipairs_result1(module, arg2.point)
        return module
    end;
    removeMinimapPoint = function(arg1, arg2) -- Line 18, Named "removeMinimapPoint"
        local var15
        if arg2.name == nil then
            var15 = false
        else
            var15 = true
        end
        assert(var15, "minimap point missing unique name")
        var15 = ipairs(arg1)
        for _, v_2 in ipairs(arg1) do
            if v_2.name ~= arg2.name then
                table.insert({}, v_2)
            end
        end
        -- KONSTANTERROR: Expression was reused, decompilation is incorrect
        return {}
    end;
})
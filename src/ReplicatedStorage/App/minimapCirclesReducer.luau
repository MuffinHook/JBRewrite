-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMPBmNpcmNsZQRuYW1lIm1pbmltYXAgY2lyY2xlIG1pc3NpbmcgdW5pcXVlIG5hbWUGYXNzZXJ0BmlwYWlycwV0YWJsZQZpbnNlcnQQYWRkTWluaW1hcENpcmNsZRNyZW1vdmVNaW5pbWFwQ2lyY2xlBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlBVJvZHV4DWNyZWF0ZVJlZHVjZXIAAwsCAAAAAC9NBAEQAAAAAE0EBFoBAAAARwQCAAAAAICpAwABqQMBAIEBAwQCAAAAbwQCAKQCBAAAADBAnwIDAf8CAAAAAAAApAMGAAAAUEBSBAAAnwMCBFEDDwBNCAdaAQAAAE0JARAAAAAATQkJWgEAAADxCAgACQAAAJ40AgUHAAAAUgkCAFIKBwCkCAkAACBwgJ8IAwFuA/D/AgAAgE0FARAAAAAAnjQCBAUAAABSBAIApAMJAAAgcICfAwMBggICAAoDAQMCAwMDBAQAADBAAwUEAABQQAMGAwcEACBwgAAFCAEYAAAAAAAAAAAAAAAAAAACAAEAAAAAAQAAAAAAAAABAAAAAAAA/gAGAAAAAAAAAAEGAAAAAAsCAAAAACNNBAFaAAAAAEcEAgAAAACAqQMAAakDAQCBAQMEAQAAAG8EAQCkAgMAAAAgQJ8CAwH/AgAAAAAAAKQDBQAAAEBAUgQAAJ8DAgRRAw0ATQgHWgAAAABNCQFaAAAAAPEICAAJAAAAnjQCBQcAAABSCQIAUgoHAKQICAAAHGCAnwgDAW4D8v8CAACAggICAAkDAgMDAwQEAAAgQAMFBAAAQEADBgMHBAAcYIAAEgkBGAAAAAAAAAAAAAAAAAEAAQAAAAABAAAAAAABAAAAAAAA/gAFEwAAAAAGAAABAgAZowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIApwYAAACfAQICTQIB1gcAAAD/AwAAAAAAAOIECgDABQsAMAUEnggAAADABQwAMAUEWwkAAACfAgMAggIAAA0DCgQAAABAAwsDDAMNBAAAQEADDgMPAwgDCQUCCAkGAAYBAgABAQABGAAAAAAAAAABAAAAAAIAAAAAAQAADQAA8gABAAAAAAJ9lRrCYldPx/wY0N0y/Fs1DY0Ntk9RcMM=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:40:34
-- Luau version 6, Types version 3
-- Time taken: 0.003007 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    addMinimapCircle = function(arg1, arg2) -- Line 5, Named "addMinimapCircle"
        local var6
        if arg2.circle.name == nil then
            var6 = false
        else
            var6 = true
        end
        assert(var6, "minimap circle missing unique name")
        local module = {}
        var6 = ipairs(arg1)
        local ipairs_result1, ipairs_result2, ipairs_result3_2 = ipairs(arg1)
        for _, v in ipairs_result1, ipairs_result2, ipairs_result3_2 do
            if v.name ~= arg2.circle.name then
                table.insert(module, v)
            end
        end
        ipairs_result1 = table.insert
        ipairs_result1(module, arg2.circle)
        return module
    end;
    removeMinimapCircle = function(arg1, arg2) -- Line 18, Named "removeMinimapCircle"
        local var15
        if arg2.name == nil then
            var15 = false
        else
            var15 = true
        end
        assert(var15, "minimap circle missing unique name")
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
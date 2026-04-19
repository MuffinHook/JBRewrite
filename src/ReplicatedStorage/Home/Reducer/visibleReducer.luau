-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMLBXZhbHVlHGFjdGlvbi52YWx1ZSBtdXN0IG5vdCBiZSBuaWwGYXNzZXJ0CnNldFZpc2libGUNdG9nZ2xlVmlzaWJsZQRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQVSb2R1eA1jcmVhdGVSZWR1Y2VyAAMFAgAAAAAPTQQBzAAAAABHBAIAAAAAgKkDAAGpAwEAgQEDBAEAAABvBAEApAIDAAAAIECfAgMBTQIBzAAAAACCAgIABAMBAwIDAwQAACBAAAUEARgAAAAAAAAAAAAAAAABAAAGAAAAAAMCAAAAAAJWAgAAggICAAAACQUBGAAACgAAAAAGAAABAgAYowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIApwYAAACfAQICTQIB1gcAAACpAwAA4gQKAMAFCwAwBQSJCAAAAMAFDAAwBQQdCQAAAJ8CAwCCAgAADQMGBAAAAEADBwMIAwkEAABAQAMKAwsDBAMFBQIICQYABgECAAEBAAEYAAAAAAAAAAEAAAAAAgAAAAEAAAQAAPsAAQAAAAACeo1G7YVQmv0+X8E9qjQMDQqVUZlISSzs

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:43:18
-- Luau version 6, Types version 3
-- Time taken: 0.000997 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer(false, {
    setVisible = function(arg1, arg2) -- Line 5, Named "setVisible"
        local var2
        if arg2.value == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "action.value must not be nil")
        return arg2.value
    end;
    toggleVisible = function(arg1, arg2) -- Line 9, Named "toggleVisible"
        return not arg1
    end;
})
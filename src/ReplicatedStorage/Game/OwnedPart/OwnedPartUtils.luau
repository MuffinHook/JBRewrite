-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMQBmFzc2VydAZpcGFpcnMGR2V0QWxsCEdldE93bmVyBXRhYmxlBmluc2VydAZnZXRBbGwISXNJblBvb2wHZ2V0UG9vbAVwcmludB5yZW1vdmluZyAlZCBpdGVtcyBmcm9tIHBvb2wgJXMETmFtZQZmb3JtYXQEX29iagdEZXN0cm95CWNsZWFuUG9vbAAECwIAAAAAKEcAAgAAAACAqQMAAakDAQC7AQMCpAIBAAAAAECfAgIBRwECAAAAAICpAwABqQMBALsBAwKkAgEAAAAAQJ8CAgH/AgAAAAAAAKQDAwAAACBAvAQA0AQAAACfBAIAnwMABFEDDAC8CAfDBQAAAJ8IAgKaCAgAAQAAAJ40AgUHAAAAUgkCAFIKBwCkCAgAABxggJ8IAwFuA/P/AgAAgIICAgAJAwEEAAAAQAMCBAAAIEADAwMEAwUDBgQAHGCAAAIHARgAAAAAAAAAAAEAAAAAAAAAAQABAAAAAAAAAQAAAAABAAAAAAAA/gAFAwAAAAALAgAAAAAsRwACAAAAAICpAwABqQMBALsBAwKkAgEAAAAAQJ8CAgFHAQIAAAAAgKkDAAGpAwEAuwEDAqQCAQAAAABAnwICAf8CAAAAAAAApAMDAAAAIEC8BADQBAAAAJ8EAgCfAwAEUQMQALwIB8MFAAAAnwgCApoIDAABAAAAvAgHrwYAAACfCAICDggHAJ40AgUHAAAAUgkCAFIKBwCkCAkAACBwgJ8IAwFuA+//AgAAgIICAgAKAwEEAAAAQAMCBAAAIEADAwMEAwgDBQMGBAAgcIAADQkBGAAAAAAAAAAAAQAAAAAAAAABAAEAAAAAAAABAAAAAAAAAAABAAAAAAAA/gAFDgAAAAAKAgEAAAcAAAEDBAwCHfsCAABNAgJeAAAAAFIDAABSBAEAnwIDAqQDAgAAABBAbwQDABwGAgBNBwG6BAAAALwEBI0FAAAAnwQEAJ8DAAGkAwcAAABgQFIEAgCfAwIEUQMFAE0IB24IAAAAvAgIUAkAAACfCAIBbgP6/wIAAICCAAEACgMJAwoEAAAQQAMLAwwDDQMCBAAAYEADDgMPABgQARgAAAAAAAABAAAAAAAAAAAAAQAAAAABAAAAAP8AAxkAAAAAAgAAAQIADqMAAAD/AAMAAAAAAMABAAAwAQDwAQAAAMABAgAwAQBeAwAAAMABBAASAAAAMAEAqQUAAACCAAIABgYAAwcGAQMJBgIDEAMAAQIBAAEYAAAAAQAACwAACwAAAAcBAAAAAAMbIu1D2G9Z7cpyRT3nIkptazr6Nynmh0I=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:38:22
-- Luau version 6, Types version 3
-- Time taken: 0.003562 seconds

local module_upvr = {
    getAll = function(arg1, arg2) -- Line 2, Named "getAll"
        if arg1 == nil then
        else
        end
        assert(true)
        if arg2 == nil then
        else
        end
        assert(true)
        for _, v in ipairs(arg1:GetAll()) do
            if v:GetOwner() == arg2 then
                table.insert({}, v)
            end
        end
        -- KONSTANTERROR: Expression was reused, decompilation is incorrect
        return {}
    end;
    getPool = function(arg1, arg2) -- Line 13, Named "getPool"
        if arg1 == nil then
        else
        end
        assert(true)
        if arg2 == nil then
        else
        end
        assert(true)
        for _, v_2 in ipairs(arg1:GetAll()) do
            if v_2:GetOwner() == arg2 and v_2:IsInPool() then
                table.insert({}, v_2)
            end
        end
        -- KONSTANTERROR: Expression was reused, decompilation is incorrect
        return {}
    end;
}
function module_upvr.cleanPool(arg1, arg2) -- Line 24
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
    local any_getPool_result1 = module_upvr.getPool(arg1, arg2)
    print("removing %d items from pool %s":format(#any_getPool_result1, arg2.Name))
    for _, v_3 in ipairs(any_getPool_result1) do
        v_3._obj:Destroy()
    end
end
return module_upvr
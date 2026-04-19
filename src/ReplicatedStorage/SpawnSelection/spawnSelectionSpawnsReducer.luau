-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMOBnNwYXducwRuYW1lDG1pc3NpbmcgbmFtZQZhc3NlcnQFdGl0bGUFdGFibGUGaW5zZXJ0EG1pbmltYXBTZXRTcGF3bnMEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUFUm9kdXgNY3JlYXRlUmVkdWNlcgACCwIAAAAAIP8CAAAAAAAATQMB2wAAAADGBAAAxgUAAGQDFgBNCQdaAQAAAIEBCQQCAAAAbwoCAKQIBAAAADBAnwgDAU0IB5oFAAAAKwgEAE0IB1oBAAAAMAgHmgUAAACeNAIFBwAAAFIJAgBSCgcApAgIAAAcYICfCAMBbgPp/wIAAACCAgIACQMBAwIDAwMEBAAAMEADBQMGAwcEABxggAAFCAEYAAABAAAAAAEAAAAAAAAAAQAAAQAAAAIAAAAAAAD7AAcGAAAAAAYAAAECABajAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgCnBgAAAJ8BAgJNAgHWBwAAAP8DAAAAAAAA4gQJAMAFCgAwBQSgCAAAAJ8CAwCCAgAACwMJBAAAAEADCgMLAwwEAABAQAMNAw4DCAUBCAYAAQABAAEYAAAAAAAAAAEAAAAAAgAAAAABAAD/AAEAAAAAAZAQ6i7XAERfye1/oe0BtPLgCP1aotSALw==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:45:59
-- Luau version 6, Types version 3
-- Time taken: 0.001383 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    minimapSetSpawns = function(arg1, arg2) -- Line 5, Named "minimapSetSpawns"
        local module = {}
        for _, v in arg2.spawns do
            assert(v.name, "missing name")
            if not v.title then
                v.title = v.name
            end
            table.insert(module, v)
        end
        return module
    end;
})
-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMTBE5hbWUDbWFwCEdhbWVNb2RlBE1vZGULR2V0Q2hpbGRyZW4KQ3Jld0JhdHRsZQV0YWJsZQZpbnNlcnQQZ2V0R2FtZU1vZGVOYW1lcwlHZXRUYWdnZWQTZ2V0R2FtZU1vZGVzUnVubmluZxVpc1RoaXNHYW1lTW9kZVJ1bm5pbmcEZ2FtZRFDb2xsZWN0aW9uU2VydmljZQpHZXRTZXJ2aWNlEVJlcGxpY2F0ZWRTdG9yYWdlB3JlcXVpcmUDU3RkClRhYmxlVXRpbHMABQIBAAAAAANNAQC6AAAAAIIBAgABAwEABwABGAAAAAgAAAAABAACAAAAFfsAAABNAACQAAAAAPsBAQBNAQGbAQAAAE0BAQ0CAAAAvAEBaAMAAACfAQICwAIEAJ8AAwKBNAAFBQAAAFICAABvAwUApAEIAAAcYICfAQMBggACAAkDAgMDAwQDBQYAAwYDBwMIBAAcYIABAAYJARgAAAAAAAAAAAAAAAAAAwAAAAAAAAEHAAAAAAMAAQAAAAb7AAAAbwIAALwAAAUBAAAAnwADAIIAAAACAwMDCgAOCwEYAAAAAAAADwAAAAAHAQEAAAAP+wEAAE0BAU0AAAAAnwEBBGQBBgBNBgW6AQAAAJoGAwAAAAAAqQYBAIIGAgBuAfn/AgAAAKkBAACCAQIAAgMLAwEAEQwBGAAAAAAAAQAAAAEA/gAFABIAAAAABQAAAQIAJKMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQEAAAAAQG8DBAC8AQEWAwAAAJ8BAwKkAgYAAABQQE0DAaEHAAAATQMDGAgAAACfAgIC/wMDAAAAAADABAkAEgACABIAAQAwBAMBCgAAAMAECwASAAAAMAQDTQwAAADABA0AEgADADAEA1kOAAAAggMCAA8DDQQAAABAAw4DDwMQAxEEAABQQAMSAxMGAQMJBgIDCwYDAwwDAQIDAQABGAAAAAAAAAABAAAAAAABAAAAAAAAAQACAAAAAAgAAAADAAAACQEAAAAABKxSejNWd2uPpYBJXO+7rljcSm1HnpYQMg==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:42:03
-- Luau version 6, Types version 3
-- Time taken: 0.001641 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module_upvr = {}
local TableUtils_upvr = require(ReplicatedStorage_upvr.Std.TableUtils)
function module_upvr.getGameModeNames() -- Line 6
    --[[ Upvalues[2]:
        [1]: TableUtils_upvr (readonly)
        [2]: ReplicatedStorage_upvr (readonly)
    ]]
    local any_map_result1 = TableUtils_upvr.map(ReplicatedStorage_upvr.GameMode.Mode:GetChildren(), function(arg1) -- Line 7
        return arg1.Name
    end)
    table.insert(any_map_result1, "CrewBattle")
    return any_map_result1
end
local CollectionService_upvr = game:GetService("CollectionService")
function module_upvr.getGameModesRunning() -- Line 14
    --[[ Upvalues[1]:
        [1]: CollectionService_upvr (readonly)
    ]]
    return CollectionService_upvr:GetTagged("GameMode")
end
function module_upvr.isThisGameModeRunning(arg1) -- Line 17
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
    for _, v in module_upvr.getGameModesRunning() do
        if v.Name == arg1 then
            return true
        end
    end
    return false
end
return module_upvr
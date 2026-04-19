-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMRA25ldx1MRUFERVJCT0FSRF9ESVNQTEFZX1RZUEVfRU5VTQtMZWFkZXJib2FyZAxzZXRtZXRhdGFibGUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUDU3RkCkJhc2VPYmplY3QGQmluZGVyBnNjcmlwdAZQYXJlbnQWQ3Jld3NTdXJmYWNlR3VpRGlzcGxheRpQZXJzaXN0ZW50Q3Jld0JhdHRsZUNvbnN0cwdfX2luZGV4GUNSRVdfTEVBREVSQk9BUkRfVEFHX05BTUUAAgUBAwAAABL7AQAATQEB7wAAAABSAgAA+wMBAE0DAwwBAAAATQMD8AIAAACfAQMC+wQCAJ49AQQEAAAAUgMBAKQCBAAAADBAnwIDAYIBAgAFAwEDAgMDAwQEAAAwQAALAQEYAAAAAAAAAAAAAAEAAAAAAAACDAAAAAAJAAABAgA/owAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAoQYAAABNAgJLBwAAAJ8BAgKkAgUAAABAQE0DAKEGAAAATQMDfwgAAACfAgICpAMFAAAAQECkBAoAAACQQE0EBCQLAAAATQQEfgwAAACfAwICpAQFAAAAQECkBQoAAACQQE0FBSQLAAAATQUF5w0AAACfBAIC/wUCAAAAAAAwBQVuDgAAAJ49BQUBAAAAUgcFAFIIAQCkBhAAAADwQJ8GAwHABhEAEgADABIABAASAAUAMAYF7xIAAABNBgLvEgAAAE0HBBITAAAAUggFAJ8GAwCCBgAAFAMFBAAAAEADBgMHAwgEAABAQAMJAwoDCwMMBAAAkEADDQMOAw8DEAMEBAAA8EAGAAMBAxEBAAEAARgAAAAAAAAAAQAAAAAAAAEAAAAAAAABAAAAAAAAAAABAAAAAAAAAAACAAEAAQAAAAAAAAIAAAAAAAcAAAAAAAABAAAAAAGfTqmelGAsOaNMjDVlJ5lm71a+6q2Kw58=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:44:43
-- Luau version 6, Types version 3
-- Time taken: 0.001291 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PersistentCrewBattleConsts_upvr = require(script.Parent.PersistentCrewBattleConsts)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, require(ReplicatedStorage.Std.BaseObject))
local CrewsSurfaceGuiDisplay_upvr = require(script.Parent.CrewsSurfaceGuiDisplay)
function module_upvr.new(arg1) -- Line 11
    --[[ Upvalues[3]:
        [1]: CrewsSurfaceGuiDisplay_upvr (readonly)
        [2]: PersistentCrewBattleConsts_upvr (readonly)
        [3]: module_upvr (readonly)
    ]]
    local any_new_result1 = CrewsSurfaceGuiDisplay_upvr.new(arg1, PersistentCrewBattleConsts_upvr.LEADERBOARD_DISPLAY_TYPE_ENUM.Leaderboard)
    setmetatable(any_new_result1, module_upvr)
    return any_new_result1
end
return require(ReplicatedStorage.Std.Binder).new(PersistentCrewBattleConsts_upvr.CREW_LEADERBOARD_TAG_NAME, module_upvr)
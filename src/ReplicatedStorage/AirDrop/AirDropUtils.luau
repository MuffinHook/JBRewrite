-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMdEE5vIHBsYXllciBwYXNzZWQGYXNzZXJ0H0lOX0FNQlVMQU5DRV9TVFJFVENIRVJfT0JKX05BTUUORmluZEZpcnN0Q2hpbGQFVmFsdWUfZ2V0UGxheWVySXNJbkFtYnVsYW5jZVN0cmV0Y2hlcgZ0eXBlb2YHYm9vbGVhbhtJbmNvcnJlY3QgdmFsdWUgdHlwZSBwYXNzZWQISW5zdGFuY2UDbmV3CUJvb2xWYWx1ZQROYW1lBlBhcmVudB9zZXRQbGF5ZXJJc0luQW1idWxhbmNlU3RyZXRjaGVyC2lzVklQU2VydmVyCkdldFBsYXllcnMEbWF0aANtaW4eZ2V0R3VhcmRIZWFsdGhEZWJ1ZmZNdWx0aXBsaWVyBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlB0FpckRyb3ANQWlyRHJvcENvbnN0cwdQbGF5ZXJzA0FwcAhSdW5VdGlscwAEBAEBAAAAE4EBAAUAAAAAUgIAAG8DAACkAQIAAAAQQJ8BAwH7AwAATQMDzwMAAAC8AQADBAAAAJ8BAwIrAQIAqQIAAIICAgBNAgHsBQAAAIICAgAGAwEDAgQAABBAAwMDBAMFAAgGARgAAAAAAAAAAQAAAAAAAQEAAgAACQAAAAAGAgEAAAAtgQEABQAAAABSAwAAbwQAAKQCAgAAABBAnwIDAbssAQNSBQEApAQEAAAAMECfBAIC8AQCAAUAAACpAwABqQMBAIEBAwQGAAAAbwQGAKQCAgAAABBAnwIDAfsEAABNBATPBwAAALwCAAMIAAAAnwIDAisCDACkAwsAACiQgG8EDACfAwICUgIDAPsDAABNAwPPBwAAADADAroNAAAAMAACJA4AAAAwAQLsDwAAAKkDAQCCAwIAEAMBAwIEAAAQQAMHBAAAMEADCAMJAwMDBAMKAwsEACiQgAMMAw0DDgMFABAPARgAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAgAAAAAAAQEAAAAAAQAAAAABAAIAAQARAAAAAAQAAgAAABb7AAAATQAALAAAAACfAAECDgACAIwAAQCCAAIA+wIBALwCAqsBAAAAnwICAhwBAgCBEwEEAgAAAG8CAgCkAAUAABAwgJ8AAwL1AwIAPgIDB5UBAgaCAQIACAMQAxECAAAAAAAAPkADEgMTBAAQMIACAAAAAAAA4D8CAAAAAAAATkAAHRQBGAAAAAAAAQAEAAAAAAAAAAAAAAIAAAEeAAAAAAYAAAECACujAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgCDBgAAAE0CAkkHAAAAnwECAqQCAQAAAABAbwQIALwCAhYDAAAAnwIDAqQDBQAAAEBATQQAwQkAAABNBARCCgAAAJ8DAgL/BAMAAAAAAMAFCwASAAEAMAUE6wwAAADABQ0AEgABADAFBJ8OAAAAwAUPABIAAwASAAIAMAUEKRAAAACCBAIAEQMVBAAAAEADFgMXAxgEAABAQAMZAxoDGwMcAx0GAAMGBgEDDwYCAxQDAAECAQABGAAAAAAAAAABAAAAAAAAAQAAAAAAAQAAAAAAAAIAAgAAAAgAAAANAAAAAAsBAAAAAANyvhKuXEwRrRmw4DdADZxyAqYF2kB6eK8=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:40:05
-- Luau version 6, Types version 3
-- Time taken: 0.002305 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AirDropConsts_upvr = require(ReplicatedStorage.AirDrop.AirDropConsts)
local module = {
    getPlayerIsInAmbulanceStretcher = function(arg1) -- Line 8, Named "getPlayerIsInAmbulanceStretcher"
        --[[ Upvalues[1]:
            [1]: AirDropConsts_upvr (readonly)
        ]]
        assert(arg1, "No player passed")
        local SOME = arg1:FindFirstChild(AirDropConsts_upvr.IN_AMBULANCE_STRETCHER_OBJ_NAME)
        if not SOME then
            return false
        end
        return SOME.Value
    end;
    setPlayerIsInAmbulanceStretcher = function(arg1, arg2) -- Line 16, Named "setPlayerIsInAmbulanceStretcher"
        --[[ Upvalues[1]:
            [1]: AirDropConsts_upvr (readonly)
        ]]
        local var5 = arg1
        assert(var5, "No player passed")
        if typeof(arg2) ~= "boolean" then
            var5 = false
        else
            var5 = true
        end
        assert(var5, "Incorrect value type passed")
        if not arg1:FindFirstChild(AirDropConsts_upvr.IN_AMBULANCE_STRETCHER_OBJ_NAME) then
            local BoolValue = Instance.new("BoolValue")
            BoolValue.Name = AirDropConsts_upvr.IN_AMBULANCE_STRETCHER_OBJ_NAME
            BoolValue.Parent = arg1
        end
        BoolValue.Value = arg2
        return true
    end;
}
local RunUtils_upvr = require(ReplicatedStorage.App.RunUtils)
local Players_upvr = game:GetService("Players")
function module.getGuardHealthDebuffMultiplier() -- Line 29
    --[[ Upvalues[2]:
        [1]: RunUtils_upvr (readonly)
        [2]: Players_upvr (readonly)
    ]]
    if RunUtils_upvr.isVIPServer() then
        return 1
    end
    return (30 - math.min(#Players_upvr:GetPlayers(), 30)) / 60 + 0.5
end
return module
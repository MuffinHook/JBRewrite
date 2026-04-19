-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMYBnR5cGVvZgZzdHJpbmcVSW52YWxpZCBjbGFuSWQgcGFzc2VkBmFzc2VydB1DTEFOX0lTX1JFQURJRURfVVBfTU9ERUxfTkFNRQ5GaW5kRmlyc3RDaGlsZAhJbnN0YW5jZQNuZXcJQm9vbFZhbHVlBE5hbWUGUGFyZW50B0Rlc3Ryb3kSc2V0SXNDbGFuUmVhZGllZFVwEmdldElzQ2xhblJlYWRpZWRVcBRvYnNlcnZlQ2hpbGRyZW5OYW1lZBZvYnNlcnZlSXNDbGFuUmVhZGllZFVwBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlD0NsYW5NYXRjaG1ha2luZxVDbGFuTWF0Y2htYWtpbmdDb25zdHMDU3RkD1J4SW5zdGFuY2VVdGlscwAEBgICAAAAK7ssAANSBQAApAQBAAAAAECfBAIC8AQCAAIAAACpAwABqQMBAIEBAwQDAAAAbwQDAKQCBQAAAEBAnwIDAfsCAAD7BAEATQQEtwYAAAC8AgIDBwAAAJ8CAwJSBQAAvAMCAwcAAACfAwMCDgELACsDCQCkBAoAACSAgG8FCwCfBAICUgMEADAAA7oMAAAAMAIDJA0AAACCAAEADgMDALwEA1AOAAAAnwQCAYIAAQAPAwEEAAAAQAMCAwMDBAQAAEBAAwUDBgMHAwgEACSAgAMJAwoDCwMMAAcNARgAAAAAAAAAAAAAAAAAAAABAAAAAAAAAQAAAAEBAQAAAAABAAEAAgIBAAACCAAAAAAFAQIAAAAiuywAA1IEAACkAwEAAAAAQJ8DAgLwAwIAAgAAAKkCAAGpAgEAgQECBAMAAABvAwMApAEFAAAAQECfAQMB+wEAAPsDAQBNAwO3BgAAALwBAQMHAAAAnwEDAlIEAAC8AgEDBwAAAJ8CAwIrAgIAqQMAAIIDAgBHAgIAAAAAgKkDAAGpAwEAggMCAAgDAQQAAABAAwIDAwMEBAAAQEADBQMGABkOARgAAAAAAAAAAAAAAAAAAAABAAAAAAAAAQAAAAEBAAIAAAAAGgAAAAAHAgMAAAAP+wIAAPsEAQBNBAS3AAAAALwCAgMBAAAAnwIDAvsDAgBNAwOtAgAAAFIEAgBSBQAAUgYBAJ8DBACCAwAAAwMFAwYDDwAiEAEYAAAAAAAAAAEAAAAAAAAAIwAAAAAFAAABAgAoowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIA3gYAAABNAgL3BwAAAJ8BAgKkAgUAAABAQE0DAKEIAAAATQMDUgkAAACfAgIC/wMDAAAAAADABAoAEgAAABIAAQAwBANSCwAAAMAEDAASAAAAEgABADAEA0YNAAAAwAQOABIAAAASAAEAEgACADAEAyEPAAAAggMCABADEQQAAABAAxIDEwMUBAAAQEADFQMWAxcDGAYAAw0GAQMOBgIDEAMAAQIBAAEYAAAAAAAAAAEAAAAAAAABAAAAAAAAAgACAAAAABIAAAAACQAAAAAABAEAAAAAAwoeptErAMyimv3vY8W2Amp6BrGlONrM0A==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:41:12
-- Luau version 6, Types version 3
-- Time taken: 0.002735 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local ClanMatchmakingConsts_upvr = require(ReplicatedStorage_upvr.ClanMatchmaking.ClanMatchmakingConsts)
local module = {
    setIsClanReadiedUp = function(arg1, arg2) -- Line 7, Named "setIsClanReadiedUp"
        --[[ Upvalues[2]:
            [1]: ReplicatedStorage_upvr (readonly)
            [2]: ClanMatchmakingConsts_upvr (readonly)
        ]]
        local var4
        if typeof(arg1) ~= "string" then
            var4 = false
        else
            var4 = true
        end
        assert(var4, "Invalid clanId passed")
        var4 = ReplicatedStorage_upvr:FindFirstChild(ClanMatchmakingConsts_upvr.CLAN_IS_READIED_UP_MODEL_NAME):FindFirstChild(arg1)
        if arg2 then
            if not var4 then
                var4 = Instance.new("BoolValue")
                var4.Name = arg1
                var4.Parent = ReplicatedStorage_upvr:FindFirstChild(ClanMatchmakingConsts_upvr.CLAN_IS_READIED_UP_MODEL_NAME)
            end
        elseif var4 then
            var4:Destroy()
        end
    end;
    getIsClanReadiedUp = function(arg1) -- Line 25, Named "getIsClanReadiedUp"
        --[[ Upvalues[2]:
            [1]: ReplicatedStorage_upvr (readonly)
            [2]: ClanMatchmakingConsts_upvr (readonly)
        ]]
        -- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
        local var6
        if typeof(arg1) ~= "string" then
            var6 = false
        else
            var6 = true
        end
        assert(var6, "Invalid clanId passed")
        var6 = ReplicatedStorage_upvr:FindFirstChild(ClanMatchmakingConsts_upvr.CLAN_IS_READIED_UP_MODEL_NAME):FindFirstChild(arg1)
        if not var6 then
            return false
        end
        if var6 == nil then
        else
        end
        return true
    end;
}
local RxInstanceUtils_upvr = require(ReplicatedStorage_upvr.Std.RxInstanceUtils)
function module.observeIsClanReadiedUp(arg1, arg2) -- Line 34
    --[[ Upvalues[3]:
        [1]: ReplicatedStorage_upvr (readonly)
        [2]: ClanMatchmakingConsts_upvr (readonly)
        [3]: RxInstanceUtils_upvr (readonly)
    ]]
    return RxInstanceUtils_upvr.observeChildrenNamed(ReplicatedStorage_upvr:FindFirstChild(ClanMatchmakingConsts_upvr.CLAN_IS_READIED_UP_MODEL_NAME), arg1, arg2)
end
return module
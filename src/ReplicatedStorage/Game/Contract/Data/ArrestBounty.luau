-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMUJEFycmVzdCBhIGNyaW1pbmFsIHdpdGggYSAlcysgYm91bnR5LghDdXJyZW5jeQdHZXRHb2FsBmZvcm1hdARtYXRoBnJhbmRvbQRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQhTZXR0aW5ncwhSZXNvdXJjZQZGb3JtYXQGTW9kdWxlCEVudW1UZWFtBlBvbGljZQZ0ZWFtSWQHbWVzc2FnZQRnb2FsCXJld2FyZEV4cAADBgEBAAAHAAABAwEIAgxvAQAA+wMAAE0DAwkBAAAAvAQAFQIAAACfBAIAnwMAALwBAY0DAAAAnwEAAIIBAAAEAwEDAgMDAwQABwABGAAAAAAAAAAAAAAAAAgAAAAABAAAAAAAB6QBAwAACBCAjAIFAIwDBgCfAQMCWwABAIIAAgAEAgAAAAAAQH9AAwUDBgQACBCAAAoAARgAAAAAAAAACwAAAAAFAAABAgAoowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQMAYgcAAABNAgPKBgAAAJ8BAgKkAgUAAABAQE0EAEAJAAAATQMErQgAAACfAgIC/wMDAAAAAABNBAFMCgAAAE0EBLILAAAAMAQDbwwAAADABA0AEgACADAEA5gOAAAAwAQPADAEAwoQAAAAjAQeADAEAwMRAAAAggMCABIDBwQAAABAAwgDCQMKBAAAQEADCwMMAw0DDgMPAxADEQYAAxIGAQMTAxQCAAEBAAEYAAAAAAAAAAEAAAAAAAABAAAAAAAAAgABAAAAAAABAAAAAwAAAwAAAQEAAAAAAmGCsQPTX29M7j423KAtQ30RmqZ3U0bbAg==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:35:24
-- Luau version 6, Types version 3
-- Time taken: 0.001332 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {
    teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Police;
}
local Format_upvr = require(ReplicatedStorage.Module.Format)
function module.message(arg1) -- Line 7
    --[[ Upvalues[1]:
        [1]: Format_upvr (readonly)
    ]]
    return "Arrest a criminal with a %s+ bounty.":format(Format_upvr.Currency(arg1:GetGoal()))
end
function module.goal() -- Line 10
    return math.random(5, 6) * 500
end
module.rewardExp = 30
return module
-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMaD01ha2VGdXp6eUZpbmRlcghHZXRUZWFtcwlUcmFuc2Zvcm0mTm8gdGVhbSB3aXRoIHRoYXQgbmFtZSBjb3VsZCBiZSBmb3VuZC4IVmFsaWRhdGUIR2V0TmFtZXMMQXV0b2NvbXBsZXRlBVBhcnNlCkdldFBsYXllcnMJVGVhbUNvbG9yBHRlYW0MUmVnaXN0ZXJUeXBlBXRlYW1zEE1ha2VMaXN0YWJsZVR5cGULdGVhbVBsYXllcnMJdGVhbUNvbG9yCnRlYW1Db2xvcnMEZ2FtZQVUZWFtcwpHZXRTZXJ2aWNlB3JlcXVpcmUGc2NyaXB0BlBhcmVudAZTaGFyZWQEVXRpbAhMaXN0YWJsZQAIBAECAAAADPsBAABNAQE9AAAAAPsCAQC8AgIxAQAAAJ8CAgCfAQACUgIBAFIDAACfAgIAggIAAAIDAQMCAAUDARgAAAAAAAAAAAIAAAAGAAAAAAQBAAAAAAgcAgAAjAMAALcDAgACAAAAqQEAAakBAQBvAgAAggEDAAEDBAALBQEYAAAAAAAAAAAMAAAAAAMBAQAAAAb7AQAATQEBxwAAAABSAgAAnwECAIIBAAABAwYADwcBGAAAAAAAABAAAAAAAgEAAAAAAhMBAACCAQIAAAATCAEYAAAUAAAAAAMBAAAAAAUTAQAAvAEBqwAAAACfAQIAggEAAAEDCQAeCAEYAAAAAAAfAAAAAAIBAAAAAAQTAQAATQEB2wAAAACCAQIAAQMKACgIARgAAAAAKQAAAAAGAQQAAAAibwMAAPsEAAC8AQDdAQAAAJ8BBAFvAwIA+wQBAE0EBCQDAAAA+wUAAJ8EAgC8AQDdAQAAAJ8BAAFvAwQA+wQCALwBAN0BAAAAnwEEAW8DBQD7BAMAvAEA3QEAAACfAQQBbwMGAPsEAQBNBAQkAwAAAPsFAwCfBAIAvAEA3QEAAACfAQABggABAAcDCwMMAw0DDgMPAxADEQAtAAEYAAAAAAABAAAAAAAAAAACAAAAAAIAAAAAAQAAAAAAAAAAAS4AAAAABgAAAQIATaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQKQCBwAAAGBATQICJAgAAABNAgIkCAAAAE0CAhIJAAAATQICngoAAACfAQIC4gIPAMADEAASAAEAEgAAADADAiELAAAAwAMRADADAnYMAAAAwAMSABIAAQAwAwKrDQAAAMADEwAwAwKbDgAAAOIDFQCpBAEAMAQDhhQAAABNBAIhCwAAADAEAyELAAAATQQCdgwAAAAwBAN2DAAAAE0EAqsNAAAAMAQDqw0AAADABBYAMAQDmw4AAADiBA8ATQUCIQsAAAAwBQQhCwAAAE0FAnYMAAAAMAUEdgwAAABNBQKrDQAAADAFBKsNAAAAwAUXADAFBJsOAAAAwAUYABIAAgASAAEAEgADABIABACCBQIAGQMSBAAAAEADEwMUAxUEAABAQAMWBAAAYEADFwMYAxkDAwMFAwcDCAUECwwNDgYABgEGAgYDAxoFBRQLDA0OBgQGBQYGBwABAgMEBQYBAAEYAAAAAAAAAAEAAAAAAAAAAAAAAAACAQAAAAAGAAAEAAAABAAABQEAAAEAAAABAAAAAQAAAAIAAAUBAAAAAQAAAAEAAAACAAAFAAAAAAABAAAAAAeH2zRV7+U7wIG9ovqbXgZj98MjIbUfXlQ=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:33:50
-- Luau version 6, Types version 3
-- Time taken: 0.003316 seconds

local Util_upvr = require(script.Parent.Parent.Shared.Util)
local tbl_upvr_2 = {}
local Teams_upvr = game:GetService("Teams")
function tbl_upvr_2.Transform(arg1) -- Line 5
    --[[ Upvalues[2]:
        [1]: Util_upvr (readonly)
        [2]: Teams_upvr (readonly)
    ]]
    return Util_upvr.MakeFuzzyFinder(Teams_upvr:GetTeams())(arg1)
end
function tbl_upvr_2.Validate(arg1) -- Line 11
    local var4
    if 0 >= #arg1 then
        var4 = false
    else
        var4 = true
    end
    return var4, "No team with that name could be found."
end
function tbl_upvr_2.Autocomplete(arg1) -- Line 15
    --[[ Upvalues[1]:
        [1]: Util_upvr (readonly)
    ]]
    return Util_upvr.GetNames(arg1)
end
local function Parse(arg1) -- Line 19
    return arg1[1]
end
tbl_upvr_2.Parse = Parse
local tbl_upvr_3 = {
    Listable = true;
    Transform = tbl_upvr_2.Transform;
    Validate = tbl_upvr_2.Validate;
    Autocomplete = tbl_upvr_2.Autocomplete;
}
local function Parse(arg1) -- Line 30
    return arg1[1]:GetPlayers()
end
tbl_upvr_3.Parse = Parse
local tbl_upvr = {
    Transform = tbl_upvr_2.Transform;
    Validate = tbl_upvr_2.Validate;
    Autocomplete = tbl_upvr_2.Autocomplete;
    Parse = function(arg1) -- Line 40, Named "Parse"
        return arg1[1].TeamColor
    end;
}
return function(arg1) -- Line 45
    --[[ Upvalues[4]:
        [1]: tbl_upvr_2 (readonly)
        [2]: Util_upvr (readonly)
        [3]: tbl_upvr_3 (readonly)
        [4]: tbl_upvr (readonly)
    ]]
    arg1:RegisterType("team", tbl_upvr_2)
    arg1:RegisterType("teams", Util_upvr.MakeListableType(tbl_upvr_2))
    arg1:RegisterType("teamPlayers", tbl_upvr_3)
    arg1:RegisterType("teamColor", tbl_upvr)
    arg1:RegisterType("teamColors", Util_upvr.MakeListableType(tbl_upvr))
end
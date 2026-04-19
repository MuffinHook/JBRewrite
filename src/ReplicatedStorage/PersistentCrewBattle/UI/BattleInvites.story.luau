-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMnBHR5cGUEbGlzdBBiYXR0bGVJbnZpdGVzU2V0CGNsYW5OYW1lF2JhdHRsZU51bVBsYXllcnNQZXJUZWFtCmNsYW5SYXRpbmcVb3Bwb3NpbmdDbGFuT3duZXJOYW1lBnJhbmtlZA5DZWlsaW5nRmFuQ3JldwViYWRjYwdCYWRCb3l6CGRpc3BhdGNoBGluaXQFcHJpbnQGYWNjZXB0CG9uQWNjZXB0B2RlY2xpbmUJb25EZWNsaW5lDWNyZWF0ZUVsZW1lbnQNU3RvcmVQcm92aWRlcgVzdG9yZQZyZW5kZXILd2lsbFVubW91bnQHdW5tb3VudAlDb21wb25lbnQDQXBwBmV4dGVuZAdyZXF1aXJlDUJhdHRsZUludml0ZXMGc2NyaXB0BlBhcmVudA5QZXJzaXN0ZW50Q3JldxNwZXJzaXN0ZW50Q3Jld1N0b3JlBW1vdW50BGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQVSb2FjdApSb2FjdFJvZHV4AAgIAQEAAAAv+wEAAOIDAgBvBAMAMAQDcQAAAAD/BAAAAgAAAOIFCQBvBgoAMAYF6AQAAACMBgUAMAYFcwUAAACMBtwFMAYFHwYAAABvBgsAMAYFhQcAAACpBgAAMAYF8ggAAADiBgkAbwcMADAHBugEAAAAjAcEADAHBnMFAAAAjAfQBzAHBh8GAAAAbwcLADAHBoUHAAAAqQcBADAHBvIIAAAAxQQFAwEAAAAwBAMLAQAAALwBAUwNAAAAnwEDAYIAAQAOAwEDAgUCAAEDAwMEAwUDBgMHAwgFBQQFBgcIAwkDCgMLAwwACQ0BGAAAAQAAAQABAQAAAQAAAQAAAQAAAQAAAgEAAAEAAAEAAAEAAAEAAAAA8wD+AAATCgAAAAAEAQAAAAAGpAEBAAAAAEBvAgIAUgMAAJ8BAwGCAAEAAwMOBAAAAEADDwAjEAEYAAAAAAABJAAAAAAEAQAAAAAGpAEBAAAAAEBvAgIAUgMAAJ8BAwGCAAEAAwMOBAAAAEADEQAmEgEYAAAAAAABJwAAAAAJAQQAAAAc+wEAAE0BAcoAAAAA+wIBAE0CAroBAAAA4gMDAPsEAgAwBAN+AgAAAP8EAAABAAAA+wUAAE0FBcoAAAAA+wYDAOIHBgDACAcAMAgHKgQAAADACAgAMAgHLQUAAACfBQMAxQQFAAEAAACfAQQAggEAAAkDEwMUAxUFAQIDEAMSBQIEBQYBBgICAQIeFgEYAAAAAAAAAAEAAAEAAQAAAAABAAADAAD8AAD9AB8AAAAAAQEAAAAAAYIAAQAAACwXARgALAAAAAACAAIAAAAG+wAAAE0AABIAAAAA+wEBAJ8AAgGCAAEAAQMYAC8AARgAAAAAAAEwAAAAAAcBAwAAADT7AQAATQEBiAAAAABvAwEAvAEBnAIAAACfAQMCpAIEAAAAMECkBAcAAABgQE0EBCQIAAAATQMERAUAAACfAgICpAMEAAAAMED7BAEATQQExQkAAABNBARSCgAAAJ8DAgLZBAAAEgADADAEARMLAAAA2QQBABICAAASAgIAEgADABIAAgAwBAGADAAAAMAEDQAwBAE0DgAAAPsEAABNBATkDwAAAPsFAABNBQXKEAAAAFIGAQCfBQICUgYAAJ8EAwLZBQMAEgIAABIABACCBQIAEQMZAxoDGwMcBAAAMEADHQMeBAAAYEADHwMgAyEDDQMWBgQDFwMiAxMEAAMEBQUAARgAAAAAAAAAAQAAAAAAAAAAAQAAAAAAAAABAAAAFQAAAAAAAA4AAAIAAAAAAAAAAAABAAAABgAAAAAEAAABAgAWowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAIQYAAACfAQICpAIFAAAAQEBNAwAtBwAAAJ8CAgLAAwgAEgABABIAAAASAAIAggMCAAkDIwQAAABAAyQDJQMcBAAAQEADJgMnBgYBBgEAARgAAAAAAAAAAQAAAAABAAAAAAIAAAAAAQAAAAAHfst5wfypx0b1k9iGFzMuaw7TbrVMDxPA

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:44:59
-- Luau version 6, Types version 3
-- Time taken: 0.002579 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
local RoactRodux_upvr = require(ReplicatedStorage_upvr.RoactRodux)
return function(arg1) -- Line 5
    --[[ Upvalues[3]:
        [1]: Roact_upvr (readonly)
        [2]: ReplicatedStorage_upvr (readonly)
        [3]: RoactRodux_upvr (readonly)
    ]]
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    local persistentCrewStore_upvr = require(ReplicatedStorage_upvr.PersistentCrew.persistentCrewStore)
    function any_extend_result1.init(arg1_2) -- Line 9
        --[[ Upvalues[1]:
            [1]: persistentCrewStore_upvr (readonly)
        ]]
        persistentCrewStore_upvr:dispatch({
            type = "battleInvitesSet";
            list = {{
                clanName = "CeilingFanCrew";
                battleNumPlayersPerTeam = 5;
                clanRating = 1500;
                opposingClanOwnerName = "badcc";
                ranked = false;
            }, {
                clanName = "BadBoyz";
                battleNumPlayersPerTeam = 4;
                clanRating = 2000;
                opposingClanOwnerName = "badcc";
                ranked = true;
            }};
        })
    end
    local BattleInvites_upvr = require(script.Parent.BattleInvites)
    function any_extend_result1.render(arg1_3) -- Line 30
        --[[ Upvalues[4]:
            [1]: Roact_upvr (copied, readonly)
            [2]: RoactRodux_upvr (copied, readonly)
            [3]: persistentCrewStore_upvr (readonly)
            [4]: BattleInvites_upvr (readonly)
        ]]
        return Roact_upvr.createElement(RoactRodux_upvr.StoreProvider, {
            store = persistentCrewStore_upvr;
        }, {Roact_upvr.createElement(BattleInvites_upvr, {
            onAccept = function(arg1_4) -- Line 35, Named "onAccept"
                print("accept", arg1_4)
            end;
            onDecline = function(arg1_5) -- Line 38, Named "onDecline"
                print("decline", arg1_5)
            end;
        })})
    end
    function any_extend_result1.willUnmount(arg1_6) -- Line 44
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 47
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end
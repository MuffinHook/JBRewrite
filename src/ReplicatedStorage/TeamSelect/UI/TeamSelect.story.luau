-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMZBXByaW50DnRlYW0gc2VsZWN0ZWQhDm9uVGVhbVNlbGVjdGVkB0NMSUNLRUQJb25DbGlja2VkB3VubW91bnQHcmVxdWlyZQpUZWFtU2VsZWN0BnNjcmlwdAZQYXJlbnQFbW91bnQNc2VydmVyQnV0dG9ucwR0ZXh0CXRleHRDb2xvcgxPRyBKQUlMQlJFQUsGQ29sb3IzB2Zyb21IZXgGZTg4ODM5EFZPSUNFQ0hBVCBTRVJWRVILVFJBREUgV09STEQEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlBVJvYWN0DWNyZWF0ZUVsZW1lbnQABwQBAAAAAAakAQEAAAAAQG8CAgBSAwAAnwEDAYIAAQADAwEEAAAAQAMCAAoDARgAAAAAAAELAAAAAAIAAAAAAAWkAAEAAAAAQG8BAgCfAAIBggABAAMDAQQAAABAAwQADwUBGAAAAAABEAAAAAACAAAAAAAFpAABAAAAAEBvAQIAnwACAYIAAQADAwEEAAAAQAMEABYFARgAAAAAARcAAAAAAgAAAAAABaQAAQAAAABAbwECAJ8AAgGCAAEAAwMBBAAAAEADBAAcBQEYAAAAAAEdAAAAAAIAAgAAAAb7AAAATQAAEgAAAAD7AQEAnwACAYIAAQABAwYAJQABGAAAAAAAASYAAAAACwECAAAAOqQBAQAAAABApAMEAAAAMEBNAwMkBQAAAE0CA60CAAAAnwECAvsCAABNAgLkBgAAAPsDAQBSBAEA4gUJAMAGCgAwBgVBBwAAAP8GAAADAAAA4gcOAMAIDwAwCAciCwAAAG8IEAAwCAfVDAAAAKQIEwAASBCBbwkUAJ8IAgIwCAe/DQAAAOIIFQDACRYAMAkIIgsAAABvCRcAMAkI1QwAAADiCRUAwAoYADAKCSILAAAAbwoZADAKCdUMAAAAxQYHBAEAAAAwBgXeCAAAAJ8DAwJSBAAAnwIDAtkDBAASAgAAEgACAIIDAgAaAwcEAAAAQAMIAwkEAAAwQAMKAwsDAwMMBQIHCAYAAwUDDQMOBQMLDA0GAQMPAxADEQQASBCBAxIFAgsMBgIDEwYDAxQFAAECAwQFAAEYAAAAAAAAAAAAAgAAAQAAAQAAAwABAQAAAwAAAQAAAAAAAgEAAAMAAAIBAAADAAAAAO4A/BrlHQAAAAYAAAAABAAAAQIAEqMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CACEGAAAAnwECAk0CAcoHAAAAwAMIABIAAQASAAIAggMCAAkDFQQAAABAAxYDFwMHBAAAQEADGAMZBgUBBQEAARgAAAAAAAAAAQAAAAACAAEAAAABAAAAAAbNtPLThXOLdn5k3eecSz92vazlp/9wmNI=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:47:00
-- Luau version 6, Types version 3
-- Time taken: 0.001830 seconds

local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
local createElement_upvr = Roact_upvr.createElement
return function(arg1) -- Line 5
    --[[ Upvalues[2]:
        [1]: Roact_upvr (readonly)
        [2]: createElement_upvr (readonly)
    ]]
    local tbl = {
        onTeamSelected = function(arg1_2) -- Line 10, Named "onTeamSelected"
            print("team selected!", arg1_2)
        end;
    }
    local tbl_4 = {}
    local tbl_2 = {}
    local function onClicked() -- Line 15
        print("CLICKED")
    end
    tbl_2.onClicked = onClicked
    tbl_2.text = "OG JAILBREAK"
    tbl_2.textColor = Color3.fromHex("e88839")
    local tbl_3 = {}
    local function onClicked() -- Line 22
        print("CLICKED")
    end
    tbl_3.onClicked = onClicked
    tbl_3.text = "VOICECHAT SERVER"
    tbl_4[1] = tbl_2
    tbl_4[2] = tbl_3
    tbl_4[3] = {
        onClicked = function() -- Line 28, Named "onClicked"
            print("CLICKED")
        end;
        text = "TRADE WORLD";
    }
    tbl.serverButtons = tbl_4
    local any_mount_result1_upvr = Roact_upvr.mount(createElement_upvr(require(script.Parent.TeamSelect), tbl), arg1)
    return function() -- Line 37
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end
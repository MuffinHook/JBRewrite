-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMTC09iamVjdExvY2FsC0xvY2FsUGxheWVyCVBsYXllckd1aQZMb29wZWQGVm9sdW1lCUdyb3VwTmFtZQxSb2JiZXJ5TXVzaWMKaGlkZVRvcGJhcgRpbml0BGdhbWUHUGxheWVycwpHZXRTZXJ2aWNlEVJlcGxpY2F0ZWRTdG9yYWdlB3JlcXVpcmUDU3RkBUF1ZGlvBEdhbWUGTGV2ZWwyDUxldmVsVUlTeXN0ZW0AAgUAAwAAACr7AAAATQAA0QAAAAD7AQEATQEBMQEAAABNAQGZAgAAAG8CAwDiAwYAqQQBADAEA7UEAAAAbwQHADAEA0sFAAAAnwAEAfsAAABNAADRAAAAAPsBAQBNAQExAQAAAE0BAZkCAAAAbwIIAOIDCgCpBAEAMAQDtQQAAABvBAsAMAQDSwUAAABvBAwAMAQD1gkAAACfAAQB+wACAE0AAJcNAAAAnwABAYIAAQAOAwEDAgMDAgAAsE+8JQJCAwQDBQUCBAUCmpmZmZmZuT8CAAC4D7wlAkIDBgUDBAUJApqZmZmZmdk/AwcDCAAICQEYAAAAAAAAAAAAAAEAAAEAAP4GAAAAAAAAAAAAAQAAAQAAAQAA/QYAAAABCgAAAAAGAAABAgAmowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBAQAAAABAbwMEALwBARYDAAAAnwEDAqQCBgAAAFBATQMBoQcAAABNAwPSCAAAAJ8CAgKkAwYAAABQQE0EAb0JAAAATQQE6QoAAABNBAS1CwAAAJ8DAgL/BAEAAAAAAMAFDAASAAIAEgAAABIAAwAwBQQTDQAAAIIEAgAOAwoEAAAAQAMLAwwDDQMOBAAAUEADDwMQAxEDEgMTBgADCQEAAQABGAAAAAAAAAABAAAAAAABAAAAAAAAAgAAAAAAAAAAAgABAAAAAAAQAQAAAAAB3UOBPeBY+OiB1TlyN+HdKq1blknvh+s8

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:40:30
-- Luau version 6, Types version 3
-- Time taken: 0.001101 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {}
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local Players_upvr = game:GetService("Players")
local LevelUISystem_upvr = require(ReplicatedStorage.Game.Level2.LevelUISystem)
function module.init() -- Line 8
    --[[ Upvalues[3]:
        [1]: Audio_upvr (readonly)
        [2]: Players_upvr (readonly)
        [3]: LevelUISystem_upvr (readonly)
    ]]
    Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 9742813686, {
        Looped = true;
        Volume = 0.1;
    })
    Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 9742811639, {
        Looped = true;
        Volume = 0.4;
        GroupName = "RobberyMusic";
    })
    LevelUISystem_upvr.hideTopbar()
end
return module
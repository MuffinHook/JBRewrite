-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMPCGlzU3R1ZGlvCWdldFRlYW1JZAhFbnVtVGVhbQhQcmlzb25lcgtjYW5JbnRlcmFjdARnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQNBcHAIUnVuVXRpbHMER2FtZQtQbGF5ZXJVdGlscwhSZXNvdXJjZQhTZXR0aW5ncwACAwEDAAAAF/sBAABNAQHqAAAAAJ8BAQIOAQIAqQEBAIIBAgD7AQEATQEBZAEAAABSAgAAnwECAvsCAgBNAgJMAgAAAE0CAp4DAAAA8QEDAAIAAACpAgAAggICAKkCAQCCAgIABAMBAwIDAwMEAAcFARgAAAAAAAEAAgAAAAABAAAAAAAAAQACAAgAAAAABgAAAQIAJaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAMEGAAAATQICQgcAAACfAQICpAIFAAAAQEBNAwC9CAAAAE0DA6YJAAAAnwICAqQDBQAAAEBATQQAYgoAAABNBATKCwAAAJ8DAgL/BAEAAAAAAMAFDAASAAEAEgACABIAAwAwBQRlDQAAAIIEAgAOAwYEAAAAQAMHAwgDCQQAAEBAAwoDCwMMAw0DDgMPBgADBQEAAQABGAAAAAAAAAABAAAAAAAAAQAAAAAAAAEAAAAAAAABAAIAAAAAAAsBAAAAAAFxguB2xsiTubIPLqucSLv+AZr3AkNGinc=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:41:24
-- Luau version 6, Types version 3
-- Time taken: 0.001189 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {}
local RunUtils_upvr = require(ReplicatedStorage.App.RunUtils)
local PlayerUtils_upvr = require(ReplicatedStorage.Game.PlayerUtils)
local Settings_upvr = require(ReplicatedStorage.Resource.Settings)
function module.canInteract(arg1) -- Line 7
    --[[ Upvalues[3]:
        [1]: RunUtils_upvr (readonly)
        [2]: PlayerUtils_upvr (readonly)
        [3]: Settings_upvr (readonly)
    ]]
    if RunUtils_upvr.isStudio() then
        return true
    end
    if PlayerUtils_upvr.getTeamId(arg1) ~= Settings_upvr.EnumTeam.Prisoner then
        return false
    end
    return true
end
return module
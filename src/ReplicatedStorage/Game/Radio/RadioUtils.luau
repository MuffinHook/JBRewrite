-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMPDURvZXNQbGF5ZXJPd24MRW51bUdhbWVwYXNzBlN0ZXJlbxBIYXNTdGVyb0dhbWVwYXNzDlByb21wdFB1cmNoYXNlCEdhbWVwYXNzG0NoZWNrT3JQcm9tcHRTdGVyZW9HYW1lcGFzcwRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQ5HYW1lcGFzc1N5c3RlbQ1HYW1lcGFzc1V0aWxzCFNldHRpbmdzCFJlc291cmNlAAMCAAIAAAAK+wAAAE0AABsAAAAA+wEBAE0BAY0BAAAATQEBHgIAAACfAAIAggAAAAMDAQMCAwMABwQBGAAAAAAAAAAAAAAIAAAAAAMAAwAAAA/7AAAATQAAggAAAACfAAECKwAJAPsBAQBNAQFhAQAAAPsCAgBNAgK9AgAAAE0CAh4DAAAAnwECAYIAAgAEAwQDBQMGAwMACgcBGAAAAAABAQAAAAAAAAAAAgsAAAAABgAAAQIAKqMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0DAL0HAAAATQIDjgYAAACfAQICpAIFAAAAQEBNBAC9BwAAAE0DBD4IAAAAnwICAqQDBQAAAEBATQUAYgoAAABNBAXKCQAAAJ8DAgL/BAIAAAAAAMAFCwASAAEAEgACADAFBIIMAAAAwAUNABIABAASAAIAEgADADAFBMAOAAAAggQCAA8DCAQAAABAAwkDCgMLBAAAQEADDAMGAw0DDgMPBgADBAYBAwcCAAEBAAEYAAAAAAAAAAEAAAAAAAABAAAAAAAAAQAAAAAAAAIAAQAAAAADAAAAAAAHAQAAAAACxOMoW9O9Un5T6bevQ+Zk87T7Py/2J0Ja

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:38:41
-- Luau version 6, Types version 3
-- Time taken: 0.001494 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GamepassUtils_upvr = require(ReplicatedStorage.Gamepass.GamepassUtils)
local module_upvr = {}
local GamepassSystem_upvr = require(ReplicatedStorage.Gamepass.GamepassSystem)
function module_upvr.HasSteroGamepass() -- Line 7
    --[[ Upvalues[2]:
        [1]: GamepassSystem_upvr (readonly)
        [2]: GamepassUtils_upvr (readonly)
    ]]
    return GamepassSystem_upvr.DoesPlayerOwn(GamepassUtils_upvr.EnumGamepass.Stereo)
end
local Settings_upvr = require(ReplicatedStorage.Resource.Settings)
function module_upvr.CheckOrPromptStereoGamepass() -- Line 10
    --[[ Upvalues[3]:
        [1]: module_upvr (readonly)
        [2]: GamepassUtils_upvr (readonly)
        [3]: Settings_upvr (readonly)
    ]]
    local any_HasSteroGamepass_result1 = module_upvr.HasSteroGamepass()
    if not any_HasSteroGamepass_result1 then
        GamepassUtils_upvr.PromptPurchase(Settings_upvr.Gamepass.Stereo)
    end
    return any_HasSteroGamepass_result1
end
return module_upvr
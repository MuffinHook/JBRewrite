-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMUDkRlYWwgJXMgZGFtYWdlBUNvbW1hB0dldEdvYWwGZm9ybWF0BG1hdGgGcmFuZG9tBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlCFNldHRpbmdzCFJlc291cmNlBkZvcm1hdAZNb2R1bGUIRW51bVRlYW0IQ3JpbWluYWwGdGVhbUlkB21lc3NhZ2UEZ29hbAlyZXdhcmRFeHAAAwYBAQAABwAAAQMBCAIMbwEAAPsDAABNAwPEAQAAALwEABUCAAAAnwQCAJ8DAAC8AQGNAwAAAJ8BAACCAQAABAMBAwIDAwMEAAcAARgAAAAAAAAAAAAAAAAIAAAAAAQAAAAAAAekAQMAAAgQgIwCEgCMAxYAnwEDAlsAAQCCAAIABAIAAAAAAABZQAMFAwYEAAgQgAAKAAEYAAAAAAAAAAsAAAAABQAAAQIAKKMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0DAGIHAAAATQIDygYAAACfAQICpAIFAAAAQEBNBABACQAAAE0DBK0IAAAAnwICAv8DAwAAAAAATQQBTAoAAABNBAR1CwAAADAEA28MAAAAwAQNABIAAgAwBAOYDgAAAMAEDwAwBAMKEAAAAIwEKAAwBAMDEQAAAIIDAgASAwcEAAAAQAMIAwkDCgQAAEBAAwsDDAMNAw4DDwMQAxEGAAMSBgEDEwMUAgABAQABGAAAAAAAAAABAAAAAAAAAQAAAAAAAAIAAQAAAAAAAQAAAAMAAAMAAAEBAAAAAAIog0GU9TnOQvTb811EAHxlWJtW4BpHK5U=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:35:28
-- Luau version 6, Types version 3
-- Time taken: 0.001260 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {
    teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Criminal;
}
local Format_upvr = require(ReplicatedStorage.Module.Format)
function module.message(arg1) -- Line 7
    --[[ Upvalues[1]:
        [1]: Format_upvr (readonly)
    ]]
    return "Deal %s damage":format(Format_upvr.Comma(arg1:GetGoal()))
end
function module.goal() -- Line 10
    return math.random(18, 22) * 100
end
module.rewardExp = 40
return module
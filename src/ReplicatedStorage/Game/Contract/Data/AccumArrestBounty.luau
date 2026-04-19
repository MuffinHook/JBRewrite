-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMUI0FycmVzdCAlcyB3b3J0aCBvZiBjcmltaW5hbCBib3VudHkuCEN1cnJlbmN5B0dldEdvYWwGZm9ybWF0BG1hdGgGcmFuZG9tBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlCFNldHRpbmdzCFJlc291cmNlBkZvcm1hdAZNb2R1bGUIRW51bVRlYW0GUG9saWNlBnRlYW1JZAdtZXNzYWdlBGdvYWwJcmV3YXJkRXhwAAMGAQEAAAcAAAEDAQgCDG8BAAD7AwAATQMDCQEAAAC8BAAVAgAAAJ8EAgCfAwAAvAEBjQMAAACfAQAAggEAAAQDAQMCAwMDBAAHAAEYAAAAAAAAAAAAAAAACAAAAAAGAAAAAAAJjAGIE6QDAwAACBCAjAQAAIwFBACfAwMCWwIDAEMAAQKCAAIABAIAAAAAAEBvQAMFAwYEAAgQgAAKAAEYAAAAAAAAAAAACwAAAAAFAAABAgAoowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQMAYgcAAABNAgPKBgAAAJ8BAgKkAgUAAABAQE0EAEAJAAAATQMErQgAAACfAgIC/wMDAAAAAABNBAFMCgAAAE0EBLILAAAAMAQDbwwAAADABA0AEgACADAEA5gOAAAAwAQPADAEAwoQAAAAjAQ8ADAEAwMRAAAAggMCABIDBwQAAABAAwgDCQMKBAAAQEADCwMMAw0DDgMPAxADEQYAAxIGAQMTAxQCAAEBAAEYAAAAAAAAAAEAAAAAAAABAAAAAAAAAgABAAAAAAABAAAAAwAAAwAAAQEAAAAAAgnRqFUrugOVgHP7EyGVULp5yb8hOxXCVA==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:35:22
-- Luau version 6, Types version 3
-- Time taken: 0.001016 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {
    teamId = require(ReplicatedStorage.Resource.Settings).EnumTeam.Police;
}
local Format_upvr = require(ReplicatedStorage.Module.Format)
function module.message(arg1) -- Line 7
    --[[ Upvalues[1]:
        [1]: Format_upvr (readonly)
    ]]
    return "Arrest %s worth of criminal bounty.":format(Format_upvr.Currency(arg1:GetGoal()))
end
function module.goal() -- Line 10
    return 5000 + math.random(0, 4) * 250
end
module.rewardExp = 60
return module
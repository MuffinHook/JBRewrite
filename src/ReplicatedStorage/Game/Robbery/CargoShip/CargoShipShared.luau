-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMdCXdvcmtzcGFjZQ1QYXRoQ2FyZ29TaGlwDFdhaXRGb3JDaGlsZAtHZXRDaGlsZHJlbgZOb2RlJWQGZm9ybWF0DkZpbmRGaXJzdENoaWxkBmFzc2VydApDYW5Db2xsaWRlDFRyYW5zcGFyZW5jeQhQb3NpdGlvbgV0YWJsZQZpbnNlcnQMQ2xvc2VSb2JiZXJ5A25ldwlTZXRQb2ludHMNU2V0Tm9kZU9mZnNldBFBcHByb3hpbWF0ZUxlbmd0aAxBcHByb3hMZW5ndGgUQXBwcm94TGVuZ3RoVHJhdmVsZWQRQ2xvc2VSb2JiZXJ5SW5kZXgHR2V0UGF0aARnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQpCZXppZXJQYXRoBEdhbWUFU3BlZWQAAgwAAQAABwAAAQMJEgJKxgAAAKQBAQAAAABAbwMCALwBAdMDAAAAnwEDAv8CAAAAAAAAjAUBALwGAWgEAAAAnwYCAhwDBgCMBAEAqAMhAG8JBQBSCwUAvAkJjQYAAACfCQMAvAcBAwcAAACfBwAATAEAAqQGCQAAAIBAnwYAAqkHAAAwBwbTCgAAAIwHAQAwBwbZCwAAAE0JBjsMAAAAnjQCBAkAAABSCAIApAcPAAA40ICfBwMBbwkQALwHBgMHAAAAnwcDAg4HAQBSAAUAiwPf//sDAABNAwPvEQAAAJ8DAQJSBgIAvAQD/hIAAACfBAMBjAYAAIwHAQC8BANfEwAAAJ8EBAGMBugDvAQDpBQAAACfBAMCMAQDNRUAAACMBAAAMAQD4RYAAAAwAAMpFwAAAIIDAgAYAwEEAAAAQAMCAwMDBAMFAwYDBwMIBAAAgEADCQMKAwsDDAMNBAA40IADDgMPAxADEQMSAxMDFAMVAAYWARgAAQAAAAAAAQABAAAAAAAAAQAAAAAAAAAAAAAAAQAAAQAAAQAAAAAAAAACAAAAAAH5CgAAAAEAAAABAAAAAAEAAAAAAAEAAAEAAQcAAAAABAAAAQIAGKMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0DAL0HAAAATQIDrwYAAACfAQIC/wICAAAAAACMAzIAMAMCLAgAAADAAwkAEgABADADAoIKAAAAggICAAsDFwQAAABAAxgDGQMaBAAAQEADGwMcAx0GAAMWAQABAAEYAAAAAAAAAAEAAAAAAAACAAEAAAEAAAAWAQAAAAABiOsTOvGaS00V6C3Ic7TSSfjzBE66L3k7

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:38:52
-- Luau version 6, Types version 3
-- Time taken: 0.001709 seconds

local module = {
    Speed = 50;
}
local BezierPath_upvr = require(game:GetService("ReplicatedStorage").Game.BezierPath)
function module.GetPath() -- Line 6
    --[[ Upvalues[1]:
        [1]: BezierPath_upvr (readonly)
    ]]
    local PathCargoShip = workspace:WaitForChild("PathCargoShip")
    local tbl = {}
    local var7
    for i = 1, #PathCargoShip:GetChildren() do
        local assert_result1 = assert(PathCargoShip:FindFirstChild("Node%d":format(i)))
        assert_result1.CanCollide = false
        assert_result1.Transparency = 1
        table.insert(tbl, assert_result1.Position)
        if assert_result1:FindFirstChild("CloseRobbery") then
        end
    end
    local any_new_result1 = BezierPath_upvr.new()
    any_new_result1:SetPoints(tbl)
    any_new_result1:SetNodeOffset(0, 1)
    any_new_result1.ApproxLength = any_new_result1:ApproximateLength(1000)
    any_new_result1.ApproxLengthTraveled = 0
    any_new_result1.CloseRobberyIndex = nil
    return any_new_result1
end
return module